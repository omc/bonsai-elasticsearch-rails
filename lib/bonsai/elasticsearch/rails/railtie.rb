module Bonsai
  module Elasticsearch
    module Rails
      # Use Railties
      class Railtie < ::Rails::Railtie
        config.after_initialize do
          require 'elasticsearch/model'
          require 'elasticsearch/rails'

          logger = ::Rails.logger
          url = ENV['BONSAI_URL'] || ENV['ELASTICSEARCH_URL']

          begin
            if url && URI.parse(url)
              filtered_url = url.sub(/:[^:@]+@/, ':FILTERED@')
              logger.debug('Bonsai: Initializing default Elasticsearch client'\
                           " with #{filtered_url}")
              ::Elasticsearch::Model.client = ::Elasticsearch::Client.new(
                url: url
              )
            elsif ::Rails.env.production?
              logger.debug('BONSAI_URL not present, proceeding with'\
                           'Elasticsearch defaults.')
            end
          rescue URI::InvalidURIError => e
            logger.error("Elasticsearch cluster URL is invalid: #{e.message}")
          end
        end
      end
    end
  end
end
