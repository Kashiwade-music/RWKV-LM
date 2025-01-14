#include <stdio.h>
#include <assert.h>
#include "ATen/ATen.h"
#define MIN_VALUE (-1e38)
typedef at::BFloat16 bf16;

__global__ void kernel_forward(const int B, const int T, const int C,
                               const float *__restrict__ const _w, const bf16 *__restrict__ const _u, const bf16 *__restrict__ const _k, const bf16 *__restrict__ const _v,
                               bf16 *__restrict__ const _y) {
    const int idx = blockIdx.x * blockDim.x + threadIdx.x;
    const int _b = idx / C;
    const int _c = idx % C;
    const int _offset = _b * T * C + _c;

    float u = float(_u[_c]);
    float w = _w[_c];
    const bf16 *__restrict__ const k = _k + _offset;
    const bf16 *__restrict__ const v = _v + _offset;
    bf16 *__restrict__ const y = _y + _offset;

    // aa and bb are running sums divided by exp(pp) (to avoid overflow)
    float aa = 0, bb = 0, pp = MIN_VALUE;
    for (int i = 0; i < T; i++) {
        const int ii = i * C;
        const float kk = float(k[ii]);
        const float vv = float(v[ii]);

        float ww = u + kk;
        float p = max(pp, ww);
        float e1 = exp(pp - p);
        float e2 = exp(ww - p);
        y[ii] = bf16((e1 * aa + e2 * vv) / (e1 * bb + e2));
        
        ww = w + pp;
        p = max(ww, kk);
        e1 = exp(ww - p);
        e2 = exp(kk - p);
        aa = e1 * aa + e2 * vv;
        bb = e1 * bb + e2;
        pp = p;
    }

    /*
    float aa = 0, bb = 0, pp = MIN_VALUE;

    for文 1ループ目
        const int ii = i * C
        const float kk = float(k[ii]) = k[i * C]
        const float vv = float(v[ii]) = v[i * C]

        float ww = u + kk = u + k[i * C]
        float p = max(pp, ww) = max(MIN_VALUE, u + k[i * C]) = u + k[i * C]
        float e1 = exp(pp - p) = exp(MIN_VALUE - (u + k[i * C])) = 0
        float e2 = exp(ww - p) = exp((u + k[i * C]) - (u + k[i * C])) = 1
        y[ii] = bf16((e1 * aa + e2 * vv) / (e1 * bb + e2))
              = bf16((0 * 0 + 1 * v[i * C]) / (0 * 0 + 1))
              = bf16(v[i * C])
      
        ww = w + pp = w + MIN_VALUE
        p = max(ww, kk) = max(w + MIN_VALUE, k[i * C]) = k[i * C]
        e1 = exp(ww - p) = exp((w + MIN_VALUE) - k[i * C]) = 0
        e2 = exp(kk - p) = exp(k[i * C] - k[i * C]) = 1
        aa = e1 * aa + e2 * vv = 0 * 0 + 1 * v[i * C] = v[i * C]
        bb = e1 * bb + e2 = 0 * 0 + 1 = 1
        pp = p = k[i * C]
    
    for文 2ループ目
        const int ii = (i+1) * C
        const float kk = float(k[ii]) = k[(i+1) * C]
        const float vv = float(v[ii]) = v[(i+1) * C]

        float ww = u + kk = u + k[(i+1) * C]
        float p = max(pp, ww) = max(k[i * C], u + k[(i+1) * C])
        float e1 = exp(pp - p) = exp(k[i * C] - max(k[i * C], u + k[(i+1) * C]))
        float e2 = exp(ww - p) = exp((u + k[(i+1) * C]) - max(k[i * C], u + k[(i+1) * C]))
        y[ii] = bf16((e1 * aa + e2 * vv) / (e1 * bb + e2))
              = bf16(
                        (
                            exp(k[i * C] - max(k[i * C], u + k[(i+1) * C])) * v[i * C] 
                            + exp((u + k[(i+1) * C]) - max(k[i * C], u + k[(i+1) * C])) * v[(i+1) * C]
                        )
                        /
                        (
                            exp(k[i * C] - max(k[i * C], u + k[(i+1) * C])) * 1 
                            + exp((u + k[(i+1) * C]) - max(k[i * C], u + k[(i+1) * C]))
                        )
                    )
        ww = w + pp
        p = max(ww, kk)
        e1 = exp(ww - p)
        e2 = exp(kk - p)
        aa = e1 * aa + e2 * vv
        bb = e1 * bb + e2
        pp = p

    */

    /*
    [メモ] 20230723_
    この式は論文に書かれてる式とは違う。特にy[ii]=~~の式。
    もしかすると、k[i * C]はすでに計算済みの値、つまりk[i * C] = -(i-1-j)w+k とかになってるのかもしれない
    → なってなかった

    */
}

