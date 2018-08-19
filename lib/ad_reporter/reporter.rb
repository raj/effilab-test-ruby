
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
      @provider.process
      campaigns = @provider.campaigns
      stats = {}
      stats[:nb_campaigns] = campaigns.count
      stats[:nb_ad_groups] = campaigns.map { |i| i[:nb_ad_groups] }.inject(0, &:+)
      campaigns.sort_by! { |hsh| hsh[:name] }
      process_outputs campaigns, stats
    end

    def process_outputs(campaigns, stats)
      @output_manager.process_data campaigns, stats
    end
  end
end
