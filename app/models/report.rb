# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  payload    :string
#  status     :integer          default("0")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Report < ApplicationRecord
  belongs_to :user
  has_many :search_results

  mount_uploader :payload, PayloadUploader
  enum status: [:pending, :done]

end
