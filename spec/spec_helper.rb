$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'randexp'
require 'twitrsvp'
require 'do_sqlite3'
require 'rack/test'
require 'webrat/sinatra'
require 'dm-sweatshop'
require 'pp'

require File.dirname(__FILE__)+'/fixtures'

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!

class Net::HTTPResponse 
  def body=(content) 
    @body = content 
    @read = true 
  end 
end

Spec::Runner.configure do |config|
  config.include(Rack::Test::Methods)
  config.include(Webrat::Methods)
  config.include(Webrat::Matchers)
  def app
    @app = Rack::Builder.new do
      run TwitRSVP::App
    end
  end

  def login_quentin
    response = Net::HTTPSuccess.new('1.0', 200, nil)
    response.body = "{\"description\":\"lulz\",\"profile_background_image_url\":\"http:\\/\\/static.twitter.com\\/images\\/themes\\/theme3\\/bg.gif\",\"utc_offset\":-25200,\"friends_count\":157,\"profile_background_color\":\"EDECE9\",\"profile_text_color\":\"634047\",\"url\":\"http:\\/\\/example.org\",\"name\":\"Quentin Blake\",\"favourites_count\":6,\"profile_link_color\":\"088253\",\"protected\":false,\"status\":{\"truncated\":false,\"in_reply_to_status_id\":null,\"text\":\"stu stu studio\",\"in_reply_to_user_id\":null,\"favorited\":false,\"created_at\":\"Tue Mar 31 19:02:12 +0000 2009\",\"id\":1426242614,\"source\":\"<a href=\\\"http:\\/\\/iconfactory.com\\/software\\/twitterrific\\\">twitterrific<\\/a>\"},\"created_at\":\"Sun Mar 18 20:07:13 +0000 2007\",\"statuses_count\":2560,\"profile_background_tile\":false,\"time_zone\":\"Mountain Time (US & Canada)\",\"profile_sidebar_fill_color\":\"E3E2DE\",\"profile_image_url\":\"http:\\/\\/static.twitter.com\\/images\\/default_profile_normal.png\",\"notifications\":false,\"profile_sidebar_border_color\":\"D3D2CF\",\"location\":\"Boulder, Colorado\",\"id\":1484261,\"following\":false,\"followers_count\":368,\"screen_name\":\"caboose\"}"
    login(response)
  end

  def unauthorized_quentin
    response = Net::HTTPUnauthorized.new('1.0', 401, nil)
    response.body = "Unauthorized"
    login(response)
  end

  def login(response)
    token = 'oU5W1XD2TTZhWT6Snfii9JbVBUkJOurCKhWQHz98765' 

    consumer = mock('Consumer', {:request => response})
    request_token = mock('RequestToken', {:get_access_token => mock('AccessToken', {:token => 'foo', :secret => 'bar'})})

    OAuth::Consumer.stub!(:new).and_return(consumer)
    OAuth::RequestToken.stub!(:new).and_return(request_token)

    get '/callback', :oauth_token => token
    last_response
  end
end
