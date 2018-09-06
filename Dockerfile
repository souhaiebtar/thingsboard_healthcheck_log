#
# Copyright © 2016-2018 The Thingsboard Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM openjdk:8-jre

ADD run-application.sh /run-application.sh
ADD thingsboard.deb /thingsboard.deb


RUN apt-get update \
        && apt-get install --no-install-recommends -y nmap curl libmosquitto1 \
        && curl -fLo mosquitto-clients.deb  https://github.com/souhaiebtar/debs/blob/master/mosquitto-clients_1.4.10-3+deb9u1_amd64.deb?raw=true \
        && dpkg -i mosquitto-clients.deb \
        && rm -f mosquitto-clients.deb \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
        && chmod +x /run-application.sh

HEALTHCHECK --interval=60s --timeout=15s --retries=3 CMD curl --silent --fail http://localhost:8080/ || exit 1
