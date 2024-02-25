# install
```bash
sudo apt install ibus ibus-pinyin -y
```

# 初始安装
输入法引擎安装完成后，运行 ibus-setup 的初始程序（当要用 Ibus 的用户）：
```bash
ibus-setup
```
会启动后台程序，并给这条信息：
```bash
IBus has been started! If you cannot use IBus, please add below lines in $HOME/.bashrc, and relogin your desktop.
# （译：IBus 已启动！若还不能用 Ibus,请您将以下的三行代码加到 $HOME/.bashrc再重新登录。)
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
```

# ibus重启
```bash
$ ibus restart
```

# Reference
[知乎](https://zhuanlan.zhihu.com/p/582900290)