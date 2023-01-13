#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

FROM ttbb/compile:rust AS build
COPY . /opt/compile
WORKDIR /opt/compile
RUN /root/.cargo/bin/cargo build --release

FROM shoothzj/base

WORKDIR /opt/mysql-dashboard

COPY --from=build /opt/compile/target/release/mysql-cli /opt/minio-dashboard/mysql-cli
COPY --from=build /opt/compile/target/release/mysql-dashboard /opt/mysql-dashboard/mysql-dashboard

RUN wget -q https://github.com/paas-dashboard/mysql-dashboard-portal/releases/download/latest/mysql-dashboard-portal.tar.gz && \
    tar -xzf mysql-dashboard-portal.tar.gz && \
    rm -rf mysql-dashboard-portal.tar.gz

EXPOSE 10004

CMD ["/usr/bin/dumb-init", "/opt/mysql-dashboard/mysql-dashboard"]
