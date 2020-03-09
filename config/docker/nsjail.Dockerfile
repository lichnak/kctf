# Copyright 2020 Google LLC
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     https://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM ubuntu:19.10

ENV BUILD_PACKAGES build-essential git protobuf-compiler libprotobuf-dev bison flex pkg-config libnl-route-3-dev ca-certificates

RUN apt-get update \
    && apt-get install -yq --no-install-recommends $BUILD_PACKAGES \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/google/nsjail.git \
    && cd /nsjail && make -j && cp nsjail /usr/bin/ \
    && rm -R /nsjail && apt-get remove --purge -y $BUILD_PACKAGES $(apt-mark showauto)
