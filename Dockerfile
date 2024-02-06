FROM ubuntu:22.04

RUN mkdir /opt/sunkenland
WORKDIR /opt/sunkenland

# Install utils to help make life easier. We need X Virtual Framebuffer for the graphics, even though its headless?
RUN apt update;
RUN apt install unzip wget vim xvfb net-tools -y

# Install Wine so that we can run Windows programs under Linux
RUN dpkg --add-architecture i386; mkdir -pm755 /etc/apt/keyrings;
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key;
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources;
RUN apt update;
RUN apt install --install-recommends winehq-stable -y

# Install Steamcmd
# For info, see: https://developer.valvesoftware.com/wiki/SteamCMD
RUN add-apt-repository multiverse; apt update
RUN echo steam steam/question select "I AGREE" | debconf-set-selections; echo steam steam/license note '' | debconf-set-selections
RUN apt install steamcmd -y; ln -s /usr/games/steamcmd /usr/bin/steamcmd
# Now that we have Steamcmd installed, install the Sunkenland Dedicated Server from Steam
RUN steamcmd +login anonymous +@sSteamCmdForcePlatformType windows +app_update 2667530 validate +quit

# Copy in the server start script
COPY server_start.sh .

# The command that runs on containr start
CMD /opt/sunkenland/server_start.sh

# Make sure you setup port forwarding on your router for port 27015 (if required)
EXPOSE 27015
