module Api::V1
  class ReportsController < BaseController
    respond_to :json

    def index
      reports = current_user.reports.all
      respond_with do |format|
        format.json { render json: reports , status: 200 }
      end
    end

    def show
      report = current_user.reports.find(params[:id])
      respond_with do |format|
        format.json { render json: report, status: 200 }
      end
    end

    def create
      report = current_user.reports.new(report_params)
      if report.save
        respond_with do |format|
          format.json { render json: report, status: 201 }
        end
      else
        render :new
      end
    end

    private

    def report_params
      params.require(:report).permit(:payload)
    end
  end
end
