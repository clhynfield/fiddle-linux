FROM debian:latest

MAINTAINER Clayton Hynfield <clayton@hynfield.org>

RUN apt-get update && apt-get install -y \
    zsh \
    vim \
    man \
    less \
    file \
    tmux \
    direnv \
    jq \
    curl \
    git \
    gcc \
    procps \
    wamerican \
    perl \
 && rm -rf /var/lib/apt/lists/*

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

RUN /home/linuxbrew/.linuxbrew/bin/brew install \
    antibody

ENV LC_CTYPE C.UTF-8

RUN chsh --shell /usr/bin/zsh

RUN rm -rf ~ && git clone --recursive https://github.com/clhynfield/dotfiles.git ~

RUN vim -c PlugInstall -c quitall

RUN mkdir /workspace && ln -s /workspace "$HOME/workspace"
VOLUME "/workspace"
WORKDIR /workspace

CMD [ "tmux", "new-session", "-A", "-D" ]
