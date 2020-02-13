resource "aws_security_group" "allow_connections_docker" {
  name        = "allow_connections_docker"
  description = "Allow TLS inbound traffic for ssh but only for the host PCs external IP or an IP of the whitelist."

  ingress {
    /* SSH incoming */
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = concat(formatlist("%s/32", list(chomp(data.http.external_ip.body))), var.ip_whitelist)
  }
  ingress {
    /* Docker https incoming */
    from_port   = 2376
    to_port     = 2376
    protocol    = "tcp"
    cidr_blocks = concat(formatlist("%s/32", list(chomp(data.http.external_ip.body))), var.ip_whitelist)
  }
  ingress {
    /* Docker http incoming */
    from_port   = 2375
    to_port     = 2375
    protocol    = "tcp"
    cidr_blocks = concat(formatlist("%s/32", list(chomp(data.http.external_ip.body))), var.ip_whitelist)
  }
  tags = {
    Name = "allow_connections_docker"
  }
  egress {
    /* HTTP outgoing */
    from_port   = 80
    to_port     = 80
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    /* HTTPS outgoing */
    from_port   = 443
    to_port     = 443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
