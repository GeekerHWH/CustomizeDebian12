## Welcome
This is a repository for my own scripts mainly for debloat debian 12

I'm inspired by ChrisTitus' WinUtilities, which is great for desktop user to set up their workspace efficiently and elegently
This is his repository: https://github.com/ChrisTitusTech/winutil

Some of you might want to ask "hey, we've got apt instead, why to use your work?"
Well, some softwares do need gpg key and some stuffs, or some guys really hope to get a clean Debian system like me, or someone who need to set up his Desktop automatically and to drink a cup of coffee :P

if you have any question about scripts, 
please let me know to create an issue! :)

This project is highly experimental, DO NOT use it in development environment!

OP is just an undergraduate student now, may have no time to reply very often. TwT

## How to use
Prerequisite: make sure you have `curl` installed
```bash
sudo apt install curl git -y
```

### run locally
```bash
git clone https://github.com/GeekerHWH/CustomizeDebian12.git
cd CustomizeDebian12/Scripts
chmod u+x main.sh
./main.sh
```

<!-- Execute the following command and Follow the TUI to finish installing your Debian, and you are done!
```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/GeekerHWH/CustomizeDebian12/main/CustomizeDebian12.sh)"
``` -->

> - Some softwares might need be installed in TUN proxy mode if you are in China

## Demo
![1](static/images/1.png)

![2](static/images/2.png)

## features
- [x] Quick install basic Gnome Desktop Environment
- [x] Install softwares like (MacOS theme / Docker / WineHQ)
- [x] Tweaks (experimental)
- [ ] Customize Server Lab (experimental)

### tweaks
set colorful grep

### What are in developing
- [ ] fonts support fixed
- [ ] I'm considering how many country really need to change the mirror...
- [ ] group softwares into different categories

