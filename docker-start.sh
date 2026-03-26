#!/bin/bash

# Update rubygems so it can install newer bundler versions
gem update --system --no-document

# Install the bundler version specified in Gemfile.lock
BUNDLED_WITH=$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -1 | tr -d ' ')
gem install bundler:"$BUNDLED_WITH" --no-document

# Install dependencies
bundle install

# Start Jekyll with both config files
exec bundle exec jekyll serve \
  --watch \
  --force_polling \
  --livereload \
  --host 0.0.0.0 \
  --port 4000 \
  --config _config.yml,_config_dev.yml
