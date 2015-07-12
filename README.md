# P1-OpenWrt
Slimme Meter P1 koppelen aan OpenWrt


```
opkg update
opkg install kmod-usb-ohci
opkg install kmod-usb2
opkg install kmod-usb-serial
opkg install kmod-usb-serial-ftdi

modprobe ftdi_sio
modprobe usbserial
```
Check:
```
root@OpenWrt:~# lsmod | grep ftdi
ftdi_sio               27856  1 
usbcore               109781  7 ftdi_sio
usbserial              18407  4 ftdi_sio

```

Connect the FTDI USB device to the router's USB port

```
root@OpenWrt:~# lsusb 
Bus 001 Device 002: ID 05e3:0608 Genesys Logic, Inc. USB-2.0 4-Port HUB
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 003: ID 0403:6001 Future Technology Devices International, Ltd FT232 USB-Serial (UART) IC

root@OpenWrt:~# ls -al /dev/ttyUSB*
crw-r--r--    1 root     root      188,   0 Jul 12 18:55 /dev/ttyUSB0

stty 9600 cs7 parenb -cstopb -echo -F /dev/ttyUSB0
cat /dev/ttyUSB0

root@OpenWrt:~# cat /dev/ttyUSB0 | grep -vi "^$" 


/KMP5 KA6U0017333397913
0-0:96.1.1(204B413655303031373539343937393133)
1-0:1.8.1(01981.181*kWh)
1-0:1.8.2(01743.597*kWh)
1-0:2.8.1(00346.173*kWh)
1-0:2.8.2(00910.824*kWh)
0-0:96.14.0(0001)
1-0:1.7.0(0000.74*kW)
1-0:2.7.0(0000.00*kW)
0-0:17.0.0(999*A)
0-0:96.3.10(1)
0-0:96.13.1()
0-0:96.13.0()
0-1:24.1.0(3)
0-1:96.1.0(4730303135353631323030393331373133)
0-1:24.3.0(150712200000)(08)(60)(1)(0-1:24.2.1)(m3)
(01460.083)
0-1:24.4.0(1)
!

```


The script ```get-P1-counter.sh``` tries to automate this. Warning: there is not always output. The script protects against that.
