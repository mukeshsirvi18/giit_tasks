resource "aws_instance" "nandu-instance-pub" {
    ami           = "ami-0657605d763ac72a8"
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.nandu-pub-subnet-1.id
    key_name      = "ubuntu_pem"
    security_groups = [aws_security_group.nandu-pubSub-sg.id]
    count = var.instance_count["nandu-instance-pub"]
    associate_public_ip_address = true
    tags = {
        Name = "nandu-web${count.index + 1}"
        Env = "Dev"
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install nginx -y
                echo "<h1>Welcome to Nandu Web Page</h1>" | sudo tee /var/www/html/index.html
                sudo service nginx start
                sudo systemctl enable nginx
                EOF
}

resource "aws_instance" "nandu-instance-pvt" {
    ami           = "ami-0657605d763ac72a8"
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.nandu-pvt-subnet-1.id
    key_name      = "ubuntu_pem"
    security_groups = [aws_security_group.nandu-pvtSub-sg.id]
    count = var.instance_count["nandu-instance-pvt"]
    tags = {
        Name = "nandu-db${count.index + 1}"
        Env = "Dev"
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install mysql-server -y
                sudo systemctl start mysql
                sudo systemctl enable mysql
                EOF
}