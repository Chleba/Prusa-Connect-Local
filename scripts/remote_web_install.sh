#!/bin/sh

# This file is part of the SL1 firmware
# Copyright (C) 2014-2018 Futur3d - www.futur3d.net
# Copyright (C) 2018-2019 Prusa Research s.r.o. - www.prusa3d.com
# SPDX-License-Identifier: GPL-3.0-or-later

# Resolve target
if [ "$#" -ne 1 ]; then
    echo "Please provide target ip as the only argument"
    exit -1
fi
target=${1}
echo "Target is ${target}"

echo "Building"
rm -fr dist/*
npm run ui:build

echo "Removing remote web"
ssh root@${target} "rm -rf /srv/http/intranet/*"

echo "Installing on target"
scp -r dist/* root@${target}:/srv/http/intranet/

echo "Done"
