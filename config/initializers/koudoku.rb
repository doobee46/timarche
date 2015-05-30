Koudoku.setup do |config|
  config.webhooks_api_key = "5311066b-f533-41c7-9e8c-7ed0008036dc"
  config.subscriptions_owned_by = :user
  config.stripe_publishable_key = "pk_test_KUF2r9XIREodw5fJeieAA4YG" #ENV['stripe_publishable_key']
  config.stripe_secret_key ="sk_test_nL2E4bWrSDd0s9tEUH5SrHah" #ENV['stripe_secret_key']
  Stripe.api_version = '2015-01-11'
  #config.free_trial_length = 30
end
