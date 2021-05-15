# progetto_labiagi
progetto_labiagi: web client per pick and delivery

#### Setup ip statico per la macchina virtuale ubuntu18 su virtualbox, network attached to Bridged Adapter.
-  ifconfig => 192.168.1.69
- per gateway: ip route | grep default
- DNS: 8.8.8.8, 192.168.1.1
- Netmask: 255.255.255.0

#### dentro srrg2_labiagi

```sh source devel/setup.bash  
cd /home/dennis/labiagi_2020_21/workspaces/srrg2_labiagi/src/srrg2_navigation_2d/srrg2_navigation_2d/config
/home/dennis/labiagi_2020_21/srrg2_webctl/proc_webctl run_navigation.webctl 
```

rosbridge permette di creare il webserver su cui far circolare i msgs di ROS, è come se il client diventasse un nodo
```sh 
roslaunch rosbridge_server rosbridge_websocket.launch 
```
