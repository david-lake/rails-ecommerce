CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider                         => 'Google',
    :google_storage_access_key_id     => ENV['GS_ACCESS_KEY'],
    :google_storage_secret_access_key => ENV['GS_SECRET_KEY']
  }
  config.fog_directory = ENV['GS_BUCKET']
end
