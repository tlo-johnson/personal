#! /bin/sh

# https://www.baeldung.com/linux/bash-get-location-within-script
config_dir=$(readlink -f $(dirname $BASH_SOURCE))

echo "creating symlinks"
ln -sf $config_dir/gitconfig $HOME/.gitconfig
ln -sf $config_dir/zshrc $HOME/.zshrc

nvim_config_dir=$HOME/.nvim/config
[[ ! -d $nvim_config_dir ]] && mkdir -p $nvim_config_dir
[[ -f $nvim_config_dir/nvim ]] && rm $nvim_config_dir/nvim
ln -sf $config_dir/nvim $nvim_config_dir/nvim

# install homebrew
[[ -z $(command -v brew) ]] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

read -p "install homebrew packages (Y/n): " input
[[ $input != 'Y' ]] && exit 0

echo "installing homebrew packages"
brew bundle install --file $config_dir/brewfile
