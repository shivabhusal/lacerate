require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Search Results' do
  get 'api/v1/reports/1/search_results' do
    let!(:user) { create :user }
    let!(:report1) { create :report, id: 1, user: user }
    let!(:search_result11) { create :search_result, report: report1}
    let!(:search_result12) { create :search_result, report: report1}
    example 'Listing Search results of a Report' do

      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      header 'Authorization', "Token token=\"#{user.authentication_token}\", email=\"#{user.email}\""

      do_request
      expect(status).to eq(200)
    end
  end

  get 'api/v1/reports/1/search_results/1' do
    let!(:user) { create :user }
    let!(:report1) { create :report, id: 1, user: user }
    let!(:search_result11) { create :search_result, id: 1, report: report1}
    example 'Getting a Search result of a particular Report' do

      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      header 'Authorization', "Token token=\"#{user.authentication_token}\", email=\"#{user.email}\""

      do_request
      expect(status).to eq(200)
    end
  end

  get 'api/v1/reports/1/search_results/1/preview' do
    let!(:user) { create :user }
    let!(:report1) { create :report, id: 1, user: user }
    let!(:search_result11) { create :search_result, id: 1, report: report1}
    example 'Getting the cached version of search page' do

      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      header 'Authorization', "Token token=\"#{user.authentication_token}\", email=\"#{user.email}\""

      do_request
      expect(status).to eq(200)
    end
  end
end
