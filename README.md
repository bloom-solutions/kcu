# Kcu

[![Build Status](https://travis-ci.org/bloom-solutions/kcu.svg?branch=master)](https://travis-ci.org/bloom-solutions/kcu)

Kubectl Utils: convenience scripts for kubectl for an opinionated Kubernetes setup

## Installation

Ensure you have `kubectl` installed, and you can use it to connect to your cluster.

```
gem install kcu
```

## Usage

All actions are documented in the executable. Use `--help`:

```
kcu --help
kcu secret list --help
```

Some examples:

```
kcu secret list production/worker
kcu secret get production/worker sidekiq_concurrency
kcu secret set production/worker sidekiq_concurrency 10
kcu controller restart production/website
```

### Easy Deployment

Some teams prefer not to deploy via CD -- perhaps more planning needs to go through the deployment phase. For this type of workflow, KCU provides a simple way to deploy:

```
kcu deploy master
```

This must be executed in the project which contains the configuration file `kcu.yml`:

```
---
deploys:
  - branch: master
    namespace: production
    template: "gcr.io/bloom-solutions/website:prod-$GIT_COMMIT"
    targets:
      - deployment_name: web
        container: website
      - deployment_name: worker
        container: sidekiq
  - branch: /staging_(\d+)/
    namespace: staging
    template: "gcr.io/bloom-solutions/website:staging-$GIT_COMMIT"
    targets:
      - deployment_name: web
        container: website
      - deployment_name: worker
        container: sidekiq
```

The command above is the short version of `kcu deploy master production`. If you will deploy the master branch to production/web/website and production/worker/sidekiq then you need not specify the target details, since this is already defined in the config file.

When deploying the a specific branch to a different namespace (like deploying the production image to the staging namespace), you may specify the namespace. For example, these commands deploy the `master` branch to the staging/web/website and staging/worker/sidekiq containers:

```
kcu deploy master staging
```

- Variables:
  - `GIT_COMMIT`: the full, latest git commit hash of the *local* git copy in the branch

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bloom-solutions/kcu. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Kcu project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bloom-solutions/kcu/blob/master/CODE_OF_CONDUCT.md).
