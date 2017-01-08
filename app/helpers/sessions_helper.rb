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

end
