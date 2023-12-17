resource "aws_s3_bucket" "Trickstar" {
    bucket = "Trickstar-${var.env}"

    tags = {
        Environment = var.env
    }
}
