#!/bin/bash

if [ -z "$ROS_MASTER" ]; then
    IP=$(hostname -I | cut -d " " -f 1)
    echo "No \$ROS_MASTER was passed, defaulting to localhost/$(hostname)/$IP"
    export ROS_MASTER_URI=${ROS_MASTER_URI:-"http://$IP:11311/"}
    export ROS_IP=${IP}
elif ping -c 1 $ROS_MASTER; then
    export ROS_MASTER_URI="http://$ROS_MASTER:11311/"
elif ping -c 1 "$ROS_MASTER.local"; then
    export ROS_MASTER_URI="http://$ROS_MASTER.local:11311/"
else
    echo -e "Neither $ROS_MASTER nor $ROS_MASTER.local are reachable, aborting."
    exit 1
fi

echo "Setting ROS_MASTER_URI to $ROS_MASTER_URI"

ros_master_binding="$IP $ROS_MASTER $ROS_MASTER.local"
echo "Writing \"$ros_master_binding\" into /etc/hosts"
echo $ros_master_binding >> /etc/hosts

if [ -z "$DUCKIEBOT_NAME" ] && [ -z "$DUCKIEBOT_IP" ]; then
    duckiebot_binding="$DUCKIEBOT_IP $DUCKIEBOT_NAME $DUCKIEBOT_NAME.local"
    echo "Writing \"$duckiebot_binding\" into /etc/hosts"
    echo $duckiebot_binding >> /etc/hosts
fi

source /home/software/environment.sh
export DUCKIEFLEET_ROOT=/data/config
export VEHICLE_NAME=$HOSTNAME
cat misc/duckie.art

/home/software/docker/init_config_defaults.sh
