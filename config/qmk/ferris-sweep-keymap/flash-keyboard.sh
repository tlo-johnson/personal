script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
keymap_dir="$HOME/qmk_firmware/keyboards/ferris/keymaps/tlo-johnson"

ls -d $keymap_dir && rm -rf $keymap_dir
cp -r $script_dir $keymap_dir
qmk flash -kb ferris/sweep -km tlo-johnson
