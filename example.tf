#module "example-domain" {
#  source = "git@github.com:TAKEALOT/data-engineering-team-tools//bq-pipelines/domain"
#  project_id = var.project_id
#
#  name = "example-domain"
#}
#
#module "example-pipeline" {
#  source = "git@github.com:TAKEALOT/data-engineering-team-tools//bq-pipelines/pipeline"
#  kafka_parameters = var.kafka_parameters
#
#  # Edit below the line
#  name = "example-pipeline"
#  domain_name = module.example-domain.name
#  domain_parameters = module.example-domain.domain_parameters
#}
#
