require 'tmpdir'

module OpsWorks
  module SCM
    module CodeDeploy
      def prepare_codedeploy_checkouts(scm_options)
        directory "/srv/www/codedeploy" do
          action :create
          not_if do
            File.exists?("/srv/www/codedeploy")
          end
        end

        execute 'create git repository' do
          cwd "/srv/www/codedeploy"
          command "find . -type d -name .git -exec rm -rf {} \\;; find . -type f -name .gitignore -exec rm -f {} \\;; git init; git add .; git config user.name 'AWS OpsWorks'; git config user.email 'root@localhost'; git commit -m 'Create temporary repository from downloaded contents.'"
        end

        "/srv/www/codedeploy"
      end
    end
  end
end

class Chef::Recipe
  include OpsWorks::SCM::CodeDeploy
end
