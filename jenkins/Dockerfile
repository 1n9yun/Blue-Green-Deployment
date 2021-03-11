#공식 젠킨스 이미지를 베이스로 한다.
FROM jenkins/jenkins
#root 계정으로 변경(for docker install) 
USER root 
#DIND(docker in docker)를 위해 docker 안에서 docker를 설치 
COPY docker-install.sh /docker-install.sh 
RUN chmod +x /docker-install.sh 
RUN /docker-install.sh 
RUN usermod -aG docker jenkins 
USER jenkins

EXPOSE 8080
EXPOSE 50000