# How many URLs contain the word “technology” in AdWords
# How many times a specific URL shows up in SEO.
# How many keywords have URLs in SEO with 2+ /’s or 1+ >

class Query < ActiveModelSerializers::Model
  attr_reader :params, :user

  def initialize(params = {})
    @params = params
    @user   = params[:user]
  end

  def execute
    result         = {}
    result[:word]  = user.search_results.word_query(params[:word])  if params[:word].present?
    result[:url]   = user.search_results.url_query(params[:url])    if params[:url].present? # We assume URL is a fragment od actual URL
    result[:caret] = user.search_results.caret_query                if params[:caret] == 'on'

    result
  end
end
