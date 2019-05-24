# InSpec test for recipe mongodb::default

# The InSpec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package 'mongodb-org' do
  it { should be_installed }
  it { should be_running }
  it { should be_enabled }
  its('version') { should match /3\./}
end

# This is an example test, replace it with your own test.
describe port(27017) do
  it { should be_listening }

  describe host('mongodb-org') do
  its('ipaddress') { should include '0.0.0.0' }
end
end
