# sunkenland
Files to create the Sunkenland dedicated server on Ubuntu using Docker and Wine.

Note that this repo creates two images:
1. The first is based on Ubuntu, and adds Wine and Steamcmd to create an image called "wine-steamcmd"
2. The second is based the image above ("wine-steamcmd"), and installs the Sunkenland Dedicated Server

You can find the Docker image on Docker Hub:
https://hub.docker.com/r/adrianhowchin/sunkenland

To run the server, please see the instructions in the Docker Hub link above.

To see which versions this works against, see the Docker link above.
