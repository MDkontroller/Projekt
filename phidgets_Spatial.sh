##
#   Command shell für die Installation und Inbetriebnahme  Phigets-Spatial Magnetometer
#-----------------------------------------------------------------------------------------

git clone -b noetic https://github.com/ros-drivers/phidgets_drivers.git
rosdep install phidgets_drivers             # Install dependencies using rosdep
cd ..
catkin_make

# To set up the udev rules for the Phidgets USB devices, run the following commands:
#------------------------------------------------------------------------------------------

roscd phidgets_api
sudo cp debian/udev /etc/udev/rules.d/99-phidgets.rules
sudo udevadm control --reload-rules


sudo apt install ros-noetic-imu-filter-madgwick

#  dmesg 

roslaunch phidgets_spatial spatial.launch
