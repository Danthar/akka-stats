package ["graphite-web", "graphite-carbon", "apache2", "libapache2-mod-wsgi"]

execute "graphite-manage syncdb --noinput"

file "/var/lib/graphite/graphite.db" do
  user "_graphite"
  group "_graphite"
end

template "/etc/default/graphite-carbon" do
  source "graphite-carbon.erb"
end

service "carbon-cache" do
  action :start
end

file "/etc/apache2/sites-available/default-ssl.conf" do
  action :delete
end

execute "a2dissite 000-default" do
  only_if { ::File.exists?("/etc/apache2/sites-available/000-default.conf")}
end

file "/etc/apache2/sites-available/000-default.conf" do
  action :delete
end

execute "cp /usr/share/graphite-web/apache2-graphite.conf /etc/apache2/sites-available"

execute "a2ensite apache2-graphite"

service "apache2" do
  action :restart
end