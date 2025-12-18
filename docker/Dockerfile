# Argument definiujący obraz bazowy (przekazywany dynamicznie z docker-compose)
ARG BASE_IMAGE=osrf/ros:humble-desktop
FROM ${BASE_IMAGE}

# Ustawienie zmiennych środowiskowych, aby uniknąć interakcji podczas instalacji
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=humble

# 1. Instalacja zależności systemowych i narzędzi deweloperskich
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-colcon-common-extensions \
    git \
    can-utils \
    net-tools \
    udev \
    nano \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 2. Konfiguracja przestrzeni roboczej
WORKDIR /root/ros2_ws

# 3. Kopiowanie skryptu entrypoint (musi istnieć w folderze docker/)
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc

# 4. Ustawienie powłoki i punktu wejścia
SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
