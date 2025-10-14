local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- Basic resource
  s("resource", fmt([[
    resource "{provider}" "{name}" {{
      {config}
    }}
  ]], {
    provider = i(1, "aws_instance"),
    name = i(2, "example"),
    config = i(0, "# Configuration here")
  })),

  -- AWS VPC
  s("vpc", fmt([[
    resource "aws_vpc" "{name}" {{
      cidr_block           = "{cidr}"
      enable_dns_hostnames = true
      enable_dns_support   = true
      
      tags = {{
        Name = "{tag_name}"
      }}
    }}
    
    resource "aws_internet_gateway" "{name}_igw" {{
      vpc_id = aws_vpc.{name}.id
      
      tags = {{
        Name = "{tag_name}-igw"
      }}
    }}
    
    resource "aws_subnet" "{name}_public" {{
      vpc_id                  = aws_vpc.{name}.id
      cidr_block              = "{subnet_cidr}"
      availability_zone       = "{az}"
      map_public_ip_on_launch = true
      
      tags = {{
        Name = "{tag_name}-public"
      }}
    }}
  ]], {
    name = i(1, "main"),
    cidr = i(2, "10.0.0.0/16"),
    tag_name = i(3, "Main VPC"),
    subnet_cidr = i(4, "10.0.1.0/24"),
    az = i(0, "us-west-2a")
  })),

  -- AWS EC2 instance
  s("ec2", fmt([[
    resource "aws_instance" "{name}" {{
      ami                    = "{ami_id}"
      instance_type          = "{instance_type}"
      key_name              = "{key_name}"
      vpc_security_group_ids = [aws_security_group.{sg_name}.id]
      subnet_id             = aws_subnet.{subnet_name}.id
      
      user_data = <<-EOF
        #!/bin/bash
        {user_data}
      EOF
      
      tags = {{
        Name = "{tag_name}"
      }}
    }}
  ]], {
    name = i(1, "web_server"),
    ami_id = i(2, "ami-0c55b159cbfafe1d0"),
    instance_type = c(3, {t("t3.micro"), t("t3.small"), t("t3.medium")}),
    key_name = i(4, "my-key"),
    sg_name = i(5, "web_sg"),
    subnet_name = i(6, "main_public"),
    user_data = i(7, "yum update -y"),
    tag_name = i(0, "Web Server")
  })),

  -- Security Group
  s("sg", fmt([[
    resource "aws_security_group" "{name}" {{
      name        = "{sg_name}"
      description = "{description}"
      vpc_id      = aws_vpc.{vpc_name}.id
      
      ingress {{
        from_port   = {from_port}
        to_port     = {to_port}
        protocol    = "{protocol}"
        cidr_blocks = ["{cidr}"]
      }}
      
      egress {{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }}
      
      tags = {{
        Name = "{tag_name}"
      }}
    }}
  ]], {
    name = i(1, "web_sg"),
    sg_name = rep(1),
    description = i(2, "Security group for web servers"),
    vpc_name = i(3, "main"),
    from_port = i(4, "80"),
    to_port = i(5, "80"),
    protocol = i(6, "tcp"),
    cidr = i(7, "0.0.0.0/0"),
    tag_name = i(0, "Web Security Group")
  })),

  -- Variables
  s("variables", fmt([[
    variable "{name}" {{
      description = "{description}"
      type        = {type}
      default     = {default}
    }}
  ]], {
    name = i(1, "instance_type"),
    description = i(2, "EC2 instance type"),
    type = c(3, {t("string"), t("number"), t("bool"), t("list(string)"), t("map(string)")}),
    default = i(0, "\"t3.micro\"")
  })),

  -- Output
  s("output", fmt([[
    output "{name}" {{
      description = "{description}"
      value       = {value}
    }}
  ]], {
    name = i(1, "instance_ip"),
    description = i(2, "The public IP of the instance"),
    value = i(0, "aws_instance.web_server.public_ip")
  })),

  -- Data source
  s("data", fmt([[
    data "{provider}" "{name}" {{
      {config}
    }}
  ]], {
    provider = i(1, "aws_ami"),
    name = i(2, "ubuntu"),
    config = i(0, "most_recent = true")
  })),

  -- Locals
  s("locals", fmt([[
    locals {{
      {values}
    }}
  ]], {
    values = i(0, "common_tags = {\n    Environment = \"dev\"\n    Project     = \"my-project\"\n  }")
  })),

  -- Provider
  s("provider", fmt([[
    terraform {{
      required_providers {{
        aws = {{
          source  = "hashicorp/aws"
          version = "~> {version}"
        }}
      }}
    }}
    
    provider "aws" {{
      region = "{region}"
    }}
  ]], {
    version = i(1, "5.0"),
    region = i(0, "us-west-2")
  })),

  -- Module
  s("module", fmt([[
    module "{name}" {{
      source = "{source}"
      
      {config}
    }}
  ]], {
    name = i(1, "vpc"),
    source = i(2, "./modules/vpc"),
    config = i(0, "cidr_block = \"10.0.0.0/16\"")
  })),
}