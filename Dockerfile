FROM ros:melodic

# Disable interactive mode
ARG DEBIAN_FRONTEND=noninteractive

# Switch to Japanese server for installation speed
RUN sed -i 's|http://archive.|http://jp.archive.|g' /etc/apt/sources.list

# Install Docker GUI support
RUN \
  apt-get update && \
  apt-get -y install libgl1-mesa-glx libgl1-mesa-dri libgtk-3-dev libcanberra-gtk-module libcanberra-gtk3-module \
  mesa-utils xserver-xorg-video-all software-properties-common libnvidia-gl-440 && \
  rm -rf /var/lib/apt/lists/*

# Install assuremappingtools required libraries
RUN \
  apt-get update && \
  apt-get -y install freeglut3 libglew2.0 libgeographic17 libtinyxml2-6 libpugixml1v5 \
  ros-melodic-pcl-ros libopencv-dev ros-melodic-cv-bridge && \
  rm -rf /var/lib/apt/lists/*

# Add assuremappingtools binaries into the image
COPY ./bin /assuremappingtools

# Setup the enviroment and startup commands
ENV LD_LIBRARY_PATH=/assuremappingtools/libs:$LD_LIBRARY_PATH
ENV PATH=/assuremappingtools:$PATH
WORKDIR /assuremappingtools
CMD assure_map_editor
