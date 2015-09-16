remote_file "#{Chef::Config[:file_cache_path]}/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb" do
  source "http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb"
  owner "root"
  group "root"
end

execute "install_wkhtmltopdf" do
  command "gdebi -n #{Chef::Config[:file_cache_path]}/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb"
  user "root"
end
