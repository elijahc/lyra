docker_env = ENV['DOCKER_MACHINE_NAME']
raise 'No active docker-machine!' unless docker_env

compose_files = {
  'lyra-dev'=>'docker-compose-dev.yml',
  'lyra-prod'=>'docker-compose-prod.yml'
}
COMPOSE = compose_files[docker_env]

load './users-service/users-service-tasks.rake'

desc 'bring services up'
task :up do
  system %(docker-compose -f #{COMPOSE} up -d)
end

desc 'build services'
task :build do
  system %(docker-compose -f #{COMPOSE} up -d --build)
  Rake::Task['test'].invoke
end
task :rebuild => :build

[:restart, :down, :ps].each do |t|
  desc "#{t} services"
  task t do
    system %(docker-compose -f #{COMPOSE} #{t})
  end
end

task :default => :test