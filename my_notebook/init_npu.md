这里就当笔记整理吧, 具体的运行脚本是 init_npu.sh
[TOC]

# 下载模型

``` bash
pip install modelscope
# /home/service/.local/bin/modelscope
export PATH=$PATH:/home/service/.local/bin
modelscope download --model Qwen/Qwen3-32B  --local_dir /cache/Qwen3-32B

# 用 openi 下载, 其实速度差不多, 主要还是受限于网速只有 100Mbps
# pip install -U openi -i https://pypi.tuna.tsinghua.edu.cn/simple
# openi model download FoundationModel/Qwen Qwen3-32B --save_path /cache/Qwen3-32B_v2
```

# 安装 CANN

```bash
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple attrs cython numpy==1.24.0 decorator sympy cffi pyyaml pathlib2 psutil protobuf==3.20 scipy requests absl-py

# 逆天, 直接下载不了
wget "https://ascend-repo.obs.cn-east-2.myhuaweicloud.com/CANN/CANN 8.0.0/Ascend-cann-toolkit_8.0.0_linux-aarch64.run"
sh Ascend-cann-toolkit_8.0.0_linux-aarch64.run --full
wget "https://ascend-repo.obs.cn-east-2.myhuaweicloud.com/CANN/CANN 8.0.0/Ascend-cann-kernels-910b_8.0.0_linux-aarch64.run"
sh Ascend-cann-kernels-910b_8.0.0_linux-aarch64.run --install

# set env variables
source /usr/local/Ascend/ascend-t
```

vllm ascend 里抄来的版本

```bash
# --从 vllm ascend 里抄来的
# Install required python packages.
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple attrs 'numpy<2.0.0' decorator sympy cffi pyyaml pathlib2 psutil protobuf scipy requests absl-py wheel typing_extensions

# Download and install the CANN package.
wget https://ascend-repo.obs.cn-east-2.myhuaweicloud.com/CANN/CANN%208.1.RC1/Ascend-cann-toolkit_8.1.RC1_linux-aarch64.run
chmod +x ./Ascend-cann-toolkit_8.1.RC1_linux-aarch64.run
./Ascend-cann-toolkit_8.1.RC1_linux-aarch64.run --full -q
source /usr/local/Ascend/ascend-toolkit/set_env.sh

source /home/ma-user/Ascend/ascend-toolkit/set_env.sh

wget https://ascend-repo.obs.cn-east-2.myhuaweicloud.com/CANN/CANN%208.1.RC1/Ascend-cann-kernels-910b_8.1.RC1_linux-aarch64.run
chmod +x ./Ascend-cann-kernels-910b_8.1.RC1_linux-aarch64.run
./Ascend-cann-kernels-910b_8.1.RC1_linux-aarch64.run --install -q

wget https://ascend-repo.obs.cn-east-2.myhuaweicloud.com/CANN/CANN%208.1.RC1/Ascend-cann-nnal_8.1.RC1_linux-aarch64.run
chmod +x ./Ascend-cann-nnal_8.1.RC1_linux-aarch64.run
./Ascend-cann-nnal_8.1.RC1_linux-aarch64.run --install -q

source /usr/local/Ascend/nnal/atb/set_env.sh
# --从 vllm ascend 里抄来的
```

各种初始化

```bash
source /usr/local/Ascend/ascend-toolkit/set_env.sh
source /usr/local/Ascend/nnal/atb/set_env.sh
source /usr/local/Ascend/mindie/set_env.sh
source /usr/local/Ascend/atb-models/set_env.sh
```

# 安装 LLamaFactory

```bash
pip install -e ".[torch-npu,metrics]"

export ASCEND_SLOG_PRINT_TO_STDOUT=1 #日志打屏, 可选
export ASCEND_GLOBAL_LOG_LEVEL=1 #日志级别常用 1 INFO级别; 3 ERROR级别
source /usr/local/Ascend/ascend-toolkit/set_env.sh
llamafactory-cli train examples/train_lora/qwen3_lora_sft_npu.yaml
```

设置日志

```bash
export PYTHONPATH=/usr/local/Ascend/ascend-toolkit/latest/python/site-packages:
export PYTHONPATH=/usr/local/Ascend/ascend-toolkit/8.0.0/python/site-packages:
```

/usr/local/Ascend/ascend-toolkit/latest/python/site-packages:/usr/local/Ascend/ascend-toolkit/latest/opp/built-in/op_impl/ai_core/tbe:/usr/local/Ascend/ascend-toolkit/latest/python/site-packages:/usr/local/Ascend/ascend-toolkit/latest/opp/built-in/op_impl/ai_core/tbe:

# openi 的指南

```bash
pip install -U openi -i https://pypi.tuna.tsinghua.edu.cn/simple
openi model upload tobe/qwen3_train npu C:\Users\zhenh\Downloads\npu
openi model download tobe/qwen3_train npu --save_path /cache/npu
```

