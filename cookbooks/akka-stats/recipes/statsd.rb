package "nodejs"

remote_file "#{Chef::Config[:file_cache_path]}/statsd_0.7.2.tar.gz" do
  source "https://github.com/etsy/statsd/archive/v0.7.2.tar.gz"
end

directory node["statsd"]["directory"] do
  action :create
end

execute "tar -C #{Chef::Config[:file_cache_path]} -zxvf #{Chef::Config[:file_cache_path]}/statsd_0.7.2.tar.gz"

execute "mv #{Chef::Config[:file_cache_path]}/statsd-0.7.2/* #{node['statsd']['directory']}" do
  not_if { ::File.exists?("#{node['statsd']['directory']}/stats.js")}
end

template "#{node['statsd']['directory']}/localConfig.js" do
  source "localConfig.js.erb"
end

template "/etc/init/statsd.conf" do
  source "statsd.erb"
end

execute "initctl reload-configuration"

service "statsd" do
  action :start
end