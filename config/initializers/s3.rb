# config/initializers/s3.rb
require 'aws-sdk-s3'

Aws.config.update(
  {
    region: Rails.application.credentials.dig(:aws, :region).presence || ENV["BUCKETEER_AWS_REGION"],
    credentials: Aws::Credentials.new(
      Rails.application.credentials.dig(:aws, :access_key_id).presence || ENV["BUCKETEER_AWS_ACCESS_KEY_ID"],
      Rails.application.credentials.dig(:aws, :secret_access_key).presence || ENV["BUCKETEER_AWS_SECRET_ACCESS_KEY"]
    )
  }
)

S3_BUCKET = Aws::S3::Resource.new.bucket(Rails.application.credentials.dig(:aws, :bucket_name).presence || ENV["BUCKETEER_BUCKET_NAME"])

S3_CLIENT = Aws::S3::Client.new(region: Rails.application.credentials.dig(:aws, :region).presence || ENV["BUCKETEER_AWS_REGION"])
