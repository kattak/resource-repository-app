module SessionsHelper
  #Tried to print this out with SessionsHelper.hi, ["hi"], [:hi], [":hi"] (none work)

  # irb(main):044:0> SessionsController.instance_methods
  # => [:new, :create, :destroy, :login, :hi, :current_user, :logout,...

  ##helper.hi works
  ##include SessionsHelper, SessionsHelper.hi works
  ##SessionsHelper.current_user does NOT work --> have to sign in to the terminal?  But terminal has access to app.session?!

  ###TO login via the terminal -- would this make current_user available in the console?!
  #   # Get the login form
  # app.get '/login'
  # # View the session
  # app.session.to_hash
  # # Copy the CSRF token "_csrf_token" and place it in the login request.
  # # Log in from the console to create a session
  # app.post '/login', {"authenticity_token"=>"5aMTqep2Tp35PP7G+v50AjNdiI2PKHmWeF+Lv3ZflQk=",  "user[login]"=>'chloe', 'user[password]'=>'test'}

#Notes from SO:
#   wow amazing, how to post/get/session stuff in console:
# http://stackoverflow.com/a/23899701
#
# # Start Rails console
# rails console
# # Get the login form
# app.get '/login'
# # View the session
# app.session.to_hash
# # Copy the CSRF token "_csrf_token" and place it in the login request.
# # Log in from the console to create a session
# app.post '/login', {"authenticity_token"=>"5aMTqep2Tp35PP7G+v50AjNdiI2PKHmWeF+Lv3ZflQk=",  "user[login]"=>'chloe', 'user[password]'=>'test'}
# # View the session to verify CSRF token is the same
# app.session.to_hash
# # Copy the CSRF token "_csrf_token" and place it in the request. It's best to edit this in Notepad++
# app.post '/refinery/blog/posts', {"authenticity_token"=>"gT7G17RNFaWUDLC6PJGapwHk/OEyYfI1V8yrlg0lHpM=", "switch_locale"=>"en", "post"=>{"title"=>"Test", "homepage"=>"0", "featured"=>"0", "magazine"=>"0", "refinery_category_ids"=>["1282"], "body"=>"Tests do a body good.", "custom_teaser"=>"", "draft"=>"0", "tag_list"=>"", "published_at(1i)"=>"2014", "published_at(2i)"=>"5", "published_at(3i)"=>"27", "published_at(4i)"=>"21", "published_at(5i)"=>"20", "custom_url"=>"", "source_url_title"=>"", "source_url"=>"", "user_id"=>"56", "browser_title"=>"", "meta_description"=>""}, "continue_editing"=>"false", "locale"=>:en}
# Might be useful:
# app.cookies.to_hash
# app.flash.to_hash
# app.response # long, raw, HTML
#
# add helper methods to your rails console
# http://opensoul.org/2012/11/08/add-helper-methods-to-your-rails-console/
#
# ohhhh amazing


#hi function to test access to helper methods in rails console
  def hi
    return "hi"
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session.clear
  end

  def current_user
    if session[:user_id]
      #find_by returns nil, find throws an error
      if User.find_by(id: session[:user_id])
        #in ruby, conditional value(terminology?) will be executed
        #will return that user as current_user
      else
        #if user is nil, that means the server stopped while they was a user still logged in
        #this will mess up the app bc it's trying to find a user that might not exist(?)
        ## solution: clear the session to get rid of the 'zombie' user
        session.clear
      end
    end
  end
  # possible cleaner rewrite:
  # @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]

end
