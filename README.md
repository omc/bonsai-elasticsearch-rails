# bonsai-elasticsearch-rails gem

This gem offers a shim to connect Ruby on Rails applications with a Bonsai Elasticsearch cluster. It is intended to simplify the process of initializing an Elasticsearch client and pointing the client to a Bonsai cluster. The bonsai-elasticsearch-rails gem automatically sets up the Elasticsearch client correctly so users don't need to worry about configuring it in their code or writing an initializer.

## Details

The gem initializes the Elasticsearch client using an environment variable called `BONSAI_URL`, which contains the URL of the cluster. Bonsai clusters will have a URL that looks like this:

https://user1234:pass5678@cluster-slug-123.aws-region-X.bonsai.io/

On Heroku, this variable is created and populated automatically when Bonsai is added to the application. Heroku users therefore do not need to perform any additional configuration to connect to their cluster after adding the bonsai-elasticsearch-rails gem.

Users who are self-hosting their Rails application will need to make sure this environment variable is present by setting the :

```
$ export BONSAI_URL="https://user1234:pass5678@aws-region-X.bonsai.io/"
```

The cluster URL is available via the Bonsai dashboard. For more information see [docs.bonsai.io](https://docs.bonsai.io).

## Installation

The gem will work with any version of Elasticsearch. Users of Elasticsearch 1.x, 2.x and 5.x will only need to install the bonsai-elasticsearch-rails gem. The gem will pull in the appropriate Elasticsearch libraries as needed automatically. Users on newer versions of Elasticsearch, or using unofficial branches of the elasticsearch-rails gem, will need some additional configuration.

| Branch | Gem Version | Elasticsearch | Notes
|:------:|:-----------:| :-----------: | :-----------------------: |
| master | '0.3.0'     | any, forks    | Needs extra configuration |
| 1.x    | '1.0.0'     | 1.x           |                           |
| 2.x    | '2.0.0'     | 2.x           |                           |
| 5.x    | '5.0.0'     | 5.x           |                           |
| 6.x    | '6.0.0'     | 6.x           | Needs extra configuration |
| 7.x    | '7.0.1'     | main          | Needs extra configuration |

### Elasticsearch 1.x

Add the following to your Gemfile:

```ruby
gem 'bonsai-elasticsearch-rails', '~> 1'
```

This will pull in all the necessary 1.x dependencies automatically, so the elasticsearch-rails and elasticsearch-model gems do not need to specifically referenced.

### Elasticsearch 2.x

Add the following to your Gemfile:

```ruby
gem 'bonsai-elasticsearch-rails', '~> 2'
```

This will pull in all the necessary 2.x dependencies automatically, so the elasticsearch-rails and elasticsearch-model gems do not need to specifically referenced.

### Elasticsearch 5.x

Add the following to your Gemfile:

```ruby
gem 'bonsai-elasticsearch-rails', '~> 5'
```

This will pull in all the necessary 5.x dependencies automatically, so the elasticsearch-rails and elasticsearch-model gems do not need to specifically referenced.

### Elasticsearch 6.x

Add the following to your Gemfile:

```ruby
gem 'bonsai-elasticsearch-rails', '~> 6'
gem 'elasticsearch-model', github: 'elastic/elasticsearch-rails', branch: '6.x'
gem 'elasticsearch-rails', github: 'elastic/elasticsearch-rails', branch: '6.x'
```

The elasticsearch-model and elasticsearch-rails gems do not have a 6.x listing on RubyGems.org, which means they can not be added automatically via Bundler. Instead they need to be obtained from the GitHub repository.


### Elasticsearch 7.x

Add the following to your Gemfile:

```ruby
gem 'bonsai-elasticsearch-rails', '~> 7'
gem 'elasticsearch-model', github: 'elastic/elasticsearch-rails', branch: 'main'
gem 'elasticsearch-rails', github: 'elastic/elasticsearch-rails', branch: 'main'
```

The elasticsearch-model and elasticsearch-rails gems do not have a 6.x listing on RubyGems.org, which means they can not be added automatically via Bundler. Instead they need to be obtained from the GitHub repository.

### Any version of Elasticsearch

The master branch of this gem will support any arbitrary version of Elasticsearch as long as the elasticsearch-rails and elasticsearch-model gems are listed in the Gemfile. This is useful if the application needs a version of the elasticsearch-* gems that are:

* Old, EOL, yanked, or no longer supported
* On an unofficial or development branch
* At the development's bleeding edge
* Forked into a different project

Add the bonsai-elasticsearch-rails gem to your Gemfile with the twiddle-wakka operator, then add the elasticsearch-rails and elasticsearch-model gems in whatever way applies to your specific need:

```ruby
gem 'bonsai-elasticsearch-rails', '~> 0'

# Referencing GitHub repos:
gem 'elasticsearch-model', github: '<GITHUB REPO>', branch: '<BRANCH>'
gem 'elasticsearch-rails', github: '<GITHUB REPO>', branch: '<BRANCH>'

# Referencing local gems
gem 'elasticsearch-rails', path: '/path/to/the/gem/elasticsearch-rails'
gem 'elasticsearch-model', path: '/path/to/the/gem/elasticsearch-model'

# Referencing a specific version on RubyGems.org
gem 'elasticsearch-model', 'x.y.z'
gem 'elasticsearch-rails', 'x.y.z'
```

### Installing with Bundler

When the gem has been added to your Gemfile, run:

```
$ bundle install
```

This will bring in all the necessary dependencies. Now when the Rails application starts up, it will be automatically initialized with an Elasticsearch client configured to use a Bonsai cluster. See the [official documentation](https://github.com/elastic/elasticsearch-rails) for information on how to integrate this client into your Rails application.

## Support

Having trouble with the gem? Find a problem or a bug? Just want to say thanks? Shoot us an [email](mailto:support@bonsai.io)!
