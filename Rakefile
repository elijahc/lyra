#!/usr/bin/env rake

task :shout do
  system %(tree)
end
namespace :dev do
  task :restart do
    system %(docker-compose -f docker-compose.yml restart)
  end

  task :down do
    system %(docker-compose -f docker-compose.yml down)
  end

  task :up do
    system %(docker-compose -f docker-compose.yml up -d)
  end

  task :rebuild do
    system %(docker-compose -f docker-compose.yml up -d --build)
  end

  task :test do
    system %(docker-compose -f docker-compose.yml run users-service python manage.py test)
  end
end
task :default => :shout
