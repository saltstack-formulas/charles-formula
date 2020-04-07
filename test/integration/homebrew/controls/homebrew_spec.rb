# frozen_string_literal: true

title 'insomnia archives profile'

control 'insomnia source archive' do
  impact 1.0
  title 'should be installed'

  describe file('/opt/local/bin/insomnia') do
    it { should exist }
  end
end
