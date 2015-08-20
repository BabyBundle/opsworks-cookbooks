package 'ruby2.0' do
  :install
end

package 'awscli' do
  :install
end

remote_file "#{Chef::Config[:file_cache_path]}/codedeploy-agent_all.deb" do
  source 'https://s3.amazonaws.com/aws-codedeploy-us-east-1/latest/codedeploy-agent_all.deb'
  action :create
end

dpkg_package 'codedeploy-agent' do
  source "#{Chef::Config[:file_cache_path]}/codedeploy-agent_all.deb"
  action :install
end

service 'codedeploy-agent' do
  action [:enable, :start]
end
