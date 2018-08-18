RSpec.describe AdReporter do
  before(:each) do
    dummy_provider = AdReporter::Providers::Dummy.new
    @reporter = AdReporter::Reporter.new(dummy_provider)
    @reporter.authorize
  end

  it "get campaign list" do
    expected_message = "1 \"Campaign 1\" [ENABLED] AdGroups:11\n2 \"Campaign 2\" [] AdGroups:12\n3 \"Campaign 3\" [] AdGroups:13\n4 \"Campaign 4\" [] AdGroups:14\n\nMean number of AdGroups per Campaign: 12\n\n"
    expect { @reporter.run }.to output(expected_message).to_stdout
  end
end
