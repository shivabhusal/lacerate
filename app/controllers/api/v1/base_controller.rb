class Api::V1::BaseController < ApiController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found
    respond_to do |format|
      format.json { render json: { errors: [status: 404, detail: 'Must be present.'] }, status: 404 }
    end
  end

end
