class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  respond_to :json, :html

  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      respond_with do |format|
        format.html do
          sign_in_and_redirect @user, :event => :authentication # this will throw if @user is not activated
          set_flash_message(:notice, :success, :kind => 'Facebook') if is_navigational_format?
        end

        format.json do
          render json: { email: @user.email, token: @user.authentication_token }
        end
      end
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    respond_with do |format|
      format.html do
        redirect_to root_path
      end

      format.json do
        format.json { render json: { errors: [status: 401, detail: 'Bad credentials'] }, status: 404 }
      end
    end
  end
end
