module AdReporter
  module Outputs
    class PrettyStdout < AdReporter::Outputs::Base
      # each campaign line
      def format_lines(campaigns)
        campaigns.each do |campaign|
          @lines << "%{id} \"%{name}\" [%{status}] AdGroups:%{nb_ad_groups}\n" % campaign
        end
        @lines
      end

      # at the end show some stats
      def format_footer(stats = {nb_ad_groups: 0, nb_campaigns: 0})
        @footer_lines << "\n"
        @footer_lines << "Mean number of AdGroups per Campaign: #{stats[:nb_ad_groups] / stats[:nb_campaigns]}\n"
        @footer_lines << "\n"
        @footer_lines
      end

      # main method that puts on STDOUT
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
