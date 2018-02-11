require 'sinatra'
require 'slim'
require 'json'
require 'redis'

redis = Redis.new

get '/' do
  slim :index
  # send_file './views/bootstrap_starter_template.html'
end

post '/job/new' do
  redis_resp = redis.lpush('kamikaze',params.to_json)
  puts(redis_resp)
  slim :job
end

get '/job/:id' do |job_id|
  # Fetch job id
  slim :job
end