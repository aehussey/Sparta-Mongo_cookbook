#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
apt_update 'update' do
    action :update
end

apt_repository 'mongodb-org' do
  uri "http://repo.mongodb.org/apt/ubuntu"
  distribution 'xenial/mongodb-org/3.2'
  components ['multiverse']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'EA312927'
end

template '/data/configdb/mongod.service' do
  source 'mongod.service.erb'
  variables proxy_port: 27017
  notifies :restart, 'service[mongodb-org]'
end

template '/data/configdb/mongod.conf' do
  source 'mongod.conf.erb'
  variables proxy_port: 27017
  notifies :restart, 'service[mongodb-org]'
end

package 'mongodb-org' do
  action [:upgrade, :install]
end

# service 'mongodb-org' do
#   action [:unmask, :enable, :start]
# end
