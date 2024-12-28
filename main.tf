data "aws_availability_zones" "available" {
  state = "available"
}

variable "name" {
    description = "choonyee"
    type = string
    # default = "somename"
}

resource "aws_ebs_volume" "selected" {
  availability_zone = "ap-southeast-1" # Modify with the AZ your instance is in
  size              = 1              # Size in GB
}

resource "aws_instance" "public" {
  ami                         = "ami-04c913012f8977029"
  instance_type               = "t2.micro"
  availability_zone           = "ap-southeast-1"
  # subnet_id                   = data.aws_subnets.public.ids[0] #Public Subnet ID, e.g. subnet-xxxxxxxxxxx.
 
  tags = {
    Name = "${var.name}-ec2"
  }
}

resource "aws_volume_attachment" "public" {
  device_name = "/dev/sdh"  # You can change this to the appropriate device name (e.g., /dev/sdf)
  volume_id   = aws_ebs_volume.selected.id
  instance_id = aws_instance.public.id
}
