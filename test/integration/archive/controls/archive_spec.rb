# frozen_string_literal: true

title 'charles-proxy archives profile'

control 'charles-proxy binary archive' do
  impact 1.0
  title 'should be installed'

  describe file('/usr/local/charles-proxy-4.5.6/bin/charles') do
    it { should exist }
  end
end
