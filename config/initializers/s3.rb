# config/initializers/s3.rb
require 'aws-sdk-s3'

Aws.config.update(
  {
    region: "us-east-1",
    credentials: Aws::Credentials.new(
      Rails.application.credentials.dig(:aws, :access_key_id),
      Rails.application.credentials.dig(:aws, :secret_access_key)
    )
  }
)

S3_BUCKET = Aws::S3::Resource.new.bucket("cloud-cube-us2")

S3_CLIENT = Aws::S3::Client.new(region: "us-east-1")
