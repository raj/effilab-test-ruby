module AdReporter
  module Outputs
    class Base
      attr_writer :parent

      def format_lines(campaigns = [])
        raise "this method should be overriden"
      end

      def format_footer(stats = {nb_ad_groups: 0, nb_campaigns: 0})
        raise "this method should be overriden"
      end

      def initialize
        @lines = []
        @footer_lines = []
      end
    end
  end
end
