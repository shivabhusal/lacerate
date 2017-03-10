require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  describe '#create' do
    it 'should return 200 for a valid CSV file'
    it 'should redirect to reports_path when successful'
    it 'should create a new Report record for a valid CSV file'
    it 'should return 406 for a Invalid CSV file'
    it 'should re-render the form with error message'
  end
end
