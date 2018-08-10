if defined?(Rails)
  require File.expand_path('bonsai/elasticsearch/rails/railtie',
                           File.dirname(__FILE__))
end
