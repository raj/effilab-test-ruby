require "parallel"

module AdReporter
  module Providers
    class Adwords < AdReporter::Provider
      DEFAULT_API_VERSION = :v201806

      # The API client version
      attr_reader :api_version

      def initialize(provided_config = {})
        super(provided_config)
        @api_version = @config[:api_version].nil? ? DEFAULT_API_VERSION : @config[:api_version].to_sym
        @client = AdwordsApi::Api.new(@config[:filename])
      end

      def authorize
        setup_oauth2
      end

      def process
        stats = {nb_ad_groups: 0, nb_keywords: 0, nb_campaigns: 0}
        campaigns = get_campaigns
        all_campaigns = []

        workers = campaigns.length < 10 ? 1 : 10
        Parallel.each(lambda { campaigns.pop || Parallel::Stop }, :in_threads => workers) { |data|
          data[:nb_ad_groups] = get_number_of_ad_groups data[:id]
          all_campaigns << data
        }

        stats[:nb_campaigns] = all_campaigns.count
        stats[:nb_ad_groups] = all_campaigns.map { |i| i[:nb_ad_groups] }.inject(0, &:+)
        all_campaigns.sort_by { |hsh| hsh[:name] }.each do |campaign|
          puts "%{id} \"%{name}\" [%{status}] AdGroups:%{nb_ad_groups}" % campaign
        end
        puts ""
        puts "Mean number of AdGroups per Campaign: #{stats[:nb_ad_groups] / stats[:nb_campaigns]}"
        puts ""
      end

      private

      def default_config_filename
        File.join(ENV["HOME"], AdwordsApi::ApiConfig.default_config_filename)
      end

      def get_campaigns
        campaigns = []
        campaign_srv = @client.service(:CampaignService, @api_version)

        # Get all the campaigns for this account.
        selector = {
          :fields => ["Id", "Name", "Status"],
          :ordering => [
            {:field => "Id", :sort_order => "ASCENDING"},
          ],
          :paging => {
            :start_index => 0,
            :number_results => 500,
          },
        }

        # Set initial values.
        offset, page = 0, {}

        begin
          page = campaign_srv.get(selector)
          if page[:entries]
            page[:entries].each do |campaign|
              campaigns << {id: campaign[:id], name: campaign[:name], status: campaign[:status]}
            end
            # Increment values to request the next page.
            offset += 500
            selector[:paging][:start_index] = offset
          end
        end while page[:total_num_entries] > offset

        campaigns
      end

      def get_number_of_ad_groups(campaign_id)
        nb_ad_groups = 0
        ad_group_srv = @client.service(:AdGroupService, @api_version)

        # Get all the ad groups for this campaign.
        selector = {
          :fields => ["Id"],
          :ordering => [{:field => "Name", :sort_order => "ASCENDING"}],
          :predicates => [
            {:field => "CampaignId", :operator => "IN", :values => [campaign_id]},
          ],
          :paging => {
            :start_index => 0,
            :number_results => 1,
          },
        }

        begin
          page = ad_group_srv.get(selector)
          if page.include?(:total_num_entries)
            nb_ad_groups = page[:total_num_entries]
          end
        end

        nb_ad_groups.to_i
      end

      def setup_oauth2()
        # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
        # when called without parameters.

        # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
        # the configuration file or provide your own logger:
        # adwords.logger = Logger.new('adwords_xml.log')

        # You can call authorize explicitly to obtain the access token. Otherwise, it
        # will be invoked automatically on the first API call.
        # There are two ways to provide verification code, first one is via the block:
        verification_code = nil
        token = @client.authorize() do |auth_url|
          puts "Hit Auth error, please navigate to URL:\n\t%s" % auth_url
          print "log in and type the verification code: "
          verification_code = gets.chomp
          verification_code
        end
        if verification_code && token
          puts "Updating adwords_api.yml with OAuth credentials."
          @client.save_oauth2_token(token)
          puts "OAuth2 token is now saved and will be automatically used by the library."
          puts "Please restart the script now."
          abort
        end

        # Alternatively, you can provide one within the parameters:
        # token = adwords.authorize({:oauth2_verification_code => verification_code})

        # Note, 'token' is a Hash. Its value is not used in this example. If you need
        # to be able to access the API in offline mode, with no user present, you
        # should persist it to be used in subsequent invocations like this:
        # adwords.authorize({:oauth2_token => token})

        # No exception thrown - we are good to make a request.
      end

      def create_config_file(filename)
        FileUtils.cp("lib/ad_reporter/providers/adwords_config_sample.yml", filename)
        puts "#{filename} is set up. Refer to the given documentation to set the following values: oauth2_client_id, oauth2_client_secret, developer_token, client_customer_id."
        puts "And restart the script."
        abort
      end
    end
  end
end
