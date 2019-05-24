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
        && apt-get install --no-install-recommends -y nmap curl mosquitto-clients \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
        && chmod +x /run-application.sh

#HEALTHCHECK --interval=60s --timeout=15s --retries=3 CMD curl --silent --fail http://localhost:8080/ || exit 1
HEALTHCHECK --interval=150s --timeout=15s --retries=3 CMD curl --silent --fail http://localhost:8080/  && mosquitto_pub -d -h "127.0.0.1" -t "v1/devices/me/attributes" -u "9i3uWxbjKxmOKIU9F4X5" --id-prefix healthCheckmqtt- -m "{firmware_version:1.0.1, serial_number:SN-001}" || exit 1
