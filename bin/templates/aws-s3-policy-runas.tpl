{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "AWS": [
                "${run-user-arn}"
            ]
        },
        "Action": "s3:*",
        "Resource": [
            "arn:aws:s3:::${s3-bucket-name}",
            "arn:aws:s3:::${s3-bucket-name}/*"
        ]
    }
    ]
}