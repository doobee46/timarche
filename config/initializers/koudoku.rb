Koudoku.setup do |config|
  config.webhooks_api_key = "5311066b-f533-41c7-9e8c-7ed0008036dc"
  config.subscriptions_owned_by = :user
  config.stripe_publishable_key = "pk_test_KUF2r9XIREodw5fJeieAA4YG"#ENV['STRIPE_PUBLISHABLE_KEY']
  config.stripe_secret_key ="sk_test_nL2E4bWrSDd0s9tEUH5SrHah"#ENV['STRIPE_SECRET_KEY']
  config.free_trial_length = 30
end
