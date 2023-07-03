output "security_group_public" {
   value = "${aws_security_group.worker_node_sg.id}"
}