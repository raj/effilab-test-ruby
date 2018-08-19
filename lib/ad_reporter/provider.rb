module AdReporter
  class Provider
    # This config for generic provider
    attr_reader :config
    # The API client for provider
    attr_reader :client

    attr_reader :campaigns

    def initialize(provided_config = {})
      @campaigns = []
      load_or_create_config_filename(provided_config) if provided_config.class == String
      load_config_hash(provided_config) if provided_config.class == Hash
    end

    def process
      get_campaigns
    end

    private

    def default_config_filename
      nil
    end

    def get_campaigns
      raise "this method should be overriden and return the campaign list"
    end

    def authorize
      raise "this method should be overriden"
    end

    # TODO : separate in a different ConfigProvider class
    def load_config_hash(provided_config)
      @config = provided_config
      if @config[:filename].nil? && !default_config_filename.nil?
        @config[:filename] = default_config_filename
        create_config_file(@config[:filename]) unless File.file?(@config[:filename])
      end
    end

    def load_or_create_config_filename(provided_config)
      @config = {filename: provided_config}
      create_config_file(@config[:filename]) unless File.file?(@config[:filename])
    end
  end
end
