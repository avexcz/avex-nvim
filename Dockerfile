FROM alpine:edge

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# Avex's requirements (unfortunately treesitter does not work due to it's version which requires 0.12.0 but alpine's neovim is capped to 0.11.7)
RUN apk update && apk add --no-cache \
   --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
   neovim \
   git \
    curl \
    build-base \
    ripgrep \
    fd \
    nodejs \
    npm \
    python3 \
    py3-pip \
    bash \
    gzip \
    tar

RUN npm install -g tree-sitter-cli

# Create the configuration directory
RUN mkdir -p /root/.config/nvim

# Install packer
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    /root/.local/share/nvim/site/pack/packer/start/packer.nvim

# Avex's configuration into the container
COPY . /root/.config/nvim

# Auto install plugins
RUN nvim --version && \
    nvim --headless -c 'PackerSync' -c 'autocmd User PackerComplete quitall'

WORKDIR /workspace

ENTRYPOINT ["nvim"]
