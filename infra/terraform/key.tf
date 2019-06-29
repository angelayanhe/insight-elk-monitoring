/*

key.tf

This file defines the path to the public key.

*/

resource "aws_key_pair" "mykeypair" {
  key_name = "id_rsa"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
  lifecycle {
    ignore_changes = ["public_key"]
  }
}
