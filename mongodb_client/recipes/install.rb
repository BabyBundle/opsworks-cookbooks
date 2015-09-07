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

  execute "install_mongodb_client" do
    command "tar zxvf #{Chef::Config[:file_cache_path]}/mongodb-linux-x86_64-3.0.4.tgz -C #{Chef::Config[:file_cache_path]}/"
    user "root"
  end

  execute "clear_database" do
    command "source #{deploy[:deploy_to]}/shared/app.env && #{Chef::Config[:file_cache_path]}/mongodb-linux-x86_64-3.0.4/bin/mongo $DB_HOST/$DB_NAME -u $DB_USER -p $DB_PASSWORD < #{deploy[:deploy_to]}/current/scripts/cleanAndSeedDb.js"
  end
end
