require 'bundler'
require 'debugger'
Bundler.require

# load the Database and User model
require './model'
require './initialize'

Warden::Strategies.add(:password) do
  def valid?
    params['user'] && params['user']['username'] && params['user']['password']
  end

  def authenticate!
    user = User.first(username: params['user']['username'])

    if user.nil?
      throw(:warden, message: "Nuh Uh")
    elsif user.authenticate(params['user']['password'])
      success!(user)
    else
      throw(:warden, message: "Nuh Uh")
    end
  end
end

class SocksWebinterface < Sinatra::Base
  use Rack::Session::Cookie, :key => 'rack.session',
                           :domain => 'daskekshaus.de',
                           :path => '/socks',
                           :expire_after => 3600, # In seconds
                           :secret => 'change_me'

  register Sinatra::Flash
  

  use Warden::Manager do |config|
    # Tell Warden how to save our User info into a session.
    # Sessions can only take strings, not Ruby code, we'll store
    # the User's `id`
    config.serialize_into_session{|user| user.id }
    # Now tell Warden how to take what we've stored in the session
    # and get a User from that information.
    config.serialize_from_session{|id| User.get(id) }

    config.scope_defaults :default,
      # "strategies" is an array of named methods with which to
      # attempt authentication. We have to define this later.
      strategies: [:password],
      # The action is a route to send the user to when
      # warden.authenticate! returns a false answer. We'll show
      # this route below.
      action: 'socks/auth/unauthenticated'
    # When a user tries to log in and cannot, this specifies the
    # app to send the user to.
    config.failure_app = self
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  get '/socks/?' do
    erb :index
  end


  get '/socks/about/?' do
    erb :about
  end

  get '/socks/auth/login/?' do
    erb :login
  end

  post '/socks/auth/login' do
    env['warden'].authenticate!

    flash[:success] = env['warden'].message

    if session[:return_to].nil?
      session[:username] = params['user']['username']
      # debugger
      time = Time.new
      timeString = time.strftime("%d-%m-%Y//%H:%M")
      # p timeString
      AdapterControll.replaceFromFile( "/home/root/allowedIPs.list", request.ip, request.ip + " " + session[:username] + " " + timeString )
      p session[:username]
      p request.ip
      
      redirect '/socks/protected'
    else
       redirect session[:return_to]
    end
  end

  get '/socks/auth/logout' do
    env['warden'].raw_session.inspect
    env['warden'].logout
    flash[:success] = 'Successfully logged out'
    redirect '/socks'
  end

  post '/socks/auth/unauthenticated' do
    session[:return_to] = env['warden.options'][:attempted_path] if session[:return_to].nil?
    # Set the error and use a fallback if the message is not defined
    flash[:error] = env['warden.options'][:message] || "You must log in"
    redirect '/socks/auth/login'
  end

  get '/socks/protected' do
    # p "Session before warden: "
    # p session[:username]
    # debugger
    env['warden'].authenticate!
    # p "Protected"
    # p session[:username]
    @Choices = Initialize.initChoices()
    @currentTun = Initialize.initTun(session[:username].to_s)
    # p @currentTun
    erb :protected
  end

  post '/socks/cast' do
    # debugger
    adapter = params['adapter']
    AdapterControll.initLists()
    cs = AdapterControll.getConnectionState(adapter)
    if cs == 0
      AdapterControll.startConnection(adapter)
    end
    # debugger
    if !( session[:username].nil? )
      AdapterControll.replaceFromFile("/home/root/InterfacePairing.list", session[:username].to_s, session[:username].to_s + " " +  adapter )
    else
      p "Session is null"
    end
    # debugger
    redirect '/socks/protected'
  end
end
