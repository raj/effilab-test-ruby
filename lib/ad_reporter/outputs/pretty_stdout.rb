module AdReporter
  module Outputs
    class PrettyStdout
      attr_writer :parent

      def initialize
        @lines = []
        @io = $stdout
      end

      def format(campaigns)
        stats = {nb_ad_groups: 0, nb_keywords: 0, nb_campaigns: 0}
        stats[:nb_campaigns] = campaigns.count
        stats[:nb_ad_groups] = campaigns.map { |i| i[:nb_ad_groups] }.inject(0, &:+)
        campaigns.each do |campaign|
          @lines << "%{id} \"%{name}\" [%{status}] AdGroups:%{nb_ad_groups}\n" % campaign
        end
        @lines << "\n"
        @lines << "Mean number of AdGroups per Campaign: #{stats[:nb_ad_groups] / stats[:nb_campaigns]}\n"
        @lines << "\n"
      end

      def flush
        @lines.each do |line|
          puts line
        end
        @lines = []
      end
    end
  end
end
