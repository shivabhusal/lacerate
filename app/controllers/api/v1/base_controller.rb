class Api::V1::BaseController < ApiController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_filter :authenticate_user!

  private

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    user_email     = options.blank? ? nil : options[:email]
    user           = user_email && User.find_by(email: user_email)

    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      @current_user = user
    else
      unauthenticated!
    end
  end

  def unauthenticated!
    response.headers['WWW-Authenticate'] = "Token realm=Application"

    respond_to do |format|
      format.json { render json: { errors: [status: 401, detail: 'Bad credentials'] }, status: 404 }
    end
  end

  # A decoy till authentication is implemented
  def current_user
    @current_user
  end

  def not_found
    respond_to do |format|
      format.json { render json: { errors: [status: 404, detail: 'Must be present.'] }, status: 404 }
    end
  end
end
