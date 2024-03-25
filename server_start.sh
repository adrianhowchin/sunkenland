#!/bin/bash
# Pull in variables from our docker run command
PASSWORD=${dPASSWORD}
GUID=${dGUID}
REGION=${dREGION}

set SteamAppId=2080690

# Clean up wine and init
# The server fails to start if we try to do this in our Dockerfile, so need to do it here in the server start script
rm -rf ~/.wine
wineboot --init
sleep 15 # Need to sleep to give wineboot init time to complete

# Setup the world
# The server fails to start if we try to do this in our Dockerfile, so need to do it here in the server start script
mkdir -p /root/.wine/drive_c/users/root/AppData/LocalLow/Vector3\ Studio/Sunkenland/
cd /root/.wine/drive_c/users/root/AppData/LocalLow/Vector3\ Studio/Sunkenland/
ln -s /opt/sunkenland/Worlds /root/.wine/drive_c/users/root/AppData/LocalLow/Vector3\ Studio/Sunkenland/Worlds
cd /opt/sunkenland

# Start Xvfb so the headless graphics works
Xvfb :1 &
export DISPLAY=:1
echo "Xfvb server start at :1"

# Start the Sunkenland server
cd "/root/Steam/steamapps/common/Sunkenland Dedicated Server"
wine Sunkenland-DedicatedServer.exe -nographics -batchmode -logFile /opt/sunkenland/Worlds/sunkenland.log -maxPlayerCapacity 10 -password ${PASSWORD} -worldGuid ${GUID} -region ${REGION}

# If you want to change the ports (e.g. because of a port conflict say with Palworld), use the "-port" and "-queryport" arguments. It would then look like this:
# wine Sunkenland-DedicatedServer.exe -nographics -batchmode -logFile /opt/sunkenland/Worlds/sunkenland.log -maxPlayerCapacity 10 -password ${PASSWORD} -worldGuid ${GUID} -region ${REGION} -port 29000 -queryport 29005
