#!/bin/bash

# This script precompiles Rails assets for production each time you deploy.

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Setting RAILS_ENV to production..."
export RAILS_ENV=production

# (Optional) Remove old assets. Uncomment if you want to ensure a clean slate.
# echo "Clearing old assets..."
# bundle exec rails assets:clobber

echo "Precompiling assets..."
bundle exec rails assets:precompile

echo "Assets precompiled successfully."
