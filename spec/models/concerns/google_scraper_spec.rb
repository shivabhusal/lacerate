require 'rails_helper'

RSpec.describe GoogleScraper do

  describe '#perform' do
    let(:user)      { create :user }
    let!(:report1)  { create :report, created_at: 11.days.ago, user: user }
    before(:each)   { GoogleScraper.new('best antivirus', report1.id).perform }
    it 'should have 4 adwords advertisers at the top position' do

      expect(report1.search_results.count).to eq(1)
      expect(report1.search_results.first.total_adwords_advertisers_at_top).to eq(4)
    end

    it 'should have 3 adwords advertisers at the bottom position' do
      expect(report1.search_results.first.total_adwords_advertisers_at_bottom).to eq(3)
    end

    it 'should have 11 non-adwords results' do
      expect(report1.search_results.first.total_non_adwords_links).to eq(11)
    end

    it 'should display the number of results to be 26,200,000' do
      expect(report1.search_results.first.total_number_of_records).to eq(26_200_000)
    end
  end

end

# Stubbing the class to prevent it from making expensive HTTP requests
class GoogleScraper
  private
  def http_request
    File.read(Rails.root.join('spec/fixtures/sample_cache.html'))
  end
end
