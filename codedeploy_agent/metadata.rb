name        "codedeploy_agent"
description "Installs and configures CodeDeploy agent"

depends 'awscli'

recipe 'codedeploy_agent::install', "Installs CodeDeploy agent"
