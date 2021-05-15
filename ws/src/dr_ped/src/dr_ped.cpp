#include "ros/ros.h"
#include <vector>
#include "geometry_msgs/PoseStamped.h"
#include "std_msgs/String.h"
#include "dr_ped/Obiettivo.h"
using namespace std;

//globals
int busy=0;
ros::Publisher pub_goal;
ros::Publisher pub_log;
ros::Subscriber sub;
size_t n = 10;

void logger(std_msgs::String str){
  cerr << str.data << endl;
  pub_log.publish(str);
}

void obiettivo_cb(const dr_ped::Obiettivo& obiettivo)
{
    if(!busy){
      busy=1;

      geometry_msgs::PoseStamped new_goal_msg;
      
      new_goal_msg.header.seq  = n++;
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

      busy=0;
    }
}

int main(int argc, char **argv){
  
  
  ros::init(argc, argv, "dr_ped");
  ros::NodeHandle n;
  ros::Rate loop_rate(10);

  pub_goal = n.advertise<geometry_msgs::PoseStamped>("/move_base_simple/goal", 1000);
  pub_log = n.advertise<std_msgs::String>("/logger_web", 1000);
  sub = n.subscribe("obiettivo", 1000, obiettivo_cb);

  std_msgs::String prova;
  prova.data="ciao bellissimi";
  logger(prova);
  // ros::Subscriber sub_tf = n.subscribe("tf", 1000, position_cb);
  // ros::Timer timer1 = n.createTimer(ros::Duration(0.5), check1_cb);
  // ros::Timer timer2 = n.createTimer(ros::Duration(50), check2_cb);

  ros::spin();
}


