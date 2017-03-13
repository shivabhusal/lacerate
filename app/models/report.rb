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

  validates_presence_of :payload

  belongs_to :user
  has_many :search_results, dependent: :destroy

  mount_uploader :payload, PayloadUploader
  enum status: [:pending, :in_progress, :done]


  before_create :set_vars
  after_commit :activate_workers, on: [:create]

  # Will give all the reports created on that date/day
  scope :from_date, ->(date) { where('created_at between ? and ?', date.beginning_of_day, date.end_of_day) }

  def sync_status!
    self.done! if (self.search_results.count == self.keyword_count) && !self.done?
  end

  private

  def set_vars
    @keywords     = CSV.parse(File.read(payload.file.file)).flatten.uniq
    self.keyword_count = @keywords.count
    self.status        = :in_progress
  end

  def activate_workers
    per_batch = @keywords.count > 5 ? @keywords.count / 5 : 5

    @keywords.in_groups_of(per_batch, fill_will_nil_value = false).each_with_index do |keywords_batch, index|
      keywords_batch.each do |keyword|
        time_of_execution = (index * 5).seconds
        ScrapeWorker.perform_in(time_of_execution, keyword, self.id)
      end
    end
  end

end
