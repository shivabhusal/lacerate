class SearchResultsController < ApplicationController
  layout 'dashboard'
  before_action :set_result
  def show
  end

  def preview
    render inline: @result.page_cache
  end

  private

  def set_result
    @result = current_user.search_results.find(params[:id])
  end
end
