module "producao" {
  source = "../"

  enviroment_name = "producao"
  max_size = 3
  ecr_repository_name = "beanstalk_docker_prd"
}