$:.unshift File.join(File.dirname(__FILE__), '../lib/')

require 'mocha/setup'

RSpec.configure do |config|
  config.mock_framework = :mocha
end
