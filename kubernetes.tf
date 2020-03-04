locals = {
  cluster_name                 = "sgallagher-kops.chef-demo.com"
  master_autoscaling_group_ids = ["${aws_autoscaling_group.master-us-east-1a-masters-sgallagher-kops-chef-demo-com.id}"]
  master_security_group_ids    = ["${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"]
  masters_role_arn             = "${aws_iam_role.masters-sgallagher-kops-chef-demo-com.arn}"
  masters_role_name            = "${aws_iam_role.masters-sgallagher-kops-chef-demo-com.name}"
  node_autoscaling_group_ids   = ["${aws_autoscaling_group.nodes-sgallagher-kops-chef-demo-com.id}"]
  node_security_group_ids      = ["${aws_security_group.nodes-sgallagher-kops-chef-demo-com.id}"]
  node_subnet_ids              = ["${aws_subnet.us-east-1a-sgallagher-kops-chef-demo-com.id}"]
  nodes_role_arn               = "${aws_iam_role.nodes-sgallagher-kops-chef-demo-com.arn}"
  nodes_role_name              = "${aws_iam_role.nodes-sgallagher-kops-chef-demo-com.name}"
  region                       = "us-east-1"
  route_table_public_id        = "${aws_route_table.sgallagher-kops-chef-demo-com.id}"
  subnet_us-east-1a_id         = "${aws_subnet.us-east-1a-sgallagher-kops-chef-demo-com.id}"
  vpc_cidr_block               = "${aws_vpc.sgallagher-kops-chef-demo-com.cidr_block}"
  vpc_id                       = "${aws_vpc.sgallagher-kops-chef-demo-com.id}"
}

output "cluster_name" {
  value = "sgallagher-kops.chef-demo.com"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-east-1a-masters-sgallagher-kops-chef-demo-com.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-sgallagher-kops-chef-demo-com.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-sgallagher-kops-chef-demo-com.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-sgallagher-kops-chef-demo-com.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-sgallagher-kops-chef-demo-com.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-east-1a-sgallagher-kops-chef-demo-com.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-sgallagher-kops-chef-demo-com.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-sgallagher-kops-chef-demo-com.name}"
}

output "region" {
  value = "us-east-1"
}

output "route_table_public_id" {
  value = "${aws_route_table.sgallagher-kops-chef-demo-com.id}"
}

output "subnet_us-east-1a_id" {
  value = "${aws_subnet.us-east-1a-sgallagher-kops-chef-demo-com.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.sgallagher-kops-chef-demo-com.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.sgallagher-kops-chef-demo-com.id}"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_autoscaling_group" "master-us-east-1a-masters-sgallagher-kops-chef-demo-com" {
  name                 = "master-us-east-1a.masters.sgallagher-kops.chef-demo.com"
  launch_configuration = "${aws_launch_configuration.master-us-east-1a-masters-sgallagher-kops-chef-demo-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-1a-sgallagher-kops-chef-demo-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "sgallagher-kops.chef-demo.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-1a.masters.sgallagher-kops.chef-demo.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-1a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-sgallagher-kops-chef-demo-com" {
  name                 = "nodes.sgallagher-kops.chef-demo.com"
  launch_configuration = "${aws_launch_configuration.nodes-sgallagher-kops-chef-demo-com.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-east-1a-sgallagher-kops-chef-demo-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "sgallagher-kops.chef-demo.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.sgallagher-kops.chef-demo.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-sgallagher-kops-chef-demo-com" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                     = "sgallagher-kops.chef-demo.com"
    Name                                                  = "a.etcd-events.sgallagher-kops.chef-demo.com"
    "k8s.io/etcd/events"                                  = "a/a"
    "k8s.io/role/master"                                  = "1"
    "kubernetes.io/cluster/sgallagher-kops.chef-demo.com" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-sgallagher-kops-chef-demo-com" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                     = "sgallagher-kops.chef-demo.com"
    Name                                                  = "a.etcd-main.sgallagher-kops.chef-demo.com"
    "k8s.io/etcd/main"                                    = "a/a"
    "k8s.io/role/master"                                  = "1"
    "kubernetes.io/cluster/sgallagher-kops.chef-demo.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-sgallagher-kops-chef-demo-com" {
  name = "masters.sgallagher-kops.chef-demo.com"
  role = "${aws_iam_role.masters-sgallagher-kops-chef-demo-com.name}"
}

resource "aws_iam_instance_profile" "nodes-sgallagher-kops-chef-demo-com" {
  name = "nodes.sgallagher-kops.chef-demo.com"
  role = "${aws_iam_role.nodes-sgallagher-kops-chef-demo-com.name}"
}

resource "aws_iam_role" "masters-sgallagher-kops-chef-demo-com" {
  name               = "masters.sgallagher-kops.chef-demo.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.sgallagher-kops.chef-demo.com_policy")}"
}

