# bonsai-elasticsearch-rails gem

This gem offers a shim to connect Rails apps with a Bonsai Elasticsearch cluster. The official Elasticsearch gem package requires some minor configuration tweaks in order to work correctly with Bonsai (namely the client needs to be instantiated with the cluster location and HTTP authentication details), and the process can be somewhat complicated for users who are unfamiliar with the system.

The bonsai-elasticsearch-rails gem automatically sets up the Elasticsearch client correctly so users don't need to worry about configuring it in their code or writing an initializer.

## Notes

This gem is tracking the elasticsearch-rails 7.x branch, which is designed to support Elasticsearch 7.x. If you have another version of Elasticsearch, please use a different branch of this project.

If you see an error like this:

```
Bundler could not find compatible versions for gem "elasticsearch-model":
  In Gemfile:
    bonsai-elasticsearch-rails was resolved to 7.0.0, which depends on
      elasticsearch-model (~> 7)

Could not find gem 'elasticsearch-model (~> 7)', which is required by gem 'bonsai-elasticsearch-rails', in any of the sources.
```

It means that RubyGems does not have a listing for the elasticsearch-rails 7.x gem. You will need to add this to your project's Gemfile:

```
gem 'elasticsearch-rails', github: 'elastic/elasticsearch-rails', branch: 'master'
gem 'elasticsearch-model', github: 'elastic/elasticsearch-rails', branch: 'master'
```

## Installation

Add this line to your application's Gemfile:

```
gem 'bonsai-elasticsearch-rails'
```

And then run:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install bonsai-elasticsearch-rails
```

You will now have access to the Elasticsearch ruby client via:

```ruby
Elasticsearch::Model.client
```

## Details

In order for the gem to work correctly, the application needs an environment variable called `BONSAI_URL`, which is populated with the complete Bonsai Elaticsearch cluster URL, including the HTTP authentication. The cluster URL will follow this pattern:

https://user1234:pass5678@cluster-slug-123.aws-region-X.bonsai.io/

On Heroku, this variable is created and populated automatically when Bonsai is added to the application. Heroku users therefore do not need to perform any additional configuration to connect to their cluster after adding the bonsai-elasticsearch-rails gem.

Users who are self-hosting their Rails app will need to make sure this environment variable is present:

```
$ export BONSAI_URL="https://user1234:pass5678@aws-region-X.bonsai.io/"
```

The cluster URL is available via the Bonsai dashboard.

## Support

Having trouble with the gem? Find a problem or a bug? Just want to say thanks? Shoot us an [email](mailto:support@bonsai.io)!
