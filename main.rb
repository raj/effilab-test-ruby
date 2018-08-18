$LOAD_PATH << File.dirname(__FILE__)
$LOAD_PATH << File.join(File.dirname(__FILE__), "lib")
require "lib/ad_reporter"
reporter = AdReporter::Reporter.new(:v201806, "/root/adwords_api.yml.2")
reporter.authorize
reporter.run
