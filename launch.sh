#!/bin/bash

# Build and launch app
docker run --rm -v "$(pwd)":/opt -w /opt composer:latest bash -c "composer install --ignore-platform-reqs --no-scripts" && # Install dependencies
cp .env.example .env && # Copy .env.example to .env
./vendor/bin/sail up -d && # Launch containers
./vendor/bin/sail php ./vendor/bin/rr get-binary && # Get RoadRunner binary
chmod +x ./rr && # Make RoadRunner binary executable
./vendor/bin/sail artisan key:generate && # Generate app key
./vendor/bin/sail artisan migrate:fresh --seed && # Migrate and seed database
./vendor/bin/sail npm install && # Install npm dependencies
./vendor/bin/sail npm run build && # Build assets
echo "App launched at http://localhost/admin" # Display app url
