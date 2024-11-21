module "ecs" {
  source = "terraform-aws-modules/ecs/aws"
  version = "5.11.4"

  cluster_name = "lab6-ecs"
  services = {
    lab6-service = {
      desired_count               = 1
      enable_autoscaling          = false
      assign_public_ip            = true
      container_definitions = {
        java-app = {
          essential             = true
          image                 = "denisdovgodko/javaapp:${var.image_tag}"
          interactive           = true
          pseudo_terminal       = true
          cpu       = 256
          memory    = 512
          port_mappings         = [
            {
              name          = "port-mapping"
              containerPort = 8080
              hostPort      = 8080
              protocol      = "tcp"
            }
          ]
          readonly_root_filesystem = false
        }
      }
      subnet_ids = var.subnets
      security_group_rules = {
          ingress_http = {
            type                     = "ingress"
            from_port                = 8080
            to_port                  = 8080
            protocol                 = "tcp"
            description              = "HTTP port"
            cidr_blocks = ["0.0.0.0/0"]
          }
          ingress_ssh = {
            type                     = "ingress"
            from_port                = 22
            to_port                  = 22
            protocol                 = "tcp"
            description              = "SSH port"
            cidr_blocks = ["0.0.0.0/0"]
          }
          egress_all = {
            type        = "egress"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
          }

        }
    }
  }

}