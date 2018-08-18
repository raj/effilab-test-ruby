require "adwords_api"

module AdReporter
  class Reporter
    attr_reader :provider

    def initialize(provider)
      @provider = provider
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
    end
  end
end
