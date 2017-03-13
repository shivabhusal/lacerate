class ReportsController < ApplicationController
  layout 'dashboard'
  respond_to :json, only: :status

  def index
    @reports = current_user.reports.try(status_params)
  end

  def new
    @report = Report.new
  end

  def show
    @report = current_user.reports.find(params[:id])
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to reports_path,
                  notice: 'Processing is in progress! It may take a few seconds to complete the processing, stay tuned.'
    else
      flash.now[:error] = @report.errors.messages
      render :new
    end
  end

  # Returns status of the ongoing report to the browser
  def status
    @report = current_user.reports.find(params[:id])
    @report.sync_status!

    respond_with do |format|
      format.json { render json:                                {
          status:       @report.reload.status,
          keyword_count: @report.keyword_count,
          result_count: @report.search_results.count }, stauts: 200 }
    end
  end

  private

  def report_params
    params.require(:report).permit(:payload)
  end

  # Filter user supplied params for security reasons.
  def status_params
    Report.statuses.include?(params[:filter]) ? params[:filter] : 'all'
  end
end
