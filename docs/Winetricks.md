# Prerequisite
```bash
mkdir wine
cd wine
WINEARCH=win32 WINEPREFIX=~/wine/testbottle winetricks

WINEARCH=win32 WINEPREFIX=~/wine/testbottle wine ~/wine/testbottle/drive_c/test.exe

Kill Wine Processes - wineserver -k
```

# for Wechat installing
```bash
sudo apt install winetricks

winetricks riched20 riched30 richtx32 msftedit

winetricks cjkfonts fakechinese
```