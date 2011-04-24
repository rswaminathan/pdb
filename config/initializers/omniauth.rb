if Rails.env.development?
  
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '102495643164607', '7c516669e1838249a98c999b8940e74c', :scope => 'email,offline_access'
  end

else
  
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '133428136723435', 'd2692942ebd32e93d1d59b9828643d7b', :scope => 'email,offline_access'
    
  end
  
end
