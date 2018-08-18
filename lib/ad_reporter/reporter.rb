
module AdReporter
  class Reporter
    attr_reader :provider
    attr_reader :output_manager

    def initialize(provider, output_manager)
      @provider = provider
      @output_manager = output_manager
    end

    def authorize
      @provider.authorize
    end

    def run
      process
    end

    private

    def process
      campaigns = @provider.process
      campaigns.sort_by! { |hsh| hsh[:name] }
      process_outputs campaigns
    end

    def process_outputs(campaigns)
      @output_manager.process_data campaigns
    end
  end
end
