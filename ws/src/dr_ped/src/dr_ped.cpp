#include "dr_ped/Obiettivo.h"
#include "dr_ped/Stato.h"
#include "geometry_msgs/PoseStamped.h"
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "tf/tf.h"
#include "tf2_msgs/TFMessage.h"
#include <tf2_ros/transform_listener.h>
#include <vector>
using namespace std;

enum status { disponibile = 0, navigazione = 1, attesa_conferma = 2 };

// globals
status stato = disponibile;
string stanza_target = ""; // di fatto è l'ultima stanza raggiunta, quella dove si trova attualmente
ros::Publisher pub_goal;
ros::Publisher pub_log;
ros::Subscriber sub_ob;
ros::Subscriber sub_tf;
ros::Timer timer;
tf2_ros::Buffer tfBuffer;
int stuck_count = 0;
vector<float> target_positon(2, 0);
vector<float> old_position(2, 0);
vector<float> current_position(2, 0);
vector<string> utenti_autorizzati = {"Dennis:20", "Sara:14", "Marco:19"};
string lock_utente = "";
size_t seq = 10;

void logger(dr_ped::Stato stato) {
  // cerr << stato.commento << endl;
  pub_log.publish(stato);
}

// aggiornamento posizione per i check
void get_position() // arg se come listnerconst tf2_msgs::TFMessage &tf
{
  if (tfBuffer.canTransform("map", "base_link", ros::Time(0))) {
    geometry_msgs::TransformStamped transformStamped;
    transformStamped = tfBuffer.lookupTransform("map", "base_link", ros::Time(0));
    old_position[0] = current_position[0];
    old_position[1] = current_position[1];
    current_position[0] = transformStamped.transform.translation.x;
    current_position[1] = transformStamped.transform.translation.y;
  }
}

float distance(vector<float> a, vector<float> b) { return sqrt(pow(a[0] - b[0], 2) + pow(a[1] - b[1], 2)); }

void check_cb(const ros::TimerEvent &event) {
  dr_ped::Stato stato_msg;
  stato_msg.stato = stato;
  stato_msg.stanza_target = stanza_target;
  switch (stato) {
  case disponibile:
    stato_msg.commento = "Il robot è disponibile a ricevere istruzioni";
    break;
  case navigazione:
    get_position();
    // cerr << distance(current_position, old_position) << endl;
    // cerr << distance(target_positon, current_position) << endl;
    stato_msg.commento = "Il robot sta navigando";
    if (distance(current_position, old_position) < 0.3) {
      if (stuck_count++ > 10) {
        stato_msg.commento = "Il robot è bloccato e non riesce a raggiungere la posizione desiderata, shutting down";
        logger(stato_msg);
        ros::shutdown();
      } else {
        stato_msg.commento = "Il robot è bloccato, per ora, riproverà a muoversi a breve";
      }
    }
    if (distance(target_positon, current_position) < 1.5) {
      stuck_count = 0;
      stato = attesa_conferma;
      stato_msg.stato = stato;
      stato_msg.commento = "Il robot è arrivato ed è in attesa di conferma arrivo"; // loggo prima perché il wait blocca tutto a quanto pare...
      logger(stato_msg);
      // https://answers.ros.org/question/293890/how-to-use-waitformessage-properly/
      std_msgs::StringConstPtr wait_msg = ros::topic::waitForMessage<std_msgs::String>("/conferma_dr_ped", ros::Duration(30));
      if (wait_msg) {
        if(find(utenti_autorizzati.begin(), utenti_autorizzati.end(), wait_msg->data) != utenti_autorizzati.end()){
          lock_utente = wait_msg->data;
          stato_msg.commento = "Il robot ha ricevuto conferma, aspetta ordini da " + lock_utente.substr(0, lock_utente.find(":"));
        }
        else
          stato_msg.commento = "Il robot ha ricevuto conferma, da un ospite, tornerà presto disponibile per tutti";
      } 
      else
        stato_msg.commento = "Il robot non ha ricevuto conferma ma è arrivato, tornerà presto disponibile per tutti";
      stato = disponibile;
    }
    break;
  case attesa_conferma:
    stato_msg.commento = "Il robot è in attesa di conferma istruzione";
    break;
  }
  logger(stato_msg);
}

int check_sender(string sender) {
  if (find(utenti_autorizzati.begin(), utenti_autorizzati.end(), sender) != utenti_autorizzati.end()) {
    return 0;
  } else {
    dr_ped::Stato stato_msg;
    stato_msg.stato = stato;
    stato_msg.stanza_target = stanza_target;
    stato_msg.commento = "Un utente non autorizzato ha provato a dare un comando al robot. Ricordo che un ospite può solo confermare l'arrivo.";
    logger(stato_msg);
    return -1;
  }
}

int check_lock(string sender) {
  if (lock_utente != "") {
    if (sender != lock_utente) {
      dr_ped::Stato stato_msg;
      string utente = lock_utente.substr(0, lock_utente.find(":"));
      stato_msg.stato = stato;
      stato_msg.stanza_target = stanza_target;
      stato_msg.commento = "Il robot è attualmente occupato con una consegna, riceve ordini solo dall'utente " + utente;
      logger(stato_msg);
      return -1;
    } else {
      lock_utente = "";
      return 0;
    }
  }
}

void obiettivo_cb(const dr_ped::Obiettivo &obiettivo) {
  if (check_sender(obiettivo.sender))
    return;

  dr_ped::Stato stato_msg;

  if (stato == disponibile) {
    if (check_lock(obiettivo.sender))
      return;
    stato = navigazione;
    stanza_target = obiettivo.id_stanza;
    stato_msg.stato = stato;
    stato_msg.stanza_target = obiettivo.id_stanza;
    stato_msg.commento = "Inizio la navigazione verso " + obiettivo.id_stanza;

    geometry_msgs::PoseStamped new_goal_msg;

    new_goal_msg.header.seq = seq++;
    new_goal_msg.header.stamp = ros::Time::now();
    new_goal_msg.header.frame_id = "map";
    new_goal_msg.pose.position.x = obiettivo.x;
    new_goal_msg.pose.position.y = obiettivo.y;
    new_goal_msg.pose.position.z = 0;
    new_goal_msg.pose.orientation.x = 0;
    new_goal_msg.pose.orientation.y = 0;
    new_goal_msg.pose.orientation.z = 0;
    new_goal_msg.pose.orientation.w = obiettivo.theta;

    pub_goal.publish(new_goal_msg);

    target_positon[0] = new_goal_msg.pose.position.x;
    target_positon[1] = new_goal_msg.pose.position.y;
  } else {
    stato_msg.stato = stato;
    stato_msg.stanza_target = stanza_target;
    stato_msg.commento = "Sono già in navigazione verso " + stanza_target;
  }
  logger(stato_msg);
}

int main(int argc, char **argv) {
  ros::init(argc, argv, "dr_ped");
  ros::NodeHandle n;
  ros::Rate loop_rate(10);

  pub_goal = n.advertise<geometry_msgs::PoseStamped>("/move_base_simple/goal", 1000);
  tf2_ros::TransformListener tfListener(tfBuffer);
  pub_log = n.advertise<dr_ped::Stato>("/logger_web", 1000);
  sub_ob = n.subscribe("obiettivo", 1000, obiettivo_cb);

  // sub_tf = n.subscribe("tf", 1000, get_position);
  get_position();
  timer = n.createTimer(ros::Duration(5), check_cb);

  ros::spin();
  timer.stop();
  // wait_msg.reset();
}