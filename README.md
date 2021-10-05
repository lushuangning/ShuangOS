# 开发进度：

Boot 引导程序

从 Boot 跳转到 Loader 程序


# 使用说明：

环境：Bochs 虚拟机

在当前目录中打开终端，分别执行下面三步

1. 编译

```shell
nasm boot.asm -o boot.bin

nasm loader.asm -o loader.bin
```

2. 软盘制作

```shell
(base) ☁  ShuangOS [main] ⚡  bximage
========================================================================
                                bximage
  Disk Image Creation / Conversion / Resize and Commit Tool for Bochs
         $Id: bximage.cc 13481 2018-03-30 21:04:04Z vruppert $
========================================================================

1. Create new floppy or hard disk image
2. Convert hard disk image to other format (mode)
3. Resize hard disk image
4. Commit 'undoable' redolog to base image
5. Disk image info

0. Quit

Please choose one [0] 1

Create image

Do you want to create a floppy disk image or a hard disk image?
Please type hd or fd. [hd] fd

Choose the size of floppy disk image to create.
Please type 160k, 180k, 320k, 360k, 720k, 1.2M, 1.44M, 1.68M, 1.72M, or 2.88M.
 [1.44M] 

What should be the name of the image?
[a.img] boot.img

Creating floppy image 'boot.img' with 2880 sectors

The following line should appear in your bochsrc:
  floppya: image="boot.img", status=inserted
```

3. 将文件写入软盘

-  写入 boot 程序

```shell
dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc
```

- 复制 loader 程序

```shell
sudo mkdir /media/ShuangOS
sudo mount boot.img /media/ShuangOS -t vfat -o loop
sudo cp loader.bin /media/ShuangOS
sudo sync
sudo umount /media/ShuangOS
```

4. 启动虚拟机

```shell
bochs -f ./bochsrc
.
.
.
You can also start bochs with the -q option to skip these menus.

1. Restore factory default configuration
2. Read options from...
3. Edit options
4. Save options to...
5. Restore the Bochs state from...
6. Begin simulation
7. Quit now

Please choose one: [6] 6
.
.
.
00000000000i[PLUGIN] reset of 'usb_uhci' plugin device by virtual method
00000000000i[      ] set SIGINT handler to bx_debug_ctrlc_handler
Next at t=0
(0) [0x0000fffffff0] f000:fff0 (unk. ctxt): jmpf 0xf000:e05b          ; ea5be000f0
<bochs:1> c
```