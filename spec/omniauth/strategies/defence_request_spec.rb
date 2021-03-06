ENV['AUTHENTICATION_SITE_URL'] = 'https://example.com/site_url'
ENV['AUTHENTICATION_REDIRECT_URI'] = 'https://example.com/redirect_url'

require 'spec_helper'
require 'omniauth-dsds'

describe "defence_request strategy" do
  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }

  before :each do
  end

  describe 'client options' do
    subject do
      args = ['appid', 'secret', @options || {}].compact
      OmniAuth::Strategies::DefenceRequest.new(*args).tap do |strategy|
        allow(strategy).to receive(:request) {
          request
        }
      end
    end

    it 'should have correct name' do
      expect(subject.options.name).to eq('defence_request')
    end

    it 'should have correct site pulled from the environment' do
      expect(subject.options.client_options.site).to eq('https://example.com/site_url')
    end

    it 'should have correct redirect url pulled from the environment' do
      expect(subject.options.client_options.redirect_url).to eq('https://example.com/redirect_url')
    end
  end
end
