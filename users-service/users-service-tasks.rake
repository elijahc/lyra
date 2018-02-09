def manage(compose_fp,cmd,service='users-service')
  system %(docker-compose -f #{compose_fp} run #{service} python manage.py #{cmd})
end

desc 'run test suite on current env'
task :test, [:up] do
  manage(COMPOSE,'test','users-service')  
end

desc 'dispaly test coverage'
task :cov do
    manage(COMPOSE,'cov','users-service')
end

namespace :db do
  [:seed,:recreate].each do |t|
      desc "#{t} db"
      task t, [:up] do
        manage(COMPOSE,"#{t}_db")
      end
  end
end

desc 'run flake8'
task :flake8 do
  system %(docker-compose -f #{COMPOSE} run users-service flake8 project)
end