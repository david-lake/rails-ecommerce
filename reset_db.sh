#!/bin/bash

echo "Reseting migrations"
rails db:migrate:reset
echo "Running migrations"
rails db:migrate
echo "Seeding database"
rails db:seed
echo "Reset complete"
