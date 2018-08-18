RSpec.describe AdReporter::Providers::Adwords do
  it "dont raise error on initialize" do
    expect { AdReporter::Providers::Adwords.new }.not_to raise_error
  end

  it "dont raise error on authorize" do
    adword = AdReporter::Providers::Adwords.new
    expect { adword.authorize }.not_to raise_error
  end
  it "load version in initializer" do
    adword = AdReporter::Providers::Adwords.new({api_version: "v201802"})
    expect(adword.config[:api_version]).to eq "v201802"
    expect(adword.api_version).to eq :v201802
  end
  it "load default in initializer" do
    adword = AdReporter::Providers::Adwords.new
    expect(adword.api_version).to eq :v201806
  end
  it "dont raise error on process" do
    adword = AdReporter::Providers::Adwords.new
    expect { adword.process }.not_to raise_error
  end
end
