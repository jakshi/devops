+++
date = "2019-10-21T21:48:00+07:00"
description = ""
draft = true
markup = "md"
title = "Testing IT Infrastructure code with test-kitchen - saltstack"
categories = ["technical", "tests", "salt", "test-kitchen", "devops", "saltstack", "salt"]
postsummary = """
This is an article to collect my current thoughts on testing saltstack code with test-ktichen.
"""
+++

<!-- more -->
This is an article to collect my current thoughts on testing saltstack code with test-ktichen.

# Intro
## Test-Kitchen
So what does Test-kitchen do?

In short, it:

* Creates VMs
* Runs IT Infrastructure code inside them
* Runs test for that IT Infrastructure code inside those VMs
* And destroys the VMs

Test-kitchen has a plug-in system:

* So you can test different types of IT infrastructure code - salt, chef, ansible, terraform etc.
* You can use different types of VMs (AWS, GCP, VirtualBox etc.)
* You can use a lot of IT infrastructure test frameworks or just shell :)
  * testinfra
  * busser
  * InSpec
  * Serverspec

By using specific plugins.

## Test-Kitchen-Salt
Provide support for testing saltstack formulas and states.

# Prerequisites

* Ruby
* Saltstack
* test-kitchen
* test-kitchen-salt
* AWS setup (for creating VMs)
  * Alternatively you can use VM that you like - VirtualBox, Docker, GCP etc.

# Installing
## Getting test-kitchen
Create `Gemfile` in the root of your salt repo (or in root of your formula repo).

```
source 'https://rubygems.org'

group 'integration' do
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-ec2'
  gem 'kitchen-salt'
  gem 'kitchen-sync' # faster copy
  gem 'git'
end
```

then install gems with:

```
bundle install --path vendor/bundle
```

Check that test-kitchen is here:

```
bundle exec kitchen --version
```

# How to use
Following commands are here to test your IT infrastructure code:

```
bundle exec kitchen list
bundle exec kitchen create
bundle exec kitchen converge
bundle exec kitchen verify
bundle exec kitchen destroy
```

Or all that together in one commmand:

```
bundle exec kitchen test
```

# Writing tests
## Intro
Following test platform are supported

* shell :)
* testinfra
* busser
* InSpec
* Serverspec

## Serverspec
Next time I'll give examples with Serverspec

## Pitfalls with writing tests
Next time I'll talk about pitfalls for tests

# Final words

* Happy testing

# References
## Test-kitchen

* [Test-Kiichen](https://github.com/test-kitchen/test-kitchen)
* [Test-Kitchen-EC2](https://github.com/test-kitchen/kitchen-ec2)
* [Test-Kitchen-Salt](https://github.com/saltstack/kitchen-salt)
