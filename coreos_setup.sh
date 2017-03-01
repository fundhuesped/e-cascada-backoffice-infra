echo "Installing docker-compose"
curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /opt/bin/docker-compose
chmod +x /opt/bin/docker-compose
echo -e "\n\nAdding user to docker group"
usermod -a -G docker $APPUSER
