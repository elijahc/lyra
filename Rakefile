docker_env = ENV['DOCKER_MACHINE_NAME']
raise 'No active docker-machine!' unless docker_env

compose_files = {
  'lyra-dev'=>'docker-compose-dev.yml',
  'lyra-prod'=>'docker-compose-prod.yml'
}
COMPOSE = compose_files[docker_env]

load './services/users/users-service-tasks.rake'

desc 'bring services up'
task :up do
  system %(docker-compose -f #{COMPOSE} up -d)
end

desc 'build services'
task :build do
  system %(docker-compose -f #{COMPOSE} up -d --build)
  Rake::Task['db:recreate'].execute
  Rake::Task['db:seed'].execute
  Rake::Task['test'].execute
end
task :rebuild => :build

[:restart, :down, :ps].each do |t|
  desc "#{t} services"
  task t do
    system %(docker-compose -f #{COMPOSE} #{t})
  end
end

desc 'env variable for REACT'
task :react_env do
  puts "export REACT_APP_USERS_SERVICE_URL=http://$(dm ip #{docker_env})"
end

task :default => :test
