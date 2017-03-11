class ScrapeWorker
  include Sidekiq::Worker

  def perform(keyword, report_id)
    GoogleScraper.new(keyword, report_id).perform
  end
end
