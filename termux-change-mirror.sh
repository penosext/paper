#!/bin/bash

# 备份原 sources.list 文件
cp $PREFIX/etc/apt/sources.list $PREFIX/etc/apt/sources.list.bak

# 显示可选择的镜像源菜单
echo "请选择要更换的国内镜像源："
echo "1. 清华大学 TUNA 镜像源"
echo "2. 中国科学技术大学镜像源"
echo "3. 齐鲁工业大学镜像源"
read -p "请输入选项编号：" choice

# 根据用户选择进行相应的替换操作
case $choice in
    1)
        sed -i's@^<inline_LaTeX_Formula>deb.*stable main<\inline_LaTeX_Formula>$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
        sed -i's@^<inline_LaTeX_Formula>deb.*games stable<\inline_LaTeX_Formula>$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list
        sed -i's@^<inline_LaTeX_Formula>deb.*science stable<\inline_LaTeX_Formula>$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list
        ;;
    2)
        echo "deb https://mirrors.ustc.edu.cn/termux/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
        ;;
    3)
        sed -i's@^<inline_LaTeX_Formula>deb.*stable main<\inline_LaTeX_Formula>$@#\1\ndeb https://mirrors.qlu.edu.cn/termux/apt/termux-main stable main@' $PREFIX/etc/apt/sources.list
        ;;
    *)
        echo "无效的选项，请重新运行脚本并选择正确的编号。"
        exit 1
        ;;
esac

# 更新软件包列表并升级软件
apt update && apt upgrade
