# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  payload    :string
#  status     :integer          default("0")
#  metadata   :jsonb            default("{}")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Report, type: :model do
  it { should validate_presence_of(:payload) }
  it { should have_many(:search_results) }
  it { should belong_to(:user) }

  it 'should have 3 statuses' do
    expect(Report.statuses.keys.map(&:to_sym)).to match_array([:pending, :in_progress, :done])
  end

  describe 'after_create' do
    let(:user) { create :user }

    it 'should activate 4 jobs after a new report record is created' do
      create :report, user: user
      expect(ScrapeWorker.jobs.count).to eq(4)
    end

    example 'there should be 4 keywords - 4 keywords in the sample.csv file' do
      create :report, user: user
      expect(ScrapeWorker.jobs.count).to eq(4)
    end
  end

  describe '.from_date' do
    let(:user)      { create :user }
    let!(:report1)  {create :report, created_at: 11.days.ago, user: user}
    let!(:report2)  {create :report, created_at: 10.days.ago, user: user}
    let!(:report3)  {create :report, created_at: 10.days.ago, user: user}
    let!(:report4)  {create :report, created_at: 9.days.ago, user: user}

    it 'should return reports from 10 days ago' do
      expect(Report.from_date(10.days.ago).ids).to match_array([report2.id, report3.id])
      expect(Report.from_date(10.days.ago).ids).not_to match_array([report1.id, report2.id])
    end
  end
end
