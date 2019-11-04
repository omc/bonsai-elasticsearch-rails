# frozen_string_literal: true

module Bonsai
  module Elasticsearch
    module Rails
      # Use Railties
      class Railtie < ::Rails::Railtie
        initializer 'setup_elasticsearch' do
          require 'elasticsearch/model'
          require 'elasticsearch/rails'

          # Print a debug message to STDOUT. Muted when in a test environment.
          def log(message)
            @@logger.debug(message) unless ::Rails.env.test?
          end

          @@logger = Logger.new(STDOUT)
          url = ENV['BONSAI_URL'] || ENV['ELASTICSEARCH_URL']

          begin
            if url && URI.parse(url)
              filtered_url = url.sub(/:[^:@]+@/, ':FILTERED@')
              log("Bonsai: Initializing default Elasticsearch client with #{filtered_url}")
              ::Elasticsearch::Model.client = ::Elasticsearch::Client.new(url: url)
            elsif ::Rails.env.production?
              log('BONSAI_URL not present, proceeding with Elasticsearch defaults.')
            end
          rescue URI::InvalidURIError => e
            log("Elasticsearch cluster URL is invalid: #{e.message}")
          end
        end
      end
    end
  end
end
