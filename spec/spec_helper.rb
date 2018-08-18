require "webmock/rspec"
require "ad_reporter"
include WebMock::API
WebMock.disable_net_connect!(allow_localhost: true)

# mock google adwords authorize
module AdsCommon
  class Api
    def authorize(parameters = {}, &block)
      token = "123"
      return token
    end
  end
end

# mock AdReporter get_campain & get_number_of_ad_groups
module AdReporter
  class Reporter
    def get_campaigns
      campaigns = []
      campaigns << {id: 1, name: "Campaign 1", status: "ENABLED"}
      campaigns << {id: 2, name: "Campaign 2", status: ""}
      campaigns << {id: 3, name: "Campaign 3", status: ""}
      campaigns << {id: 4, name: "Campaign 4", status: ""}
    end

    def get_number_of_ad_groups(campaign_id)
      [campaign_id + 10, []]
    end
  end
end

RSpec.configure do |config|

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
