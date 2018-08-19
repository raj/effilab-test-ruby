RSpec.describe AdReporter::Reporter do
  before(:each) do
    @dummy_provider = AdReporter::Providers::Dummy.new
    @output_manager = AdReporter::OutputManager.new
    @output_manager.add AdReporter::Outputs::DummyOutput.new
  end

  it "raise error without good param" do
    expect { AdReporter::Reporter.new }.to raise_error(ArgumentError)
    expect { AdReporter::Reporter.new(@dummy_provider) }.to raise_error(ArgumentError)
    expect { AdReporter::Reporter.new(@output_manager) }.to raise_error(ArgumentError)
  end

  it "don't raise error with good params" do
    expect { AdReporter::Reporter.new(@dummy_provider, @output_manager) }.not_to raise_error
  end

  it "don't raise error on authorize" do
    reporter = AdReporter::Reporter.new(@dummy_provider, @output_manager)
    expect { reporter.authorize }.not_to raise_error
  end

  it "don't raise error on run" do
    reporter = AdReporter::Reporter.new(@dummy_provider, @output_manager)
    expect { reporter.run }.not_to raise_error
  end
end
