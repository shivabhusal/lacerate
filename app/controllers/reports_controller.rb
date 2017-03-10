class ReportsController < ApplicationController
  layout 'dashboard'

  def index
    @reports = Report.all
    flash.notice = 'Processing is in progress! It may take a few seconds to complete the processing, stay tuned.'
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to reports_path,
                  notice: 'Processing is in progress! It may take a few seconds to complete the processing, stay tuned.'
    else
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:payload)
  end

end
