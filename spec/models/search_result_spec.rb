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

require 'rails_helper'

RSpec.describe SearchResult, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
