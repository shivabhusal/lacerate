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

FactoryGirl.define do
  factory :report do
    payload { Rack::Test::UploadedFile.new(File.join(Rails.root, 'sample.csv')) }

  end
end
