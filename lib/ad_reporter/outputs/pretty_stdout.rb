module AdReporter
  module Outputs
    class PrettyStdout
      attr_writer :parent

      def initialize
        @lines = []
        @footer_lines = []
      end

      def format(campaigns)
        campaigns.each do |campaign|
          @lines << "%{id} \"%{name}\" [%{status}] AdGroups:%{nb_ad_groups}\n" % campaign
        end
      end

      def format_footer(stats = {nb_ad_groups: 0, nb_campaigns: 0})
        @footer_lines << "\n"
        @footer_lines << "Mean number of AdGroups per Campaign: #{stats[:nb_ad_groups] / stats[:nb_campaigns]}\n"
        @footer_lines << "\n"
      end

      def flush
        @lines.each do |line|
          puts line
        end
        @footer_lines.each do |line|
          puts line
        end
        @lines = []
        @footer_lines = []
      end
    end
  end
end
