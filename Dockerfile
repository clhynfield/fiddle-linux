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
    gpg \
    make \
 && rm -rf /var/lib/apt/lists/*

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

RUN /home/linuxbrew/.linuxbrew/bin/brew install \
    antibody \
    shellspec/shellspec/shellspec

ENV LC_CTYPE C.UTF-8

RUN mkdir /workspace
RUN groupadd --gid 1002 clayton
RUN useradd --create-home clayton --uid 1001 -g clayton --shell /usr/bin/zsh --skel /workspace
RUN chown -R clayton /workspace /home/linuxbrew/.linuxbrew
USER clayton

RUN rm -rf ~ && git clone --recursive https://github.com/clhynfield/dotfiles.git ~

RUN vim -c PlugInstall -c quitall

RUN mkdir /workspace && ln -s /workspace "$HOME/workspace"
VOLUME "/workspace"
WORKDIR /workspace

CMD [ "tmux", "new-session", "-A", "-D" ]
