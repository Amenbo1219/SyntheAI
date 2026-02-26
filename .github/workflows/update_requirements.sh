#!/bin/bash

# --- 自動パス解決 ---
# スクリプトがある場所を取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# リポジトリのルート（1つ上の階層）に移動
cd "$SCRIPT_DIR/../.."
ROOT_DIR=$(pwd)

# --- 設定 ---
TARGET_DIR_NAME="py3" # requirements.txtがあるディレクトリ名
IMAGE_NAME="synthai-debug"
DOCKERFILE="$TARGET_DIR_NAME/Dockerfile.debug"

set -e # エラーで停止

echo "--- 0. Path Verification ---"
echo "Root Directory: $ROOT_DIR"

if [ ! -d "$TARGET_DIR_NAME" ]; then
    echo "Error: Directory '$TARGET_DIR_NAME' not found in $ROOT_DIR"
    exit 1
fi

echo "--- 1. Backup ---"
if [ -f "$TARGET_DIR_NAME/requirements.txt" ]; then
    cp "$TARGET_DIR_NAME/requirements.txt" "$TARGET_DIR_NAME/requirements.txt.bak"
    echo "Backup created: $TARGET_DIR_NAME/requirements.txt.bak"
else
    touch "$TARGET_DIR_NAME/requirements.txt.bak"
fi

echo "--- 2. Building Docker Image ---"
# ルートディレクトリをコンテキストとしてビルド
docker build -t $IMAGE_NAME -f $DOCKERFILE .

echo "--- 3. Running Update & Test in Container ---"
# ホストの py3 フォルダをコンテナの /app にマウント
docker run --rm --gpus all \
  -v "$ROOT_DIR/$TARGET_DIR_NAME":/app \
  -w /app \
  $IMAGE_NAME \
  /bin/bash -c "
    set -e
    echo '--- 3.1 Generating requirements.txt ---'
    pip-compile --strip-extras --upgrade \
      --unsafe-package nvidia-cublas-cu12 \
      --unsafe-package nvidia-cuda-cupti-cu12 \
      --unsafe-package nvidia-cuda-nvcc-cu12 \
      --unsafe-package nvidia-cuda-nvrtc-cu12 \
      --unsafe-package nvidia-cuda-runtime-cu12 \
      --unsafe-package nvidia-cudnn-cu12 \
      --unsafe-package nvidia-cufft-cu12 \
      --unsafe-package nvidia-curand-cu12 \
      --unsafe-package nvidia-cusolver-cu12 \
      --unsafe-package nvidia-cusparse-cu12 \
      --unsafe-package nvidia-nccl-cu12 \
      --unsafe-package nvidia-nvtx-cu12 \
      requirements.in --output-file requirements.txt
    uv pip install --system --no-cache \
    --index-strategy unsafe-best-match \
    -r requirements.txt
    echo '--- 3.2 Testing Frameworks ---'
    python3 -c 'import torch; import tensorflow as tf; import jax; \
      assert torch.cuda.is_available(); \
      assert len(tf.config.list_physical_devices(\"GPU\")) > 0; \
      assert jax.lib.xla_bridge.get_backend().platform == \"gpu\"; \
      print(\"--- ALL FRAMEWORKS SUCCESS ---\")'
"

echo "--- 4. Finalizing ---"
diff -u "$TARGET_DIR_NAME/requirements.txt.bak" "$TARGET_DIR_NAME/requirements.txt" || true
