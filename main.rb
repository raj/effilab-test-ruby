$LOAD_PATH << File.dirname(__FILE__)
$LOAD_PATH << File.join(File.dirname(__FILE__), "lib")
require "lib/ad_reporter"

adwords_provider = AdReporter::Providers::Adwords.new
reporter = AdReporter::Reporter.new(adwords_provider)
reporter.authorize
reporter.run
