data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zone" "available" {
}

resource "aws_subnet" "this" {
  count      = 2
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.${128 + count.index}.0/24"
  availability_zone = data.availability_zone.available.names[
    count.index % length(data.aws_availability_zone.available.names)
  ] # "ap-southeast-1a"

  lifecycle {
    postcondition {
      condition     = contains(data.availability_zone.available.names, self.availability_zone)
      error_message = "Invalid AZ"
    }
  }
}