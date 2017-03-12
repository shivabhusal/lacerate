require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Reports' do
  get 'api/v1/reports' do

    let!(:user) { create :user }
    let!(:report1) { create :report, user: user }
    let!(:report2) { create :report, user: user }
    let!(:search_result11) { create :search_result, id: 1, report: report1 }
    let!(:search_result21) { create :search_result, id: 2, report: report2 }

    example 'index | Listing Reports' do

      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      header 'Authorization', "Token token=\"#{user.authentication_token}\", email=\"#{user.email}\""

      do_request
      expect(status).to eq(200)
    end
  end

  get 'api/v1/reports/1' do
    let!(:user) { create :user }
    let!(:report1) { create :report, id: 1, user: user }
    let!(:search_result11) { create :search_result, id: 1, report: report1 }
    let!(:search_result12) { create :search_result, id: 2, report: report1 }
    example 'show | Getting a particular report and associated searches records' do

      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      header 'Authorization', "Token token=\"#{user.authentication_token}\", email=\"#{user.email}\""

      do_request
      expect(status).to eq(200)
    end
  end

  post 'api/v1/reports/' do
    let!(:user) { create :user }
    let(:payload) { Rack::Test::UploadedFile.new(Rails.root.join('sample.csv')) }
    parameter :payload, 'New CSV file to upload', :scope => :report
    example 'create | Search new batch of keywords' do

      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      header 'Authorization', "Token token=\"#{user.authentication_token}\", email=\"#{user.email}\""

      do_request
      expect(status).to eq(201)
    end
  end
end
