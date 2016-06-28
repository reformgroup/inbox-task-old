class SessionsController < ApplicationController
  
  # TODO: This will be removed if not used
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      case current_role
      when 'admin'        then redirect_to user
      when 'company_user' then redirect_to user
      when 'user'         then redirect_to user
      end
      # TODO: This redirect back or redirect to user page
      # redirect_back_or user
    else
      flash.now[:danger] = { title: t('.flash.danger.title'), message: t('.flash.danger.message') }
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
