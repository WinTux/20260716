FROM jenkins/jenkins:latest-jdk25
USER root
RUN apt-get update && \
    apt-get install -y python3 python3-venv ansible
USER jenkins
