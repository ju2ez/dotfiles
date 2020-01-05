if ! [ $(id -u) = 0 ]; then
   echo "This script must be run as root" 
   exit 1
fi

if ! [ "dpkg -s fonts-powerline" ]; 
then
  echo 'fonts-powerline is not installed yet...will be installed' >&2
  sudo apt-get install fonts-powerline
  sudo apt install curl
else
  echo 'fonts-powerline is already installed'
fi
if ! [ -x "$(command -v curl)" ]; 
then
  echo 'curl is not installed yet...will be installed' >&2
  sudo apt install curl
else
  echo 'curl is already installed'
fi


if ! [ -x "$(command -v git)" ]; 
then
  echo 'git is not installed yet...will be installed' >&2
  sudo apt install git
else
  echo 'git is already installed'
fi

if ! [ -x "$(command -v zsh)" ]; 
then
  echo 'zsh is not installed yet...will be installed' >&2
  sudo apt install zsh
else
  echo 'zsh is already installed'
fi

if ! [ -d $HOME'/.oh-my-zsh' ]; 
then	
  echo 'oh-my-zsh is not yet installed..'
  yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo 'oh-my-zsh already installed'
fi
#
if ! [ -x "$(command -v tmux)" ]; 
then
  echo 'tmux is not installed yet...will be installed' >&2
  sudo apt install tmux
else
  echo 'tmux is already installed'
fi

if ! [ -x "$(command -v rcup)" ]; 
then
  echo 'thoughtbot rcm is not installed yet...will be installed' >&2
  sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
  sudo apt-get update
  sudo apt-get install rcm
else
  echo 'rcm is already installed'
fi

if ! [ -d $HOME'/.dotfiles' ]; 
then	
  mkdir $HOME/.dotfiles
fi
# synchronize home dir with rcup
rcup -v

# use relative parent path and copy dotfiles 
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
cp ./dotfiles/* ~/.dotfiles/

#set zsh to default
chsh -s /usr/bin/zsh root 

vim +PlugInstall +qall

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf



