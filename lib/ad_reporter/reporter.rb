
# Main class to use in your ruby script
# initialize with
# provider : a instance class that extends AdReporter::Provider
# output_manager : a instance of AdReporter::OutputManager
module AdReporter
  class Reporter
    attr_reader :provider
    attr_reader :output_manager
    attr_reader :config

    # TODO : validate class of params
    def initialize(config = nil)
      load_or_create_config(config)
      load_assets()
    end

    def authorize
      @provider.authorize
    end

    def run
      process
    end

    private

    def load_or_create_config(config = nil)
      filename = default_config_filename if config.nil?
      filename = config if config.class == String
      @config = config if config.class == Hash
      if filename
        create_default_config_file(filename) unless File.file?(filename)
        @config = YAML.load(File.read(filename))
      end
    end

    def load_assets
      @provider = Kernel.const_get(@config[:ad_reporter][:provider]).new
      @output_manager = AdReporter::OutputManager.new
      @config[:ad_reporter][:outputs].each do |output|
        @output_manager.add Kernel.const_get(output).new
      end
    end

    def default_config_filename
      File.join(ENV["HOME"], "ad_reporter.yml")
    end

    def create_default_config_file(filename)
      FileUtils.cp("ad_reporter.yml.sample", filename)
    end

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
