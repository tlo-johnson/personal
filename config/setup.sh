#! /bin/sh

# https://www.baeldung.com/linux/bash-get-location-within-script
config_dir=$(readlink -f $(dirname $BASH_SOURCE))

echo "creating symlinks"
ln -sf $config_dir/gitconfig $HOME/.gitconfig
ln -sf $config_dir/zshrc $HOME/.zshrc
ln -sf $config_dir/tmux.conf $HOME/.tmux.conf

nvim_config_dir=$HOME/.nvim/config
[[ ! -d $nvim_config_dir ]] && mkdir -p $nvim_config_dir
[[ -f $nvim_config_dir/nvim ]] && rm $nvim_config_dir/nvim
ln -sf $config_dir/nvim $nvim_config_dir/nvim

karabiner_config_dir=$HOME/.config/karabiner
[[ ! -d $karabiner_config_dir ]] && mkdir -p $karabiner_config_dir
[[ -f $karabiner_config_dir/karabiner ]] && rm $karabiner_config_dir/karabiner.json
ln -sf $config_dir/karabiner.json $karabiner_confir_dir/karabiner.json

# install homebrew
[[ -z $(command -v brew) ]] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

read -p "install homebrew packages (Y/n): " input
[[ $input != 'Y' ]] && exit 0

echo "installing homebrew packages"
brew bundle install --file $config_dir/brewfile
