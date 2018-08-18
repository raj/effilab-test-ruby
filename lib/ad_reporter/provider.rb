module AdReporter
  class Provider
    # Methods that return the client library configuration. Needs to be
    # redefined in subclasses.
    attr_reader :config
    # The logger for this Provider object.
    attr_reader :logger
    # The API client for provider
    attr_reader :client

    def initialize(provided_config = {})
      load_or_create_config_filename(provided_config) if provided_config.class == String
      load_config_hash(provided_config) if provided_config.class == Hash
    end

    def get_campaigns
      raise "this method should be overriden and return the campaign list"
    end

    def authorize
      raise "this method should be overriden"
    end

    def process
      raise "this method should be overriden"
    end

    def default_config_filename
      nil
    end

    private

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