__global__ void kernel_backward(const int B, const int T, const int C,
                                const float *__restrict__ const _w, const bf16 *__restrict__ const _u, const bf16 *__restrict__ const _k, const bf16 *__restrict__ const _v,
                                const bf16 *__restrict__ const _y, const bf16 *__restrict__ const _gy,
                                bf16 *__restrict__ const _gw, bf16 *__restrict__ const _gu, bf16 *__restrict__ const _gk, bf16 *__restrict__ const _gv) {
    const int idx = blockIdx.x * blockDim.x + threadIdx.x;
    const int _b = idx / C;
    const int _c = idx % C;
    const int _offset = _b * T * C + _c;

    float u = float(_u[_c]);
    float w = _w[_c];
    const bf16 *__restrict__ const k = _k + _offset;
    const bf16 *__restrict__ const v = _v + _offset;
    const bf16 *__restrict__ const y = _y + _offset;
    const bf16 *__restrict__ const gy = _gy + _offset;
    bf16 *__restrict__ const gk = _gk + _offset;
    bf16 *__restrict__ const gv = _gv + _offset;

    float q[Tmax], r[Tmax];

    float gw = 0, gu = 0, aa = 0, bb = 0, ga = 0, gb = 0, pp = MIN_VALUE;
    for (int i = 0; i < T; i++) {
        const int ii = i * C;
        const float kk = float(k[ii]);
        const float vv = float(v[ii]);
        const float yy = float(y[ii]);

        float ww = u + kk;
        float p = max(pp, ww);
        float e1 = exp(pp - p);
        float e2 = exp(ww - p);
        const float qq = float(gy[ii]) / (e1 * bb + e2);
        gw += (ga - gb * yy) * e1 * qq;
        gu += (vv - yy) * e2 * qq;
        q[i] = qq;
        r[i] = ww - p;

        ww = w + pp;
        p = max(ww, kk);
        e1 = exp(ww - p);
        e2 = exp(kk - p);
        ga = e1 * (aa + ga);
        gb = e1 * (bb + gb);
        aa = e1 * aa + e2 * vv;
        bb = e1 * bb + e2;
        pp = p;
    }
    const int _offsetBC = _b * C + _c;
    _gw[_offsetBC] = bf16(gw * _w[_c]); // multiply by w because of w -> -exp(w) in python forward()
    _gu[_offsetBC] = bf16(gu);

    aa = 0, bb = 0, pp = MIN_VALUE;
    for (int i = T - 1; i >= 0; i--) {
        const int ii = i * C;
        const float kk = float(k[ii]);
        const float vv = float(v[ii]);
        const float yy = float(y[ii]);
        const float qq = q[i];
        const float rr = r[i];

        float e1 = qq * exp(rr);
        float e2 = exp(kk + pp);
        gk[ii] = bf16(e1 * (vv - yy) + e2 * (aa * vv + bb));
        gv[ii] = bf16(e1 + e2 * aa);

        const float ww = w + pp;
        const float www = rr - u - kk;
        const float p = max(ww, www);
        e1 = exp(ww - p);
        e2 = qq * exp(www - p);
        aa = e1 * aa + e2;
        bb = e1 * bb - e2 * yy;
        pp = p;
    }
}

void cuda_forward(int B, int T, int C, float *w, bf16 *u, bf16 *k, bf16 *v, bf16 *y) {
    dim3 threadsPerBlock( min(C, 32) ); // requires --maxrregcount 60 for optimal performance
    assert(B * C % threadsPerBlock.x == 0);
    dim3 numBlocks(B * C / threadsPerBlock.x);
    kernel_forward<<<numBlocks, threadsPerBlock>>>(B, T, C, w, u, k, v, y);
}

void cuda_backward(int B, int T, int C, float *w, bf16 *u, bf16 *k, bf16 *v, bf16 *y, bf16 *gy, bf16 *gw, bf16 *gu, bf16 *gk, bf16 *gv) {
    dim3 threadsPerBlock( min(C, 32) ); // requires --maxrregcount 60 for optimal performance
    assert(B * C % threadsPerBlock.x == 0);
    dim3 numBlocks(B * C / threadsPerBlock.x);
    kernel_backward<<<numBlocks, threadsPerBlock>>>(B, T, C, w, u, k, v, y, gy, gw, gu, gk, gv);
}
