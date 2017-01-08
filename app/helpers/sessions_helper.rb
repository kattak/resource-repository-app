module SessionsHelper
  #Tried to print this out with SessionsHelper.hi, ["hi"], [:hi], [":hi"] (none work)
  def hi
    return "hi"
  end



  def login(user)
    session[:user_id] = user.id
  end



#   irb(main):043:0> SessionsController.hi
# NoMethodError: undefined method `hi' for SessionsController:Class
#does not work

# irb(main):044:0> SessionsController.instance_methods
# => [:new, :create, :destroy, :login, :hi, :current_user, :logout,...


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
