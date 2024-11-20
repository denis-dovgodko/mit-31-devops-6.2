variable "subnets" {
  type = list(string)
  default = ["subnet-0cea91374bde86db7","subnet-0a93500ff81ca0d41","subnet-0cea91374bde86db7"]
}

variable "image_tag" {
  default = "latest"
}