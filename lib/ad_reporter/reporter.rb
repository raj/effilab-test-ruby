
# Main class to use in your ruby script
# initialize with
# provider : a instance class that extends AdReporter::Provider
# output_manager : a instance of AdReporter::OutputManager
module AdReporter
  class Reporter
    attr_reader :provider
    attr_reader :output_manager

    # TODO : validate class of params
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

    # this method will retrieve data from provider
    # and send this data to output_manager
    # TODO : provider must stream campaigns data to this instance reporter class
    # TODO : and 'async' send data to different output
    # TODO : then compute stats when all campaigns data is retrieved
    # TODO : and then send stats data to output_manager
    def process
      @provider.process
      campaigns = @provider.campaigns
      # TODO : separate compute stats in a different class
      stats = {}
      stats[:nb_campaigns] = campaigns.count
      stats[:nb_ad_groups] = campaigns.map { |i| i[:nb_ad_groups] }.inject(0, &:+)
      campaigns.sort_by! { |hsh| hsh[:name] }
      process_outputs campaigns, stats
    end

    # send data to output_manager
    def process_outputs(campaigns, stats)
      @output_manager.process_data campaigns, stats
    end
  end
end
