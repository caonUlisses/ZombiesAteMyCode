Rails.application.config.generators do |gen|
  gen.orm :active_record, primary_key_type: :uuid
end
