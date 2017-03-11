class SearchResultsController < ApplicationController
  layout 'dashboard'
  def show
    @result = current_user.search_results.find(params[:id])
  end
end
