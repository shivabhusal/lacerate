RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.before(:each) do
    Sidekiq::Worker.clear_all
  end
end
