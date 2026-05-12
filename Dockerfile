FROM alpine:3.20

# Avex's requirements (Alpine packages may lag behind the latest Neovim release)
RUN apk update && apk add --no-cache \
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

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nvim"]

