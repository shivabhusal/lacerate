class CreateSearchResults < ActiveRecord::Migration[5.0]
  def change
    create_table :search_results do |t|
      t.string          :keyword
      t.integer         :total_adwords_advertisers_at_top
      t.text            :adwords_links_at_top
      t.integer         :total_adwords_advertisers_at_bottom
      t.text            :adwords_links_at_bottom
      t.integer         :total_non_adwords_links
      t.text            :non_adwords_links
      t.integer         :total_count_of_links
      t.decimal         :time_taken
      t.bigint          :total_number_of_records
      t.text            :page_cache
      t.references      :report,                      foreign_key: true
      t.integer         :status,                      index: true,        default: 0
      t.jsonb           :metadata,                    default: {}
      t.timestamps
    end
  end
end
