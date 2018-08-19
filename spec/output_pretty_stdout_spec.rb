RSpec.describe AdReporter::Outputs::PrettyStdout do
  before(:each) do
    @campaigns = [
      {id: 1, name: "campaign 1", status: "status", nb_ad_groups: 3},
      {id: 2, name: "campaign 2", status: "status", nb_ad_groups: 4},
      {id: 3, name: "campaign 3", status: "status", nb_ad_groups: 15},
      {id: 4, name: "campaign 4", status: "status", nb_ad_groups: 20},
      {id: 5, name: "campaign 5", status: "status", nb_ad_groups: 10},
    ]
  end

  # dont need argument to create on PrettyStdout
  it "can create a new PrettyStdout" do
    expect { AdReporter::Outputs::PrettyStdout.new }.not_to raise_error
  end

  # test if no campaigns
  it "format empty campaigns" do
    lines = AdReporter::Outputs::PrettyStdout.new.format_lines([])
    expect(lines.length).to eq 0
  end

  # format lines as requested
  it "format some campaigns" do
    expected_lines = []
    @campaigns.each do |campaign|
      expected_lines << "%{id} \"%{name}\" [%{status}] AdGroups:%{nb_ad_groups}\n" % campaign
    end
    lines = AdReporter::Outputs::PrettyStdout.new.format_lines(@campaigns)
    expect(lines.length).to eq 5
    expect(lines).to eq expected_lines
  end

  # format footer as requested
  it "format footer (stats)" do
    stats = {nb_ad_groups: 1000, nb_campaigns: 5}
    expected_lines = []
    expected_lines << "\n"
    expected_lines << "Mean number of AdGroups per Campaign: 200\n"
    expected_lines << "\n"
    lines = AdReporter::Outputs::PrettyStdout.new.format_footer(stats)
    expect(lines.length).to eq 3
    expect(lines).to eq expected_lines
  end

  it "raise error on missing format_lines" do
    expect { AdReporter::Outputs::PrettyStdout.instance_eval { undef :format_lines } }.to raise_error(NameError)
  end
  it "raise error on missing format_footer" do
    expect { AdReporter::Outputs::PrettyStdout.instance_eval { undef :format_footer } }.to raise_error(NameError)
  end
  it "raise error on missing flush" do
    expect { AdReporter::Outputs::PrettyStdout.instance_eval { undef :flush } }.to raise_error(NameError)
  end
end
