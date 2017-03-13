class QueriesController < ApplicationController
  layout 'dashboard'

  def index
  end

  def search
    query   = Query.new(query_params.merge(user: current_user))
    @result = query.execute
    if @result.present?
      flash.now[:notice] = 'Query successfully performed. Please find the result below.'
    else
      flash[:error] = 'Sorry! could not find any record matching the criteria'
      redirect_to queries_path
    end
  end

  private
  def query_params
    params.require(:query).permit(:caret, :url, :word)
  end
end
