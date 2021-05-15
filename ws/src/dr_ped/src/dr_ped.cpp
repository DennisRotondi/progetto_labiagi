#include "ros/ros.h"
#include <vector>
#include "geometry_msgs/PoseStamped.h"
#include "std_msgs/String.h"
#include "dr_ped/Obiettivo.h"
using namespace std;

int main(int argc, char **argv){
  cerr << "hello world" << endl;
  ros::init(argc, argv, "Set_Goal");
  ros::NodeHandle n;
  ros::Publisher pub = n.advertise<geometry_msgs::PoseStamped>("/move_base_simple/goal", 1000);

















}


