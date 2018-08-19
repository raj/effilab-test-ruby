RSpec.describe AdReporter do
  before(:each) do
    @config = {ad_reporter: {provider: "AdReporter::Providers::Dummy", :outputs => ["AdReporter::Outputs::PrettyStdout"]}}
    @reporter = AdReporter::Reporter.new(@config)
  end

  it "don't raise error on authorize" do
    expect { @reporter.authorize }.not_to raise_error
  end

  it "get campaign list expected response" do
    @reporter.authorize
    expected_message = "1 \"Campaign 1\" [ENABLED] AdGroups:11\n2 \"Campaign 2\" [PAUSED] AdGroups:12\n3 \"Campaign 3\" [ENABLED] AdGroups:13\n4 \"Campaign 4\" [ENABLED] AdGroups:14\n\nMean number of AdGroups per Campaign: 12\n\n"
    expect { @reporter.run }.to output(expected_message).to_stdout
  end
end
