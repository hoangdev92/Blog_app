class SessionController < ApplicationController
  before_action :params_register, only: [:create]
  skip_before_action :require_login, only: %i[login signin create register forgot_password destroy login_app]
  def login
  end

  def signin
    user = User.find_by(email: params[:user][:email])
    if user&.authenticate(params[:user][:password])
      set_is_online user
      log_in user
      redirect_to trangchu_path
    else
      flash[:error] = 'Taì Khoản hoặc mật khẩu không chính xác'
      render :login
    end
  end

  def login_app
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user
      set_is_online @user
      log_in @user
      flash[:success] = "Welcome, #{@user.name}!"
    else
      flash[:warning] = "Lỗi Khi đăng nhập!"
    end
    redirect_to root_path
  end

  def create
    user = User.new(params_register)
    Active::Base.transaction do
      if user.password != params[:user][:re_password]
        flash[:success] = 'Nhập lại mật khẩu không chính xác'
        render :register
      elsif user.save!
        flash[:success] = 'Đăng Ký Thành Công, Hãy Đăng Nhập'
        redirect_to login_path
      else
        flash[:error] = 'Vui Lòng Kiểm Tra Lại Các Trường Dữ Liệu'
        render :register
      end
    end
    rescue
      flash[:error] = 'Kiểm tra lại các trường dữ liệu, hoặc email đã tồn tại'
      render :register
  end

  def set_is_online user
    if user.password == nil
      user.is_online = true
      user.save!(validate: false)
    else
      user.is_online = true
      user.update
    end
  end

  def register
    @user = User.new
  end

  def forgot_password
  end

  def destroy
    user = User.find(session[:user_id])
    user.is_online = false
    if user.password == nil
      user.save!(validate: false)
    else
      user.is_online = true
      user.update
    end
    session[:user_id] = nil
    flash[:success] = "Đăng Xuất thành công!"
    redirect_to login_path
  end

  private

  def params_register
    params.require(:user).permit(:email, :password, :name)
  end
end
