Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '133428136723435', 'd2692942ebd32e93d1d59b9828643d7b'
end