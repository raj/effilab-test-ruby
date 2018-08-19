RSpec.describe AdReporter::Outputs::Base do
  it "raise error on missing format_lines" do
    expect { AdReporter::Outputs::DummyOutput.instance_eval { undef :format_lines } }.to raise_error(NameError)
  end
  it "raise error on missing format_footer" do
    expect { AdReporter::Outputs::DummyOutput.instance_eval { undef :format_footer } }.to raise_error(NameError)
  end
  it "raise error on missing flush" do
    expect { AdReporter::Outputs::DummyOutput.instance_eval { undef :flush } }.to raise_error(NameError)
  end
end
