## Welcome
This is a repository for my own scripts mainly for debloat debian 12

I'm inspired by ChrisTitus' WinUtilities, which is great for desktop user to set up their workspace efficiently and elegently
This is his repository: https://github.com/ChrisTitusTech/winutil

Some of you might want to ask "hey, we've got apt instead, why to use your work?"
Well, some softwares do need gpg key and some stuffs, or some guys really hope to get a clean Debian system like me, or someone who need to set up his Desktop automatically and to drink a cup of coffee :P

All in all, hope you enjoy, staring this repo is the best support

if you have any question about scripts, 
please let me know to create an issue! :)

## How to use
```bash
git clone https://github.com/GeekerHWH/CustomizeDebian12.git
cd CustomizeDebian12/Scripts
chmod u+x -R main.sh modules/
sudo ./main.sh
# follow the TUI to finish installing your Debian, and you are done!
```

> - Some softwares might need be installed in TUN proxy mode if you are in China

## Demo
![1](Notes/1.png)

![2](Notes/2.png)

## features
- [x] install basic Gnome Desktop Environment
- [x] install softwares like (MacOS theme / Golang / Docker / WineHQ)
- [ ] tweaks (experimental)
  - [x] display git branch in terminal
  - [x] set GRUB timeout to 0 sec
  - [x] set tab in bash like zsh
- [ ] install Protobuf and gRPC (Developing)

### ChangeMirror module is developing
https://github.com/GeekerHWH/CustomizeDebian12
![Procedure](Notes/CustomizeDebian12.drawio.png)