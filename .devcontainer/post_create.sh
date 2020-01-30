#!/bin/bash

gem install rubocop

#TODO: Figure out how to automate versioning
gem build brillo.gemspec -o pkg/brillo-2.1.0.gem
gem install --dev pkg/brillo-2.1.0.gem