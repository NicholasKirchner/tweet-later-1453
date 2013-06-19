get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

post '/tweets' do 
  user = User.find(session[:user_id])
  tweet = Tweet.create(:user_id => user.id, :text => params[:tweet])
  job = user.tweet(tweet.text)
  job.to_s
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  user_params = { username: @access_token.params[:screen_name],
                  oauth_token: @access_token.token,
                  oauth_secret: @access_token.secret }

  user = User.create(user_params)
  session[:user_id] = user.id

  erb :index
  
end

get '/status/:job_id' do
  puts "got a status update request"
  jid = params[:job_id]
  job_is_complete(jid) ? "Yep!" : "Nope!"
end