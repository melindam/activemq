#
# Cookbook Name:: activemq
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
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

include_recipe 'java::default'
include_recipe 'ark'

tmp = Chef::Config[:file_cache_path]
version = node['activemq']['version']
mirror = node['activemq']['mirror']
activemq_home = "#{node['activemq']['home']}/apache-activemq"

user node['activemq']['run_as_user'] do
  comment "ActiveMQ user"
  action :create
end

ark "apache-activemq" do
  url "#{mirror}/activemq/apache-activemq/#{version}/apache-activemq-#{version}-bin.tar.gz"
  path node['activemq']['home']
  version version
  owner node['activemq']['run_as_user'] 
  group node['activemq']['run_as_user']
  action :install
  not_if { File.exists?("#{activemq_home}/bin/activemq") }
end

# TODO: make this more robust
arch = node['kernel']['machine'] == 'x86_64' ? 'x86-64' : 'x86-32'

link '/etc/init.d/activemq' do
  to "#{activemq_home}/bin/linux-#{arch}/activemq"
end

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['activemq']['simple_auth_password'] = secure_password 

template "#{activemq_home}/conf/activemq.xml" do
  source   'activemq.xml.erb'
  mode     '0755'
  owner    node['activemq']['run_as_user'] 
  group    node['activemq']['run_as_user'] 
  variables(
    :broker_user => node['activemq']['simple_auth_user'],
    :broker_password => node['activemq']['simple_auth_password']
  )
  notifies :restart, 'service[activemq]'
#  only_if  { node['activemq']['use_default_config'] }
end

template "#{activemq_home}/conf/jetty.xml" do
  source   'jetty.xml.erb'
  mode     '0755'
  owner    node['activemq']['run_as_user']
  group    node['activemq']['run_as_user']
  notifies :restart, 'service[activemq]'
  only_if  { node['activemq']['admin_console']['customize'] }
end

template "#{activemq_home}/conf/jetty-realm.properties" do
  source   'jetty-realm.properties.erb'
  mode     '0755'
  owner    node['activemq']['run_as_user']
  group    node['activemq']['run_as_user']
  notifies :restart, 'service[activemq]'
  only_if  { node['activemq']['admin_console']['credentials']['customize'] }
end

template '/etc/sysconfig/activemq' do
  source 'sysconfig.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables( 
      :run_as_user => node['activemq']['run_as_user'],
      :java_home => node['activemq']['java_home']
  )
  notifies :restart, 'service[activemq]', :delayed
end

service 'activemq' do
  supports :restart => true, :status => true
  action   [:enable, :start]
end

# symlink so the default wrapper.conf can find the native wrapper library
link "#{activemq_home}/bin/linux" do
  to "#{activemq_home}/bin/linux-#{arch}"
end

# symlink the wrapper's pidfile location into /var/run
link '/var/run/activemq.pid' do
  to "#{activemq_home}/bin/linux/ActiveMQ.pid"
  not_if 'test -f /var/run/activemq.pid'
end

template "#{activemq_home}/bin/linux/wrapper.conf" do
  source   'wrapper.conf.erb'
  mode     '0644'
  notifies :restart, 'service[activemq]', :delayed
end

template "#{activemq_home}/conf/login.config" do
  source 'login.config.erb'
  mode    '0644'
  notifies :restart, 'service[activemq]', :delayed
end

template "#{activemq_home}/conf/users.properties" do
  source 'users.properties.erb'
  mode    '0644'
  notifies :restart, 'service[activemq]', :delayed
end

template "#{activemq_home}/conf/groups.properties" do
  source 'groups.properties.erb'
  mode    '0644'
  notifies :restart, 'service[activemq]', :delayed
end
