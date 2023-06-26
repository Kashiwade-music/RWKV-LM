# Setup
## rye
1. install rye
2. rye sync

## conda
- from myenv.yml

## inference
- 14B
  - RAM 56.8GB
  - 英語20単語/31.18秒
    - 1単語あたり1.509秒
      - > **Tokyo Institute of Technology and Tokyo Medical and Dental University, state-fun facilities that are aiming to merge in fiscal 2024, said Thursday that they have decided to name the new university “** Tokyo Institute of Technology and Tokyo Medical and Dental University.”
        > 
        > “We are not certain how to best handle the request from our alumni that wish to remain associated with the (old) Tokyo Institute of Technology. However, we will consider their wishes in a manner that can be accepted by the new university,” said Yoko Arase, the new university’s president.
        > 
        > The name of the new institution will be decided on during fiscal 2020 and will take effect in fiscal 2024.
        > 
        > The merger is expected to reduce costs through consolidation of administrative functions and management of the two universities’ facilities.
        > 
        > The two universities’ boards of directors will jointly decide on the name of the new institution.
        > 
        > The new institution will take the Tokyo Institute of Technology’s official English name, while the Tokyo Medical and Dental University will be known as the new university’s official Japanese name.
        > 
        > The two universities will merge their student registrations, with a merger of graduation, research, and entrance exams.
        > 
        > The new university will also retain the Tokyo Institute of Technology’s brand name, but change the university’s official English name to Tokyo Institute of Technology and Tokyo Medical and Dental University.
        > 
        > With the merger, the number of Tokyo Institute of Technology and Tokyo Medical and Dental University students is expected to rise to 28,000, up from around 22,000.
        > 
        > With the name change, the new university aims to be on a par with some of the best universities in the world, such as the Massachusetts Institute of Technology, in the U.S., and the Imperial College London in the U.K.
        - preprocess 57.19s
        - generation 498.8s
  - 日本語40文字/64.88秒
    - 1文字あたり1.622秒
    - > 2024年度の統合を目指す国立の東京工業大（東京）と東京医科歯科大（同）は、新大学の名称を「医療と工学のコンバージョン」としている。同大の川上明（まさのり）教授（工学）は「共に手を取り合うコンバージョンで、自分たちが何を目指すのか、しっかり相談し合うことが大事だ」と語った。
      > 
      > ＜幅広い支援が必要＞
      > 
      > アスキーグループの東京国際大（東京）は、事業規模の大きさから「大学大学院」と呼ばれる組織だ。同大の中尾敬司（かわべ・ゆういち）教授は「巨大なプログラムの規模は、工学と医学部の間で適切なバランスをとることが非常に難しい。各分野のノウハウや技術が混在している。国際的な基準に合わせてそれらを一つにまとめる必要がある」と話した。
      > 
      > 東京大大学院医学研究科（東京）の松本宏教授（医学
- 7B
  - RAM: 14.8GB

