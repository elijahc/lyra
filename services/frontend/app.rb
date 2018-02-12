require 'sinatra/base'
require 'slim'
require 'json'
require './auth'
# require 'redis'
# require 'securerandom'
# require 'pry'
require 'mongoid'
require 'roar/json/hal'

class Application < Sinatra::Base
  register Sinatra::SessionAuth

  configure do
    set :bind, '0.0.0.0'

    Mongoid.load!("config-mongoid.yml", settings.environment)
  end

  get '/' do
    slim :index,:layout=>false
  end

  get '/library/new' do
    slim :design
  end

  post '/library/create' do
    sym_hash = params.map{|k,v| [k.to_sym,v] }.to_h
    sym_hash[:built]=false
    user = User.find_or_create_by(:username=>sym_hash[:username])
    lib = Library.new(sym_hash)
    if lib.save
      [201, lib.extend(LibraryRepresenter).to_json]
    else
      [500, {:message=>"Failed to save product"}.to_json]
    end
    # pos = redis.lpush(JOB_Q,job_id)
    # redis.hset(STATUS,job_id,params.to_json)

    redirect "/library/#{lib.id.to_str}"
  end

  get '/library/:id' do |lib_id|
    # Fetch job id
    # if redis.hexists(STATUS,job_id)
    #   job = redis.hget(STATUS,job_id)
    #   @job = JSON.parse(job)
    #   slim :job
    # else
    #   halt 404, 'job does not exist!'
    # end
    @lib = Library.find(lib_id)
    slim :lib
  end

  get '/libraries' do
    authorize!
    @libs = Library.all.order_by(:created_at => 'desc')
    # ProductRepresenter.for_collection.prepare(products)
    @disp_attrs = ['_id','built','name','created_at']
    slim :all_libraries
  end


  get '/jobs' do
    @unbuilt_libs = Library.where(:built=>false)

      
    # binding.pry
    LibraryRepresenter.for_collection.prepare(@unbuilt_libs).to_json
  end
end
