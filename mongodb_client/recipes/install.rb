node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::nodejs application #{application} as it is not a node.js app")
    next
  end

  remote_file "#{Chef::Config[:file_cache_path]}/mongodb-linux-x86_64-3.0.4.tgz" do
      source "http://downloads.mongodb.org/linux/mongodb-linux-x86_64-3.0.4.tgz"
      mode "0644"
      owner "root"
      group "root"
  end

  bash 'install_mongodb_and_run_script' do
    cwd Chef::Config[:file_cache_path]
    code <<-EOF
      source #{deploy[:deploy_to]}/shared/app.env
      tar zxvf mongodb-linux-x86_64-3.0.4.tgz
      ./mongodb-linux-x86_64-3.0.4/bin/mongo $DB_HOST/$DB_NAME -u $DB_USER -p $DB_PASSWORD < #{deploy[:deploy_to]}/current/scripts/cleanAndSeedDb.js
    EOF
  end

end
