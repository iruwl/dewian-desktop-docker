#!/bin/bash
export USER="docker"

# start vnc server
# vncserver :1 -geometry 1280x700 -depth 24 && tail -F ~/.vnc/*.log
vncserver :${VNCDISPLAY} -geometry ${VNCGEOMETRY} -depth ${VNCDEPTH} && tail -F ~/.vnc/*.log
