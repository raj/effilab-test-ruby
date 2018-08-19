$LOAD_PATH << File.dirname(__FILE__)
$LOAD_PATH << File.join(File.dirname(__FILE__), "lib")
require "lib/ad_reporter"

DEFAULT_OUTPUT = AdReporter::Outputs::PrettyStdout.new

adwords_provider = AdReporter::Providers::Adwords.new
output_manager = AdReporter::OutputManager.new
output_manager.add DEFAULT_OUTPUT

reporter = AdReporter::Reporter.new
reporter.authorize
reporter.run
