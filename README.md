# Progetto LABIAGI 2020-2021
### Dennis Rotondi, Web Client per pick and delivery

Il risultato raggiunto con il codice scritto in questa repository è quello di poter configurare un'interfaccia client per notificare i nuovi obiettivi al robot facendolo muovere in un ambiente di navigazione già predisposto. Dall'interfaccia web chiunque potrà "loggare" (precisamente si crea un id sender che poi verrà usato per capire, lato server in cpp, chi veramente può manovrare il robot e chi invece può solo confermare le consegne), a questo punto si carica il file nel formato {"stanza1": [x1,y1,theta1], ...} che costituirà degli obiettivi sulla mappa. 
Il server comunica con il client attraverso lo scambio di messaggi ROS ed usando roslibjs + rosbridge questo è l'apporccio naturale al problema.
In conclusione il programma si presta ad essere utilizzato su qualsiasi mappa e da più utenti lasciando la gestione delle connessioni alle librerie sopracitate.

# Per utilizzarlo:
#### dentro srrg2_labiagi

```sh 
source devel/setup.bash  
cd /home/dennis/labiagi_2020_21/workspaces/srrg2_labiagi/src/srrg2_navigation_2d/config
/home/dennis/labiagi_2020_21/srrg2_webctl/proc_webctl run_navigation.webctl 
```
e da localhost:9001 lanciare: roscore, stage, mapserver, rviz e aprire il file di config desiderato, localize, planner e un a_follower (i test sono stati fatti con lo static).

Clonare questa repository sulla propria macchina, dentro ws fare il source devel/setup.bash (per avere i messaggi personalizzati creati), poi lanciare rosbridge: 
```sh 
roslaunch rosbridge_server rosbridge_websocket.launch 
```
questo permette di creare il webserver su cui far circolare i msgs di ROS, è come se il client diventasse un nodo.

Fare ancora il source nella cartella ws e poi lanciare 

```sh 
rosrun dr_ped dr_ped
```
A questo punto bisogna servire la pagina html che farà da interfaccia client, questo può essere fatto usando nella cartella principale clonata:

```sh 
python3 -m http.server
```
Potrebbe essere necessario:
```sh 
python3 -m pip install websocket
python3 -m pip install simple_http_server
```
verrà resa disponibile sulla porta 8000 la pagina, indirizzo della macchina ottenibile con ifconfig. eg 192.168.1.69:8000

Tutto ciò che resta da fare è loggarsi, inserire un file come "test.json" che mappa zone e punti sulla mappa e sarà possibile utilizzare a pieno il servizio di pick and delivery.

# Altro

#### Setup ip statico per la macchina virtuale ubuntu18 su virtualbox, network attached to Bridged Adapter.
-  ifconfig => 192.168.1.69
- per gateway: ip route | grep default
- DNS: 8.8.8.8, 192.168.1.1
- Netmask: 255.255.255.0

Punti nel json.test presi con rostopic echo /move_base_simple/goal

demo_yt (versione vecchia): https://www.youtube.com/watch?v=Z7oPy9IhsZQ

ref: http://wiki.ros.org/rosbridge_suite

ref: http://wiki.ros.org/roslibjs
