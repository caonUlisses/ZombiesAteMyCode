Apipie.configure do |config|
  config.app_name                = "ZombiesAteMyCode"
  config.api_base_url            = "/"
  config.doc_base_url            = "/docs"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.translate = false
end
