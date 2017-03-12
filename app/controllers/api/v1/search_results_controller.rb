module Api::V1
  class SearchResultsController < BaseController
    # Note: RecordNotFound conditions are handled in BaseController
    respond_to :json

    def index
      results = current_user.reports.find(params[:report_id]).search_results
      respond_with do |format|
        format.json { render json: results, status: 200 }
      end
    end

    def show
      result = current_user.reports.find(params[:report_id]).search_results.find(params[:id])
      respond_with do |format|
        format.json { render json: result, status: 200 }
      end
    end

    def preview
      result = current_user.reports.find(params[:report_id]).search_results.find(params[:id])
      respond_with do |format|
        format.json { render json: { html: result.page_cache }, status: 200 }
      end
    end
  end
end
