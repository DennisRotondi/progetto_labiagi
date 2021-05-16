#include "ros/ros.h"
#include <vector>
#include "geometry_msgs/PoseStamped.h"
#include "std_msgs/String.h"
#include "dr_ped/Obiettivo.h"
#include "tf/tf.h"
#include "tf2_msgs/TFMessage.h"
#include <tf2_ros/transform_listener.h>
using namespace std;

//globals
int cruising = 0;
int da_raggiungere=-1; //gli id delle posizioni da raggiungere sono >=0
ros::Publisher pub_goal;
ros::Publisher pub_log;
ros::Subscriber sub_ob;
ros::Subscriber sub_tf;
ros::Timer timer1;
ros::Timer timer2;
tf2_ros::Buffer tfBuffer;

vector<float> target_positon(2, 0);
vector<float> old_position(2, 0);
vector<float> current_position(2, 0);
size_t n = 10;

void logger(std_msgs::String str)
{
  cerr << str.data << endl;
  pub_log.publish(str);
}

float distance(vector<float> a, vector<float> b){ 
  return sqrt(pow(a[0]-b[0],2) + pow(a[1]-b[1],2));
}

void check1_cb(const ros::TimerEvent &event)
{ 
  //creo già qua lo stato, poi riempio il msg dentro gli if
  std_msgs::String prova;
  prova.data = "ciao bellissimi sto partendo";
  logger(prova);
  if(cruising){

    if (distance(current_position,old_position) < 0.5)
    {
      // ROS_INFO("sono bloccato"); status da aggiornare
    }

    if (distance(current_position,target_positon) < 1.5)
    {
      //  ROS_INFO("qualcosa");
      // todo wait for message confirm ros::topic::waitForMessage	
      cruising = 0;
    }
    
  }
}

void check2_cb(const ros::TimerEvent &event)
{
  if(cruising) {
    if (distance(current_position,target_positon) < 1.5)
    {
      // todo deve pubblicare che ha problemi;
    }
  }
}

void position_cb(const tf2_msgs::TFMessage &tf)
{
  if (tfBuffer.canTransform("map", "base_link", ros::Time(0)))
  {
    geometry_msgs::TransformStamped transformStamped;
    transformStamped = tfBuffer.lookupTransform("map", "base_link", ros::Time(0));
    old_position[0] = current_position[0];
    old_position[1] = current_position[1];
    current_position[0] = transformStamped.transform.translation.x;
    current_position[1] = transformStamped.transform.translation.y;
  }
}

void obiettivo_cb(const dr_ped::Obiettivo &obiettivo)
{
  if (!cruising)
  {
    cruising = 1;

    geometry_msgs::PoseStamped new_goal_msg;

    new_goal_msg.header.seq = n++;
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

    std_msgs::String prova;
    prova.data = "ciao bellissimi sto partendo";
    logger(prova);

  }
}

int main(int argc, char **argv)
{

  ros::init(argc, argv, "dr_ped");
  ros::NodeHandle n;
  ros::Rate loop_rate(10);

  pub_goal = n.advertise<geometry_msgs::PoseStamped>("/move_base_simple/goal", 1000);
  pub_log = n.advertise<std_msgs::String>("/logger_web", 1000);
  sub_ob = n.subscribe("obiettivo", 1000, obiettivo_cb);

  sub_tf = n.subscribe("tf", 1000, position_cb);
  timer1 = n.createTimer(ros::Duration(2), check1_cb);
  timer2 = n.createTimer(ros::Duration(50), check2_cb);

  ros::spin();
}
