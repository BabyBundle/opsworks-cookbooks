package 'codedeploy-agent' do
  action :install
end

service 'codedeploy-agent' do
  action [:enable, :start]
end
