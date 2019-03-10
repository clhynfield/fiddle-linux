FROM ubuntu:latest

MAINTAINER Clayton Hynfield <clayton@hynfield.org>

RUN apt-get update && apt-get install -y \
    zsh \
    vim \
    man \
    less \
    tmux \
    direnv \
    jq \
    curl \
    git \
    wamerican \
 && rm -rf /var/lib/apt/lists/*

RUN curl \
    --remote-name \
    --location \
    https://github.com/getantibody/antibody/releases/download/v4.1.0/antibody_4.1.0_linux_amd64.deb \
    && dpkg --install antibody_4.1.0_linux_amd64.deb

ENV LC_CTYPE C.UTF-8

RUN chsh --shell /usr/bin/zsh

RUN rm -rf ~ && git clone --recursive https://github.com/clhynfield/dotfiles.git ~

RUN vim -c PlugInstall -c quitall

RUN mkdir /workspace && ln -s /workspace "$HOME/workspace"
VOLUME "/workspace"
WORKDIR /workspace

CMD [ "tmux", "new-session", "-A", "-D" ]
