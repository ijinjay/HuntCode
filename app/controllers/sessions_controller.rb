class SessionsController < ApplicationController
  # GET /loginReg
  # 登录注册界面
  def loginReg
    render "users/loginReg.html"
  end

  def create
    user = User.find_by(x_email: params[:session][:x_email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in user
      redirect_to user
    else
      # Create an error message and re-render the signin form.
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end
