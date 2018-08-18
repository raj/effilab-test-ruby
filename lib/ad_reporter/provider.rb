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
      @config = provided_config
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
  end
end
