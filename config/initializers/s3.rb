CarrierWave.configure do |config|
  if Rails.env.development?
    config.storage = :file
  else
    config.fog_credentials = {
        provider: "AWS",
        aws_access_key_id: "AKIAILMRWYG42X7BOOMA",
        aws_secret_access_key: "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",
        region: "ap-northeast-1"
    }
    config.storage = "fog"
    config.fog_directory  = "ecommerce23"
  end
end
