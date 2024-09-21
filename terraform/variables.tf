variable "instance_type" {
  description = ""
  default     = "t2.micro"
}

variable "key_pair" {
  description = ""
  type        = string
  default     = "key1"
}

variable "mumbai_security_group_id" {
  description = ""
  type        = string
  default     = "sg-09275c9293c2a7d49"
}

variable "virginia_security_group_id" {
  description = ""
  type        = string
  default     = "sg-0e308b6d46cf03afa"
}

variable "source_bucket_name" {
  default = "shopease-main"
}

variable "destination_bucket_name" {
  default = "shopease-backup1"
}