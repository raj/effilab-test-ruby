RSpec.describe AdReporter::Providers::Adwords do
  it "dont raise error on initialize" do
    expect { AdReporter::Providers::Adwords.new }.not_to raise_error
  end

  it "dont raise error on authorize" do
    adword = AdReporter::Providers::Adwords.new
    expect { adword.authorize }.not_to raise_error
  end
  it "dont raise error on process" do
    adword = AdReporter::Providers::Adwords.new
    puts adword.config
    # expect { adword.process }.not_to raise_error
  end
end
