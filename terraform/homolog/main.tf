module "homolog" {
  source = "../"

  enviroment_name = "homolog"
  max_size = 2
  ecr_repository_name = "beanstalk_docker_hml"
}