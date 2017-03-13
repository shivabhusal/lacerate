require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Custom Queries' do
  get 'api/v1/queries/search' do
    let!(:user) { create :user }
    let!(:report1) { create :report, id: 1, user: user }

    let(:word) {'bing'}
    let(:caret) {'on'}
    let(:url) {'www.google.com'}

    let!(:search_result11) { create :search_result, report: report1}
    let!(:search_result12) { create :search_result, report: report1}
    parameter :word, 'Query word', :scope => :query
    parameter :caret, 'Agree to query carets and slashes', :scope => :query
    parameter :url, 'Query occurance of the url', :scope => :query
    example 'Listing custom query results' do

      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      header 'Authorization', "Token token=\"#{user.authentication_token}\", email=\"#{user.email}\""

      do_request
      expect(status).to eq(200)
    end
  end

end
