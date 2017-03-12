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

require 'csv'
class Report < ApplicationRecord
  store :metadata, accessors: [:keyword_count]

  belongs_to :user
  has_many :search_results

  mount_uploader :payload, PayloadUploader
  enum status: [:pending, :in_progress, :done]

  after_create :activate_workers #:unless => :persisted?
  scope :from_date, ->(date){where('created_at between ? and ?', date.beginning_of_day, date.end_of_day)}

  private

  def activate_workers
    keywords = CSV.parse(File.read(payload.file.file)).flatten.uniq
    self.update(keyword_count: keywords.count, status: :in_progress)

    keywords.each_with_index do |keyword, index|
      ScrapeWorker.perform_in((index*5).seconds, keyword, self.id)
    end
  end

end