- 日本語
  - 14B (CPU / RAM: 56.8 GB)
    - > **2024年度の統合を目指す国立の東京工業大（東京）と東京医科歯科大（同）は、新大学の名称を「** 医療と工学のコンバージョン」としている。同大の川上明（まさのり）教授（工学）は「共に手を取り合うコンバージョンで、自分たちが何を目指すのか、しっかり相談し合うことが大事だ」と語った。
      > 
      > ＜幅広い支援が必要＞
      > 
      > アスキーグループの東京国際大（東京）は、事業規模の大きさから「大学大学院」と呼ばれる組織だ。同大の中尾敬司（かわべ・ゆういち）教授は「巨大なプログラムの規模は、工学と医学部の間で適切なバランスをとることが非常に難しい。各分野のノウハウや技術が混在している。国際的な基準に合わせてそれらを一つにまとめる必要がある」と話した。
      > 
      > 東京大大学院医学研究科（東京）の松本宏教授（医学
    - preprocess: 83.43秒
    - generation: 497.45秒
    - 241文字生成
    - 1文字あたり、2.06秒
  - 7B (CPU / 14.8GB)
    - > **2024年度の統合を目指す国立の東京工業大（東京）と東京医科歯科大（同）は、新大学の名称を「** 東京五種の神社」に決定した。一連の騒動を受けて学生らが求めていたもので、受験生の皆様からは不満の声が出ていた。
      > 
      > 【東京五種の神社（和学修館島）と東京五種の神社（東京都府中）】
      > 
      > 一連の騒動は６月８日に行われた学生統合の授業中に発生。日本初の３つの教育委員会（教育委員長／東京都・田村亮・同－東京医科歯科大・森重英・名古屋工業大・東京大・五種委員会）が一つの学部（大学が所属する）に分割したのは昨年８月。その後、統合前に予定されていた新学部「東京都医科歯科大」に統合した五種の神社の名称が、東京工業大と東京医
    - preprocess: 43.62秒
    - generation: 261.01秒
    - 250文字生成
    - 1文字あたり、1.04秒
  - 3B (CPU / 12.1GB)
    - > **2024年度の統合を目指す国立の東京工業大（東京）と東京医科歯科大（同）は、新大学の名称を「** 東京工業大学」に決定した。2018年1月18日に成立した東京工業大学の分割により、東京工業大学の名称を付けた大学の名称が変わる。
      > 
      > 大学の名称の変更に関しては、関係学部の卒業メンバーを取材し、東京工業大学を立ち上げる大学院の専門部門などについて分析。中央社会諮問センターの寺岡隆教授は、東京工業大学の名称を「東京工業大学」に変更するとしている。
      > 
      > 工学部の立て直しは、同大学の大学院の専門部門と組合による大学院の立ち上げにより成立した。大学院の専門部門と組合による大学院の立ち上げにより、卒業生が卒業後、大学院の教授や研究者を始めとした専門職に就くことは可能になる。
      > 
      > 一方、同大学の研究者たちは、新
    - preprocess: 16.78秒
    - generation: 103.2秒
    - 279文字生成
    - 1文字あたり、0.970秒
  - 1.5B (CPU / 6.2GB)
    - > **2024年度の統合を目指す国立の東京工業大（東京）と東京医科歯科大（同）は、新大学の名称を「** 「シーア川大学」と称する。だが、環境省が「東京」を歯科科として残していることから、中心部での「シーア」が大きくなる可能性もある。
      > 
      > このような危機に対処するため、東京市立大学に突入しようとする企業もいる。
      > 
      > 沖縄工業大学は、同大学に入学する際にガイドラインを守るため、新大学の名称を「京」にすることを決めた。
      > 
      > ガイドラインでは「新大学とは、中心部から行きたい大学、あるいは中心部からの人材の参入に寄与するようなイノベーション企業」とある。なお、中心部に限られるとされている。
      > 
      > 一方、中央医療法人は、同大の医療業界関係者の声明を受けて、同大学の名称を「中央医療機器学センター」としている。
      > 
      > ところで、こうした名称は、社会問題についての議論につ
    - preprocess: 8.04秒
    - generation: 51.7秒
    - 313文字生成
    - 1文字あたり、0.165秒
  - 430M (CPU / 860MB)
    - > **2024年度の統合を目指す国立の東京工業大（東京）と東京医科歯科大（同）は、新大学の名称を「** 大西研究所（ステラ学院）」と命名し、大学院の工学部を含む研究機関が入学するのを促した。研究会の長さは、15年で7月の累計業務の結果に反映される。
      > 
      > 歯科研究所は、東京工業大学の精巧な知識をつくり、日本を代表する研究研究所の研究グループを抜てきして、学習実験に熱を注ぐ研究を続ける。
      > 
      > 同研究所は「従業員は、従業員が他社の研究をこなすのを心がけ、それに準ずる結果を出す。これは、「工学における一般的な物質の調査」を、さらに大きく上げることができる。科学者は、東京学院大学の専門となる同大の学術人材の役割を科学的に守る。（河野 浩）」
      > 
      > 複
    - preprocess: 2.09秒
    - generation: 15.95秒
    - 260文字生成
    - 1文字あたり、0.061秒
  - 169M (CPU / 848MB)
    - > **2024年度の統合を目指す国立の東京工業大（東京）と東京医科歯科大（同）は、新大学の名称を「** 東京医科大栄」に変更しています。この新名称は統合の関係のある東京医科大に変更するだけでなく、東京都中野区の東京予備高等協力施設に売却するために活用されています。
      > 
      > 統合したのは、東京大の東京大栄の東京栄の間の一部ともに、台湾東京大栄（東京大麻生）の2年間に、日本国内が東京大の東京大木公園での東京地方駅を、東京都埼玉に展開する。東京大東京大の東京大同（東京区大東京大）の1号大は、東京大科医学部の東京大栄（東京大串大）で、東京大栄（東京大企業）と東京大栄（東京都新科大）の東京大企業の東京都秋葉原大
    - preprocess: 0.66秒
    - generation: 6.51秒
    - 247文字生成
    - 1文字あたり、0.026秒

- 英語
  - 14B (CPU / RAM: 56.8 GB)
    - > **Tokyo Institute of Technology and Tokyo Medical and Dental University, state-fun facilities that are aiming to merge in fiscal 2024, said Thursday that they have decided to name the new university “** Tokyo Institute of Technology and Tokyo Medical and Dental University.”
      > 
      > “We are not certain how to best handle the request from our alumni that wish to remain associated with the (old) Tokyo Institute of Technology. However, we will consider their wishes in a manner that can be accepted by the new university,” said Yoko Arase, the new university’s president.
      > 
      > The name of the new institution will be decided on during fiscal 2020 and will take effect in fiscal 2024.
      > 
      > The merger is expected to reduce costs through consolidation of administrative functions and management of the two universities’ facilities.
      > 
      > The two universities’ boards of directors will jointly decide on the name of the new institution.
      > 
      > The new institution will take the Tokyo Institute of Technology’s official English name, while the Tokyo Medical and Dental University will be known as the new university’s official Japanese name.
      > 
      > The two universities will merge their student registrations, with a merger of graduation, research, and entrance exams.
      > 
      > The new university will also retain the Tokyo Institute of Technology’s brand name, but change the university’s official English name to Tokyo Institute of Technology and Tokyo Medical and Dental University.
      > 
      > With the merger, the number of Tokyo Institute of Technology and Tokyo Medical and Dental University students is expected to rise to 28,000, up from around 22,000.
      > 
      > With the name change, the new university aims to be on a par with some of the best universities in the world, such as the Massachusetts Institute of Technology, in the U.S., and the Imperial College London in the U.K.
    - preprocess 57.19s
    - generation 498.8s
    - 259語生成
    - 1単語あたり、1.93秒
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