resource "aws_iam_role" "nodes-sgallagher-kops-chef-demo-com" {
  name               = "nodes.sgallagher-kops.chef-demo.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.sgallagher-kops.chef-demo.com_policy")}"
}

resource "aws_iam_role_policy" "masters-sgallagher-kops-chef-demo-com" {
  name   = "masters.sgallagher-kops.chef-demo.com"
  role   = "${aws_iam_role.masters-sgallagher-kops-chef-demo-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.sgallagher-kops.chef-demo.com_policy")}"
}

resource "aws_iam_role_policy" "nodes-sgallagher-kops-chef-demo-com" {
  name   = "nodes.sgallagher-kops.chef-demo.com"
  role   = "${aws_iam_role.nodes-sgallagher-kops-chef-demo-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.sgallagher-kops.chef-demo.com_policy")}"
}

resource "aws_internet_gateway" "sgallagher-kops-chef-demo-com" {
  vpc_id = "${aws_vpc.sgallagher-kops-chef-demo-com.id}"

  tags = {
    KubernetesCluster                                     = "sgallagher-kops.chef-demo.com"
    Name                                                  = "sgallagher-kops.chef-demo.com"
    "kubernetes.io/cluster/sgallagher-kops.chef-demo.com" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-sgallagher-kops-chef-demo-com-d20ef6c3ed36ca4166f44ad555b64813" {
  key_name   = "kubernetes.sgallagher-kops.chef-demo.com-d2:0e:f6:c3:ed:36:ca:41:66:f4:4a:d5:55:b6:48:13"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.sgallagher-kops.chef-demo.com-d20ef6c3ed36ca4166f44ad555b64813_public_key")}"
}

resource "aws_launch_configuration" "master-us-east-1a-masters-sgallagher-kops-chef-demo-com" {
  name_prefix                 = "master-us-east-1a.masters.sgallagher-kops.chef-demo.com-"
  image_id                    = "ami-077b21be2bc9db012"
  instance_type               = "m3.medium"
  key_name                    = "${aws_key_pair.kubernetes-sgallagher-kops-chef-demo-com-d20ef6c3ed36ca4166f44ad555b64813.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-sgallagher-kops-chef-demo-com.id}"
  security_groups             = ["${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1a.masters.sgallagher-kops.chef-demo.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  ephemeral_block_device = {
    device_name  = "/dev/sdc"
    virtual_name = "ephemeral0"
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-sgallagher-kops-chef-demo-com" {
  name_prefix                 = "nodes.sgallagher-kops.chef-demo.com-"
  image_id                    = "ami-077b21be2bc9db012"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-sgallagher-kops-chef-demo-com-d20ef6c3ed36ca4166f44ad555b64813.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-sgallagher-kops-chef-demo-com.id}"
  security_groups             = ["${aws_security_group.nodes-sgallagher-kops-chef-demo-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.sgallagher-kops.chef-demo.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.sgallagher-kops-chef-demo-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.sgallagher-kops-chef-demo-com.id}"
}

resource "aws_route_table" "sgallagher-kops-chef-demo-com" {
  vpc_id = "${aws_vpc.sgallagher-kops-chef-demo-com.id}"

  tags = {
    KubernetesCluster                                     = "sgallagher-kops.chef-demo.com"
    Name                                                  = "sgallagher-kops.chef-demo.com"
    "kubernetes.io/cluster/sgallagher-kops.chef-demo.com" = "owned"
    "kubernetes.io/kops/role"                             = "public"
  }
}

resource "aws_route_table_association" "us-east-1a-sgallagher-kops-chef-demo-com" {
  subnet_id      = "${aws_subnet.us-east-1a-sgallagher-kops-chef-demo-com.id}"
  route_table_id = "${aws_route_table.sgallagher-kops-chef-demo-com.id}"
}

resource "aws_security_group" "masters-sgallagher-kops-chef-demo-com" {
  name        = "masters.sgallagher-kops.chef-demo.com"
  vpc_id      = "${aws_vpc.sgallagher-kops-chef-demo-com.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                                     = "sgallagher-kops.chef-demo.com"
    Name                                                  = "masters.sgallagher-kops.chef-demo.com"
    "kubernetes.io/cluster/sgallagher-kops.chef-demo.com" = "owned"
  }
}

resource "aws_security_group" "nodes-sgallagher-kops-chef-demo-com" {
  name        = "nodes.sgallagher-kops.chef-demo.com"
  vpc_id      = "${aws_vpc.sgallagher-kops-chef-demo-com.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                                     = "sgallagher-kops.chef-demo.com"
    Name                                                  = "nodes.sgallagher-kops.chef-demo.com"
    "kubernetes.io/cluster/sgallagher-kops.chef-demo.com" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"
  source_security_group_id = "${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-sgallagher-kops-chef-demo-com.id}"
  source_security_group_id = "${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-sgallagher-kops-chef-demo-com.id}"
  source_security_group_id = "${aws_security_group.nodes-sgallagher-kops-chef-demo-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-sgallagher-kops-chef-demo-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"
  source_security_group_id = "${aws_security_group.nodes-sgallagher-kops-chef-demo-com.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"
  source_security_group_id = "${aws_security_group.nodes-sgallagher-kops-chef-demo-com.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"
  source_security_group_id = "${aws_security_group.nodes-sgallagher-kops-chef-demo-com.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"
  source_security_group_id = "${aws_security_group.nodes-sgallagher-kops-chef-demo-com.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-sgallagher-kops-chef-demo-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-sgallagher-kops-chef-demo-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-east-1a-sgallagher-kops-chef-demo-com" {
  vpc_id            = "${aws_vpc.sgallagher-kops-chef-demo-com.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-east-1a"

  tags = {
    KubernetesCluster                                     = "sgallagher-kops.chef-demo.com"
    Name                                                  = "us-east-1a.sgallagher-kops.chef-demo.com"
    SubnetType                                            = "Public"
    "kubernetes.io/cluster/sgallagher-kops.chef-demo.com" = "owned"
    "kubernetes.io/role/elb"                              = "1"
  }
}

resource "aws_vpc" "sgallagher-kops-chef-demo-com" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                                     = "sgallagher-kops.chef-demo.com"
    Name                                                  = "sgallagher-kops.chef-demo.com"
    "kubernetes.io/cluster/sgallagher-kops.chef-demo.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "sgallagher-kops-chef-demo-com" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                                     = "sgallagher-kops.chef-demo.com"
    Name                                                  = "sgallagher-kops.chef-demo.com"
    "kubernetes.io/cluster/sgallagher-kops.chef-demo.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "sgallagher-kops-chef-demo-com" {
  vpc_id          = "${aws_vpc.sgallagher-kops-chef-demo-com.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.sgallagher-kops-chef-demo-com.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
