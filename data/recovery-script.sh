#!/bin/bash
export PATH=/usr/bin:/usr/sbin
# This is what ADB did
systemctl mask systemd-journald
systemctl mask systemd-resolved
systemctl mask systemd-timesyncd


