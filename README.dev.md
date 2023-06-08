# Setup

1. install rye
2. rye sync

## train
- example: train a simple L12-D768 RWKV on dummy data
```sh
python train.py --load_model "" --wandb "" --proj_dir "out" \
--data_file "" --data_type "dummy" --vocab_size 0 \
--ctx_len 128 --epoch_steps 1000 --epoch_count 20 --epoch_begin 0 --epoch_save 10 \
--micro_bsz 16 --n_layer 12 --n_embd 768 --pre_ffn 0 --head_qk 0 \
--lr_init 6e-4 --lr_final 1e-5 --warmup_steps 0 --beta1 0.9 --beta2 0.99 --adam_eps 1e-8 \
--accelerator gpu --devices 2 --precision bf16 --strategy deepspeed_stage_2 --grad_cp 0
```

- example: train a simple L6-D512 RWKV from scratch on enwik8
```sh
python train.py --load_model "" --wandb "" --proj_dir "out" \
--data_file "../data/enwik8" --data_type "utf-8" --vocab_size 0 \
--ctx_len 512 --epoch_steps 5000 --epoch_count 500 --epoch_begin 0 --epoch_save 5 \
--micro_bsz 12 --n_layer 6 --n_embd 512 --pre_ffn 0 --head_qk 0 \
--lr_init 8e-4 --lr_final 1e-5 --warmup_steps 0 --beta1 0.9 --beta2 0.99 --adam_eps 1e-8 \
--accelerator gpu --devices 2 --precision bf16 --strategy deepspeed_stage_1 --grad_cp 0
```

- RWKV 14B Layers=40 Model_Dimension=5120
```sh
python train.py --load_model "" --wandb "" --proj_dir "out" \
--data_file "../data/enwik8" --data_type "utf-8" --vocab_size 0 \
--ctx_len 512 --epoch_steps 5000 --epoch_count 500 --epoch_begin 0 --epoch_save 10 \
--micro_bsz 12 --n_layer 40 --n_embd 5120 --pre_ffn 0 --head_qk 0 \
--lr_init 8e-4 --lr_final 1e-5 --warmup_steps 0 --beta1 0.9 --beta2 0.99 --adam_eps 1e-8 \
--accelerator gpu --devices 2 --precision bf16 --strategy deepspeed_stage_1 --grad_cp 0
```

## fine tuning
- 14Bモデル
```sh
python train.py --load_model "../pretrained_models/RWKV-4-Pile-14B-20230313-ctx8192-test1050.pth" --wandb "" --proj_dir "out" \
--data_file "../data/enwik8" --data_type "utf-8" --vocab_size 0 \
--ctx_len 512 --epoch_steps 200 --epoch_count 1000 --epoch_begin 0 --epoch_save 10 \
--micro_bsz 12 --n_layer 40 --n_embd 5120 --pre_ffn 0 --head_qk 0 \
--lr_init 1e-5 --lr_final 1e-5 --warmup_steps 0 --beta1 0.9 --beta2 0.999 --adam_eps 1e-8 \
--accelerator gpu --devices 2 --precision fp16 --strategy deepspeed_stage_2_offload --grad_cp 1
```

- 7Bモデル
  - batch sizeを1にしてもなお動かない
```sh
python train.py --load_model "../pretrained_models/RWKV-4-Pile-7B-20230406-ctx8192-test949.pth" --wandb "" --proj_dir "out" \
--data_file "/home/rtakahashi/workspaces/RWKV-LM/data/fine-tuning/akane-talk.npy" --data_type "numpy" --vocab_size 50277 \
--ctx_len 8192 --epoch_steps 5000 --epoch_count 500 --epoch_begin 0 --epoch_save 10 \
--micro_bsz 12 --n_layer 32 --n_embd 4096 --pre_ffn 0 --head_qk 0 \
--lr_init 8e-4 --lr_final 1e-5 --warmup_steps 0 --beta1 0.9 --beta2 0.99 --adam_eps 1e-8 \
--accelerator gpu --devices 2 --precision bf16 --strategy deepspeed --grad_cp 0
```

