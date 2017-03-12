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

FactoryGirl.define do
  factory :search_result, class: 'SearchResult' do
    keyword { Faker::Hacker.noun }

    total_adwords_advertisers_at_top { Faker::Number.number(1) }
    adwords_links_at_top { total_adwords_advertisers_at_top.to_i.times.map { Faker::Internet.url } }

    total_adwords_advertisers_at_bottom { Faker::Number.number(1) }
    adwords_links_at_bottom { total_adwords_advertisers_at_bottom.to_i.times.map { Faker::Internet.url } }

    total_non_adwords_links { Faker::Number.number(1) }
    non_adwords_links { total_non_adwords_links.to_i.times.map { Faker::Internet.url } }

    total_count_of_links { total_adwords_advertisers_at_bottom.to_i + total_non_adwords_links.to_i + total_adwords_advertisers_at_top.to_i}

    total_number_of_records { Faker::Number.number(10) }
    page_cache File.read(Rails.root.join('spec', 'fixtures', 'sample_cache.html'))
  end
end
