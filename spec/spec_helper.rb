require "webmock/rspec"
require "ad_reporter"
require "simplecov"
require "simplecov-console"
SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start

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

# fake process for adwords
module AdReporter
  module Providers
    class Adwords < AdReporter::Provider
      def process
      end
    end
  end
end

# create a fake Provider get_campaign & get_number_of_ad_groups
module AdReporter
  module Providers
    class Dummy < AdReporter::Provider
      def authorize
      end

      def process
        campaigns = get_campaigns
        all_campaigns = []

        workers = campaigns.length < 10 ? 1 : 10
        Parallel.each(lambda { campaigns.pop || Parallel::Stop }, :in_threads => workers) { |data|
          data[:nb_ad_groups] = get_number_of_ad_groups data[:id]
          all_campaigns << data
        }

        @campaigns = all_campaigns
      end

      def get_campaigns
        @campaigns = []
        @campaigns << {id: 1, name: "Campaign 1", status: "ENABLED"}
        @campaigns << {id: 2, name: "Campaign 2", status: "PAUSED"}
        @campaigns << {id: 3, name: "Campaign 3", status: "ENABLED"}
        @campaigns << {id: 4, name: "Campaign 4", status: "ENABLED"}
      end

      def get_number_of_ad_groups(campaign_id)
        campaign_id + 10
      end
    end
  end
end

# create a fake output for clean test output
module AdReporter
  module Outputs
    class DummyOutput < AdReporter::Outputs::Base
      def format_lines(campaigns); end
      def format_footer(stats); end
      def flush; end
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
