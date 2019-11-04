# frozen_string_literal: true

require 'rails'
require_relative '../lib/bonsai/elasticsearch/rails/railtie'

describe Bonsai::Elasticsearch::Rails::Railtie do
  let(:initializer) do
   described_class.initializers.select{|i| i.name == 'setup_elasticsearch' }.first
  end

  let(:bonsai_url) { "https://user123:pass456@some-cluster.bonsai.io:443" }

  let(:cluster_url) { "http://127.0.0.1" }

  let(:client_url) { ::Elasticsearch::Model.client.transport.options[:url] }

  let(:simulate_rails_startup) { initializer.block.call }

  before do
    ENV['RAILS_ENV'] = 'test'
  end

  it 'has the right initializer' do
    expect(initializer).not_to be_nil
  end

  describe 'URL assignment' do
    before do
      ENV['BONSAI_URL'] = nil
    end

    context 'when no environment variable exists' do
      it 'defaults to whatever Elasticsearch-rails wants' do
        simulate_rails_startup
        expect(client_url).to be_nil
      end
    end

    context 'when BONSAI_URL exists' do
      it 'sets the client to the Bonsai URL' do
        ENV['BONSAI_URL'] = bonsai_url
        simulate_rails_startup
        expect(client_url).to eql(bonsai_url)
      end
    end

    context 'when ELASTICSEARCH_URL exists' do
      it 'sets the client to the cluster url' do
        ENV['ELASTICSEARCH_URL'] = cluster_url
        simulate_rails_startup
        expect(client_url).to eql(cluster_url)
      end
    end

    context 'when both BONSAI_URL and ELASTICSEARCH_URL exist' do
      it 'prefers the BONSAI_URL' do
        ENV['BONSAI_URL'] = bonsai_url
        ENV['ELASTICSEARCH_URL'] = cluster_url
        simulate_rails_startup
        expect(client_url).to eql(bonsai_url)
      end
    end
  end
end
