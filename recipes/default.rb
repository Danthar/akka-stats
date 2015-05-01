#
# Cookbook Name:: akka-stats
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "graphite"
include_recipe "statsd"
include_recipe "grafana"