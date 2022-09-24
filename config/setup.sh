#! /bin/sh

# https://www.baeldung.com/linux/bash-get-location-within-script
config_dir=$(readlink -f $(dirname $BASH_SOURCE))

echo "creating symlinks"
ln -sf $config_dir/gitconfig $HOME/.gitconfig
ln -sf $config_dir/zshrc $HOME/.zshrc

nvim_config_dir=$HOME/.nvim/config
[[ ! -d $nvim_config_dir ]] && mkdir -p $nvim_config_dir && ln -sf $config_dir/nvim $nvim_config_dir/nvim

echo "setting my_home directory in zshrc"
my_home=$(dirname $(dirname $config_dir))
sed -i '' "s|^my_home=.*$|my_home=$my_home|" $config_dir/zshrc

echo "installing homebrew packages"
brew bundle install --file $config_dir/brewfile
