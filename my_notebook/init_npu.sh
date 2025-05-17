# 1. 下载模型
pip install modelscope
# /home/service/.local/bin/modelscope
export PATH=$PATH:/home/service/.local/bin
modelscope download --model Qwen/Qwen3-32B  --local_dir /cache/Qwen3-32B

# 2. 下载 Ascend CANN 依赖
openi model download tobe/qwen3_train npu --save_path /cache/npu
cd /cache/npu
chmod +x ./Ascend-cann-toolkit_8.1.RC1_linux-aarch64.run
./Ascend-cann-toolkit_8.1.RC1_linux-aarch64.run --full -q
# source /usr/local/Ascend/ascend-toolkit/set_env.sh
source /home/ma-user/Ascend/ascend-toolkit/set_env.sh

chmod +x ./Ascend-cann-kernels-910b_8.1.RC1_linux-aarch64.run
./Ascend-cann-kernels-910b_8.1.RC1_linux-aarch64.run --install -q

# 3. 安装 llamafactory
pip install -e ".[torch-npu,metrics]"

export ASCEND_SLOG_PRINT_TO_STDOUT=1 #日志打屏, 可选
export ASCEND_GLOBAL_LOG_LEVEL=1 #日志级别常用 1 INFO级别; 3 ERROR级别
llamafactory-cli train examples/train_lora/qwen3_lora_sft_npu.yaml
