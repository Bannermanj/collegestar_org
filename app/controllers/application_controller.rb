class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    if cookies[:auth_token]
      return @current_user ||= User.find_by_auth_token!(cookies[:auth_token])
    else
      return NullUser.new
    end
  end

  def create_session(args = {})
    @session = Session.create(
      email: args[:email],
      password: args[:password],
      permanent: args.fetch(:permanent, false)
    )
    if @session.auth_token
      persist_session(@session)
    end
    @session.auth_token
  end

  def destroy_session
    Session.destroy( cookies )
  end 

  private 
  
  def persist_session(session)
    @session ||= session
    @session.persist(cookies)
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(login_path)
  end
end
