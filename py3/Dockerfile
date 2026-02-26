FROM ghcr.io/astral-sh/uv:latest AS uv_bin
FROM tensorflow/tensorflow:2.15.0.post1-gpu
# TimeZone　Setup
ENV TZ=Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive
# Copy uv binary
COPY --from=uv_bin /uv /uvx /bin/
# Base Environment Setup
RUN apt-get update && apt-get install -y \
    tzdata \
    git \
    wget \
    ffmpeg \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    libgl1-mesa-dev \
    bash-completion \
    && rm -rf /var/lib/apt/lists/* 

# Shell Environment Setup
RUN echo "if [ -f /etc/bash_completion ]; then . /etc/bash_completion; fi" >> /root/.bashrc && \
    uv generate-shell-completion bash >> /root/.bashrc && \
    # Enable color prompt and set PS1
    sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /root/.bashrc && \
    echo "alias ls='ls --color=auto'" >> /root/.bashrc && \
    echo "alias ll='ls -alF'" >> /root/.bashrc && \
    echo "alias la='ls -A'" >> /root/.bashrc && \
    echo "PS1='\[\033[01;32m\]user\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '">> /root/.bashrc

# copy to requirements.txt and requirements install 
COPY requirements.txt /install/requirements.txt
RUN uv pip install --system --no-cache \
    --index-strategy unsafe-best-match \
    -r /install/requirements.txt 

# Tensorflow Log Level Setup(Delete Warning Message)
ENV TF_CPP_MIN_LOG_LEVEL=2
# SHELL Environment Setup
ENV SHELL=/bin/bash
ENV TERM=xterm-256color
ENTRYPOINT ["/bin/bash"]