# == Schema Information
#
# Table name: search_results
#
#  id                                  :integer          not null, primary key
#  keyword                             :string
#  total_adwords_advertisers_at_top    :integer
#  adwords_links_at_top                :text             default("{}"), is an Array
#  total_adwords_advertisers_at_bottom :integer
#  adwords_links_at_bottom             :text             default("{}"), is an Array
#  total_non_adwords_links             :integer
#  non_adwords_links                   :text             default("{}"), is an Array
#  total_count_of_links                :integer
#  time_taken                          :decimal(, )
#  total_number_of_records             :integer
#  page_cache                          :text
#  report_id                           :integer
#  status                              :integer          default("0")
#  metadata                            :jsonb            default("{}")
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#

class SearchResult < ApplicationRecord
  store         :metadata, accessors: [:server_name]
  enum          :status => [:pending, :done]
  after_commit  :update_report

  belongs_to    :report

  class << self
    # fixme: The implementation below cost time
    # A better alternative would be Querying the Array fields in PG using PG's native operators.
    # Because of lack of time and knowledge I could not implement those.
    def word_query(word)
      common_url_query { |link| link.include?(word) }
    end

    def url_query(url)
      common_url_query { |link| link.include?(url) }
    end

    def caret_query
      common_url_query { |link| (link.count('/') > 2 || link.count('>') > 1) }
    end

    def common_url_query(&logic)
      results = { adwords_links_at_top: [], adwords_links_at_bottom: [], non_adwords_links: [] }
      self.all.each do |result|
        result.adwords_links_at_top.each do |link|
          results[:adwords_links_at_top] << link if logic.call(link)
        end

        result.adwords_links_at_bottom.each do |link|
          results[:adwords_links_at_bottom] << link if logic.call(link)
        end

        result.non_adwords_links.each do |link|
          results[:non_adwords_links] << link if logic.call(link)
        end
      end
      results
    end

  end

  private

    def update_report
      if self.report.keyword_count == self.report.search_results.count
        self.report.done!
      end
    end
end
