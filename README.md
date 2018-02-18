# AWS DeepLearning Setup

the script only test in ubuntu 14.04,PLEASE ATTENTION

## First
you have to be sure that you can use AWS GPU instance (g2 series) or AWS GPU compute (p-series) instance

## Environment
my shell script will setup the environment as(test in ubuntu 14.04):

Name|versions
-|:-:|
Nvidia setup|384.11
cuda|8.0
cudnn|6.0
anaconda3|4.4.0
tensorflow|1.3
keras|2.0+
OpenCV_python|3.3+

if you want to change the version,please check the script,read the note and change the code

## use AMI
if you don't want to use the script for everytime you setup the instance,please make an AMI for yourself. 