#!/usr/bin/env bash

brew install openssh
launchctl disable user/`id -u`/com.openssh.ssh-agent
cp org.accola.ssh_agent.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/org.accola.ssh_agent.plist
# also `launchctl enable` if the above doesn't work

