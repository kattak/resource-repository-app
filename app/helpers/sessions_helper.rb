module SessionsHelper
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
