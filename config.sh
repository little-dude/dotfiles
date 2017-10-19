DOT_DIR=${HOME}/.config

ln -s ${DOT_DIR}/git/gitconfig                 ${HOME}/.gitconfig
ln -s ${DOT_DIR}/python/pydistutils.cfg        ${HOME}/.pydistutils.cfg
ln -s ${DOT_DIR}/python/pypirc                 ${HOME}/.pypirc
ln -s ${DOT_DIR}/ssh                           ${HOME}/.ssh
ln -s ${DOT_DIR}/tmux/tmux.conf                ${HOME}/.tmux.conf
ln -s ${DOT_DIR}/vim/vimdir                    ${HOME}/.vim
ln -s ${DOT_DIR}/vim/vimrc                     ${HOME}/.vimrc
ln -s ${DOT_DIR}/X/xinitrc                     ${HOME}/.xinitrc
ln -s ${DOT_DIR}/X/Xkeymap                     ${HOME}/.Xkeymap
ln -s ${DOT_DIR}/X/xmodmap.conf                ${HOME}/.xmodmap.conf
ln -s ${DOT_DIR}/X/Xresources                  ${HOME}/.Xresources
ln -s ${DOT_DIR}/prezto                        ${HOME}/.zprezto
ln -s ${DOT_DIR}/prezto/runcoms/zlogin         ${HOME}/.zlogin
ln -s ${DOT_DIR}/prezto/runcoms/zlogout        ${HOME}/.zlogout
ln -s ${DOT_DIR}/prezto/runcoms/zpreztorc      ${HOME}/.zpreztorc
ln -s ${DOT_DIR}/prezto/runcoms/zprofile       ${HOME}/.zprofile
ln -s ${DOT_DIR}/prezto/runcoms/zshenv         ${HOME}/.zshenv
ln -s ${DOT_DIR}/prezto/runcoms/zshrc          ${HOME}/.zshrc
ln -s ${DOT_DIR}/mail/nokia/notmuch-config     ${HOME}/.notmuch-config

git submodule add  git@gitlab.com:corentinhenry/prezto.git
git submodule update --init --recursive
cd $ZPREZTODIR
git clone https://github.com/belak/prezto-contrib contrib
cd contrib
git submodule init
git submodule update
