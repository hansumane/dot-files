#!/bin/bash
set -e;

sudo sed 's/Exec=.*/#Exec=\/usr\/bin\/kwalletd5/g' -i /usr/share/dbus-1/services/org.kde.kwalletd5.service;
