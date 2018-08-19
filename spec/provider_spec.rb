# Dummy Provider is defined in spec_helper.rb
RSpec.describe AdReporter::Provider do
  before(:each) do
    @dummy_provider = AdReporter::Providers::Dummy.new
  end

  it "get campaign count" do
    expect(@dummy_provider.get_campaigns.count).to eq 4
  end

  it "dont raise error on process" do
    expect { @dummy_provider.process }.not_to raise_error
  end

  it "dont raise error on authorize" do
    expect { @dummy_provider.authorize }.not_to raise_error
  end

  it "raise error on missing authorize" do
    expect { AdReporter::Providers::Dummy.instance_eval { undef :authorize } }.to raise_error(NameError)
  end
  it "raise error on missing process" do
    expect { AdReporter::Providers::Dummy.instance_eval { undef :process } }.to raise_error(NameError)
  end

  it "raise error on missing get_campaigns" do
    expect { AdReporter::Providers::Dummy.instance_eval { undef :get_campaigns } }.to raise_error(NameError)
  end
end
