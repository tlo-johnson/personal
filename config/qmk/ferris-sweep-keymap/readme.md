In order to flash the Elite-C chip, a dfu bootloader has to be used. In my specific case, the bootloader had to be changed from `catalina` to `qmk-dfu`. The setting was found in `keyboards/ferris/sweep/rules.mk`

Note: the specified rules file is used because I compiled with the `ferris-sweep` keyboard
