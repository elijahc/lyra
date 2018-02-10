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
    desc "recreate database" 
    task :recreate, [:up] do
      manage(COMPOSE,"recreate_db")
    end

    desc "seed the database"
    task :seed, [:recreate] do
      manage(COMPOSE,"seed_db")
    end

    [:init,:migrate,:upgrade].each do |t|
      desc "flask db #{t}"
      task t do
        manage(COMPOSE,"db #{t}",'users-service')
      end
    end
end

desc 'run flake8'
task :flake8 do
  system %(docker-compose -f #{COMPOSE} run users-service flake8 project)
end
