DOCKER_APP_NAME=temp-api

EXIST_BLUE=$(docker-compose -p ${DOCKER_APP_NAME}-blue -f docker-compose.blue.yml ps | grep Up)

if [ -z "$EXIST_BLUE" ]; then
    docker-compose -p ${DOCKER_APP_NAME}-green -f docker-compose.green.yml down
else
    docker-compose -p ${DOCKER_APP_NAME}-blue -f docker-compose.blue.yml down
fi

docker-compose -p nginx -f docker-compose.nginx.yml down
