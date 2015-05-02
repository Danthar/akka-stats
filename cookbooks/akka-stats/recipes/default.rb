#
# Cookbook Name:: akka-stats
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "apt-get update"

include_recipe "akka-stats::graphite_setup"

include_recipe "akka-stats::statsd"

remote_file "#{Chef::Config[:file_cache_path]}/grafana_2.0.2_amd64.deb" do
  source "https://grafanarel.s3.amazonaws.com/builds/grafana_2.0.2_amd64.deb"
end

package ["libfontconfig"]

dpkg_package "#{Chef::Config[:file_cache_path]}/grafana_2.0.2_amd64.deb" do
  action :install
end

service "grafana-server" do
  action :start
end