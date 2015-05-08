#
# Cookbook Name:: activemq
# Attributes:: default
#
# Copyright 2009-2011, Opscode, Inc.
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
default['java']['jdk_version'] = 8
default['java']['install_flavor'] = 'oracle'
default['java']['oracle']['accept_oracle_download_terms'] = true
# Hard coding for now, need to get found
default['activemq']['java_home'] = '/usr/lib/jvm/jdk1.8.0_20'

default['activemq']['usejmx'] = true
default['activemq']['run_as_user'] = 'activemq'
default['activemq']['simple_auth'] = true

default['activemq']['mirror']  = 'https://repository.apache.org/content/repositories/releases/org/apache'
default['activemq']['version'] = '5.11.0'
default['activemq']['home']  = '/usr/local'
default['activemq']['wrapper']['max_memory'] = '1024'
default['activemq']['wrapper']['useDedicatedTaskRunner'] = 'true'
default['activemq']['wrapper']['keystore_password'] = 'password'
default['activemq']['wrapper']['truststore_password'] = 'password'
default['activemq']['wrapper']['keystore_path'] = '%ACTIVEMQ_CONF%/broker.ks'
default['activemq']['wrapper']['truststore_path'] = '%ACTIVEMQ_CONF%/broker.ts'

default['activemq']['enable_stomp'] = false
# default['activemq']['use_default_config'] = false

#Properties related to 'activemq' 'broker'.
default['activemq']['broker_name'] = 'localhost'

#Admin console properties
default['activemq']['admin_console']['customize'] = false
default['activemq']['admin_console']['port'] = '8161'
default['activemq']['admin_console']['credentials']['customize'] = true
default['activemq']['admin_console']['credentials']['user_name'] = 'admin'
default['activemq']['admin_console']['credentials']['password'] = 'admin'
default['activemq']['admin_console']['new_admin_console_name'] = 'admin'


