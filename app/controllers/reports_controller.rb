class ReportsController < ApplicationController
  layout 'dashboard'

  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
  end

  def show
    @report = User.first.reports.find(params[:id])
  end

  def create
    @report = User.first.reports.new(report_params)
    if @report.save
      redirect_to reports_path,
                  notice: 'Processing is in progress! It may take a few seconds to complete the processing, stay tuned.'
    else
      flash.now[:error] = @report.errors.messages
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:payload)
  end

end
