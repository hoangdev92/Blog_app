class SessionController < ApplicationController
  before_action :params_register, only: [:create]
  skip_before_action :require_login, only: %i[login signin create register forgot_password destroy]
  def login
  end

  def signin
    user = User.find_by(email: params[:user][:email])
    if user&.authenticate(params[:user][:password])
      log_in user
      redirect_to trangchu_path
    else
      flash[:error] = 'Taì Khoản hoặc mật khẩu không chính xác'
      render :login
    end
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

  def register
    @user = User.new
  end

  def forgot_password
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Đăng Xuất thành công!"
    redirect_to login_path
  end

  private

  def params_register
    params.require(:user).permit(:email, :password, :name)
  end
end
