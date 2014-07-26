class SessionController < ApplicationController

  def index
  end

  def bad_login
    if using_open_id?
      open_id_authentication
    elsif params[:user] && params[:user][:email]
      #password_authentication(params[:login], params[:password])
      if request.post?
        email = params[:user][:email]
        password = params[:user][:password]
        referer = params[:referer]
        if !referer.nil? then
          session[:return_to] = referer
        end
        if email.nil? || password.nil? || email == password then
          redirect_to :action => "index"
          flash[:notice] = "Unknown user or invalid password"
        else
          user = User.authenticate(email, password)
          if !user.nil? then
            session[:user_id] = user.id
            user_roles = UserRole.find_all_by_user_id(user.id)
            if !user_roles.nil? && user_roles.length > 0 then
              session_user_roles = Array.new(user_roles.length)
              user_roles.each_with_index do |ur, i|
                session_user_roles[i] = ur.role.name
              end
              session[:user_roles] = session_user_roles
              if user_roles.length == 1 then
                session[:user_role] = user_roles[0]
              end
            end
            flash[:notice] = "Welcome #{user.first_name}"
            if session[:return_to] && !session[:return_to].nil? && !session[:return_to].include?("session") then
              redirect_to session[:return_to]
            else
              redirect_to :controller => "index"
            end
          else
            reset_session
            redirect_to :action => "index"
            flash[:notice] = "Unknown user or invalid password"
          end
        end
      end
    end
  end

  def login
    if request.post?
      email = params[:user][:email]
      password = params[:user][:password]
      referer = params[:referer]
      if !referer.nil? then
        session[:return_to] = referer
      end
      if email.nil? || password.nil? || email == password then
        redirect_to :action => "index"
        flash[:notice] = "Unknown user or invalid password"
      else
        user = User.authenticate(email, password)
        if !user.nil? then
          session[:user_id] = user.id
          user_roles = UserRole.find_all_by_user_id(user.id)
          if !user_roles.nil? && user_roles.length > 0 then
            session_user_roles = Array.new(user_roles.length)
            user_roles.each_with_index do |ur, i|
              session_user_roles[i] = ur.role.name
            end
            session[:user_roles] = session_user_roles
            if user_roles.length == 1 then
              session[:user_role] = user_roles[0]
            end
          end
          flash[:notice] = "Welcome #{user.first_name}"
          if session[:return_to] && !session[:return_to].nil? && !session[:return_to].include?("session") then
            redirect_to session[:return_to]
          else
            redirect_to :controller => "index"
          end
        else
          reset_session
          redirect_to :action => "index"
          flash[:notice] = "Unknown user or invalid password"
        end
      end
    end
  end

  def logout
    reset_session
    redirect_to :controller => "index"
  end

  def forgot_password
    if request.post?
      u = User.find_by_email(params[:user][:email])
      if u and u.send_new_password
        flash[:notice] = "A new password has been sent by email."
        redirect_to :action => "index"
      else
        flash[:warning] = "Couldn't send password"
      end
    end
  end

  protected

    def password_authentication(email, password)
      if self.current_user = User.authenticate(params[:email], params[:password])
        successful_login
      else
        failed_login("Invalid login or password")
      end
    end

    def open_id_authentication
      authenticate_with_open_id do |result, identity_url|
        if result.successful?
          if self.current_user = User.find_or_create_by_identity_url(identity_url)
            successful_login
          else
            failed_login "Sorry, no user by that identity URL exists (#{identity_url})"
          end
        else
          failed_login result.message
        end
      end
    end

  private

    def successful_login
      redirect_back_or_default(index_url)
      flash[:notice] = "Logged in successfully"
    end

    def failed_login(message)
      redirect_to(:action => 'login')
      flash[:warning] = message
    end

end
