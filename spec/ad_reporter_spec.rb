RSpec.describe AdReporter do
  before(:each) do
    @dummy_provider = AdReporter::Providers::Dummy.new
    @output_manager = AdReporter::OutputManager.new
    @output_manager.add AdReporter::Outputs::PrettyStdout.new
    @reporter = AdReporter::Reporter.new(@dummy_provider, @output_manager)
    @reporter.authorize
  end

  it "raise error on missing argument" do
    expect { AdReporter::Reporter.new }.to raise_error(ArgumentError)
    expect { AdReporter::Reporter.new(@dummy_provider) }.to raise_error(ArgumentError)
    expect { AdReporter::Reporter.new(@output_manager) }.to raise_error(ArgumentError)
  end

  it "don't raise error with good arguments" do
    expect { AdReporter::Reporter.new(@dummy_provider, @output_manager) }.not_to raise_error
  end

  it "get campaign list expected response" do
    expected_message = "1 \"Campaign 1\" [ENABLED] AdGroups:11\n2 \"Campaign 2\" [PAUSED] AdGroups:12\n3 \"Campaign 3\" [ENABLED] AdGroups:13\n4 \"Campaign 4\" [ENABLED] AdGroups:14\n\nMean number of AdGroups per Campaign: 12\n\n"
    expect { @reporter.run }.to output(expected_message).to_stdout
  end
end
