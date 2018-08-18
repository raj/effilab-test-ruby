

RSpec.describe AdReporter do
  before(:each) do
    @reporter = AdReporter::Reporter.new(:v201806, "spec/test_config.yml")
    stub_request(:post, "https://accounts.google.com/o/oauth2/token")
      .to_return(:status => 200,
                 :body => '{"access_token":"access_token123",' +
                          '"token_type":"Bearer","expires_in":"3600"}\n',
                 :headers => {})
    @reporter.authorize
  end

  it "get campaign list" do
    expected_message = "1 \"Campaign 1\" [ENABLED] AdGroups:11\n2 \"Campaign 2\" [] AdGroups:12\n3 \"Campaign 3\" [] AdGroups:13\n4 \"Campaign 4\" [] AdGroups:14\n\nMean number of AdGroups per Campaign: 12\n\n"
    expect { @reporter.run }.to output(expected_message).to_stdout
  end
end
