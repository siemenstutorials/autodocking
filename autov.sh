#/bin/bash
##############################################################
#                                                            #
#                                                            #
# Author：Siemenstutorials                                   #
#                                                            #
# Youtube channel:https://www.youtube.com/c/siemenstutorials #
#                                                            #
#                                                            #
##############################################################
#check system
if [[ -f /etc/redhat-release ]]; then
  release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
  release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
  release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
  release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
  release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
  release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
  release="centos"
else
  echo -e "${red}未检测到系统版本，请联系脚本作者！${plain}\n" && exit 1
fi
if [ "$release" == "centos" ]; then
yum -y install wget curl 
else
apt-get -y install wget curl 
fi
#install_docker
curl -sSL https://get.docker.com | bash
service docker start
systemctl enable docker
#install base
SN=`cat /proc/sys/kernel/random/uuid`
mkdir /tmp/$SN
cd /tmp/$SN
#download_docker-compose.yml
wget https://raw.githubusercontent.com/siemenstutorials/sspanelv2ray/master/docker-compose.yml
#Setting_Docking
echo -e "\033[32m------------------Start to set the docking parameters------------------\033[0m"
echo
read -p "Please input NodeID(Default NodeID:1)：" Dockerid
[ -z "${Dockerid}" ] && Dockerid=1
echo
echo "-----------------------------------------------------"
echo "Dockerid = ${Dockerid}"
echo "-----------------------------------------------------"
echo
read -p "Please input URL(Default Url:https://www.xjycloud.xyz)：" Dockerurl
[ -z "${Dockerurl}" ] && Dockerurl=https://www.xjycloud.xyz
echo
echo "-----------------------------------------------------"
echo "dockerurl = ${Dockerurl}"
echo "-----------------------------------------------------"
echo
read -p "Please input KEY(Default Key:key)：" Dockerkey
[ -z "${Dockerkey}" ] && Dockerkey=key
echo
echo "-----------------------------------------------------"
echo "Dockerkey = ${Dockerkey}"
echo "-----------------------------------------------------"
echo
#donload_docker-compose
curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/1.8.0/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
clear
#config
sed -i "s|SMT|v${Dockerid}|" docker-compose.yml
sed -i "s|sspankey|${Dockerkey}|" docker-compose.yml
sed -i "s|68|${Dockerid}|" docker-compose.yml
sed -i "s|5109|${Dockerid}|" docker-compose.yml
sed -i "s|https://www.freecloud.pw|${Dockerurl}|" docker-compose.yml
docker-compose up -d
docker ps
echo $SN
