FROM tensorflow/tensorflow:2.17.0-gpu

# タイムゾーンの設定
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \ 
    tzdata \
    git \ 
    wget \
    libglib2.0-0 \
    libsm6 \ 
    libxrender1 \ 
    libxext6 \
    libgl1-mesa-dev \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

# 研究室用追加パッケージ
RUN pip install --no-cache-dir praat-parselmouth

# requirements.txt のコピーとパッケージのインストール
COPY requirements.txt /install/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /install/requirements.txt
# PyTorchのインストール
RUN pip install torch==2.4.1+cu121 torchvision==0.19.1+cu121 torchaudio==2.4.1+cu121 --index-url https://download.pytorch.org/whl/cu121

# TensorFlowのログレベルを設定
ENV TF_CPP_MIN_LOG_LEVEL=2