- 3Bモデル
```sh
python train.py --load_model "../pretrained_models/RWKV-4-Pile-3B-20221110-ctx4096.pth" --wandb "" --proj_dir "out" \
--data_file "/home/rtakahashi/workspaces/RWKV-LM/data/fine-tuning/akane-talk.npy" --data_type "numpy" --vocab_size 50277 \
--ctx_len 4096 --epoch_steps 5000 --epoch_count 500 --epoch_begin 0 --epoch_save 10 \
--micro_bsz 1 --n_layer 32 --n_embd 2560 --pre_ffn 0 --head_qk 0 \
--lr_init 8e-4 --lr_final 1e-5 --warmup_steps 0 --beta1 0.9 --beta2 0.99 --adam_eps 1e-8 \
--accelerator gpu --devices 2 --precision bf16 --strategy deepspeed --grad_cp 0
```

- 1.5Bモデル
  - nagoya.localで何とか動く
  - でもbatch sizeは2
  - 使用GPUMEM: 46393MB, 47905MB
```sh
python train.py --load_model "../pretrained_models/RWKV-4-Pile-1B5-20220929-ctx4096.pth" --wandb "" --proj_dir "out" \
--data_file "/home/rtakahashi/workspaces/RWKV-LM/data/fine-tuning/akane-talk.npy" --data_type "numpy" --vocab_size 50277 \
--ctx_len 4096 --epoch_steps 5000 --epoch_count 500 --epoch_begin 0 --epoch_save 10 \
--micro_bsz 2 --n_layer 24 --n_embd 2048 --pre_ffn 0 --head_qk 0 \
--lr_init 8e-4 --lr_final 1e-5 --warmup_steps 0 --beta1 0.9 --beta2 0.99 --adam_eps 1e-8 \
--accelerator gpu --devices 2 --precision bf16 --strategy deepspeed --grad_cp 0
```

- 430Mモデル
  - 余裕で動く@nagoya.local
  - 使用GPUMEM: 27879MB, 28303MB
```sh
python train.py --load_model "../pretrained_models/RWKV-4-Pile-430M-20220808-8066.pth" --wandb "" --proj_dir "out" \
--data_file "/home/rtakahashi/workspaces/RWKV-LM/data/fine-tuning/akane-talk.npy" --data_type "numpy" --vocab_size 50277 \
--ctx_len 1024 --epoch_steps 5000 --epoch_count 500 --epoch_begin 0 --epoch_save 10 \
--micro_bsz 20 --n_layer 24 --n_embd 1024 --pre_ffn 0 --head_qk 0 \
--lr_init 8e-4 --lr_final 1e-5 --warmup_steps 0 --beta1 0.9 --beta2 0.99 --adam_eps 1e-8 \
--accelerator gpu --devices 2 --precision bf16 --strategy deepspeed --grad_cp 0
```
  - 適当な設定で回してみる→ あとで
```sh
python train.py --load_model "../pretrained_models/RWKV-4-Pile-430M-20220808-8066.pth" --wandb "" --proj_dir "out" \
--data_file "/home/rtakahashi/workspaces/RWKV-LM/data/fine-tuning/akane-talk.npy" --data_type "numpy" --vocab_size 50277 \
--ctx_len 1024 --epoch_steps 1000 --epoch_count 100 --epoch_begin 0 --epoch_save 10 \
--micro_bsz 20 --n_layer 24 --n_embd 1024 --pre_ffn 0 --head_qk 0 \
--lr_init 8e-4 --lr_final 1e-5 --warmup_steps 0 --beta1 0.9 --beta2 0.99 --adam_eps 1e-8 \
--accelerator gpu --devices 2 --precision bf16 --strategy deepspeed --grad_cp 0
```

- 169Mモデル
  - 余裕で動く@nagoya.local
  - 使用GPUMEM: 27879MB, 28303MB
```sh
python train.py --load_model "../pretrained_models/RWKV-4-Pile-169M-20220807-8023.pth" --wandb "" --proj_dir "out" \
--data_file "/home/rtakahashi/workspaces/RWKV-LM/data/fine-tuning/akane-talk.npy" --data_type "numpy" --vocab_size 50277 \
--ctx_len 1024 --epoch_steps 5000 --epoch_count 500 --epoch_begin 0 --epoch_save 10 \
--micro_bsz 40 --n_layer 12 --n_embd 768 --pre_ffn 0 --head_qk 0 \
--lr_init 8e-4 --lr_final 1e-5 --warmup_steps 0 --beta1 0.9 --beta2 0.99 --adam_eps 1e-8 \
--accelerator gpu --devices 2 --precision bf16 --strategy deepspeed --grad_cp 0
```
