#!/bin/bash

image_plex_autoscan_ref=`docker run $GITHUB_REPOSITORY "git --work-tree=/opt/plex_autoscan rev-parse HEAD"`
image_s6_release=`docker run $GITHUB_REPOSITORY "cat /etc/S6_RELEASE"`
image_rclone_version=`docker run $GITHUB_REPOSITORY "rclone version" | grep rclone | awk '{print $2}'`

current_plex_autoscan_ref=`curl -sX GET "https://api.github.com/repos/l3uddz/plex_autoscan/commits/develop" | jq '.sha' | tr -d '"'`
current_s6_release=`curl -sX GET "https://api.github.com/repos/just-containers/s6-overlay/releases/latest" | jq '.tag_name' | tr -d '"'`
current_rclone_version=`docker run rclone/rclone "version" | grep rclone | awk '{print $2}'`

if [ $image_rclone_version != $current_rclone_version ]
then
    echo "New version of rclone is available."
    build=1
fi
if [ $image_plex_autoscan_ref != $current_plex_autoscan_ref ]
then
    echo "New version of plex_autoscan is available."
    build=1
fi
if [ $image_s6_release != $current_s6_release ]
then
    echo "New version of s6-overlay is available."
    build=1
fi

if [[ $build ]]
then
    echo "Triggering build."
    echo "::set-output name=build::true"
else
    echo "No build needed."
    echo "::set-output name=build::false"
fi
