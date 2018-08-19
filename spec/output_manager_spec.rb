RSpec.describe AdReporter::OutputManager do
  it "dont raise error on initialize" do
    expect { AdReporter::OutputManager.new }.not_to raise_error
  end

  it "dont have any output by default" do
    manager = AdReporter::OutputManager.new
    expect(manager.outputs.count).to eq 0
  end

  it "can add output" do
    manager = AdReporter::OutputManager.new
    manager.add AdReporter::Outputs::PrettyStdout.new
    expect(manager.outputs.count).to eq 1
  end

  it "can remove output" do
    manager = AdReporter::OutputManager.new
    output = AdReporter::Outputs::PrettyStdout.new
    manager.add output
    expect(manager.outputs.count).to eq 1
    manager.remove(output)
    expect(manager.outputs.count).to eq 0
  end

  it "dont raise error on process data" do
    expect { AdReporter::OutputManager.new.process_data }.not_to raise_error
  end
end
