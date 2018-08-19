RSpec.describe AdReporter::Reporter do
  before(:each) do
    @config = {ad_reporter: {provider: "AdReporter::Providers::Dummy", :outputs => ["AdReporter::Outputs::DummyOutput"]}}
  end

  it "don't raise error with good params" do
    expect { AdReporter::Reporter.new(@config) }.not_to raise_error
  end

  it "don't raise error on authorize" do
    reporter = AdReporter::Reporter.new(@config)
    expect { reporter.authorize }.not_to raise_error
  end

  it "raise error if run without config" do
    reporter = AdReporter::Reporter.new(@config)
    expect { reporter.run }.not_to raise_error
  end
end
