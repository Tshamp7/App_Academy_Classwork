RSpec.configure do |config|
  config.color = true
  config.before(:each) do
    allow($stdout).to receive(:write)
  end
end
