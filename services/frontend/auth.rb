require 'sinatra/base'

module Sinatra
    module SessionAuth
        module Helpers
            def authorized?
              session[:authorized]
            end
      
            def authorize!
              redirect '/' unless authorized?
            end
      
            def logout!
              session[:authorized] = false
            end

            def self.registered(app)
                app.helpers SessionAuth::Helpers
          
                app.get '/login' do
                    redirect '/'
                end
          
                app.post '/login' do
                    if User.where(:username=>params[:username]).exists?
                    @User = User.find_by(:username=>params[:username])
                    if @User.check_pass(params[:password])
                        session[:authorized] = true
                    else
                        session[:authorized] = false
                        redirect '/'
                    end
                    else
                    redirect '/'
                    end
                end
            end
        end
    end
    register SessionAuth
end