module Api::V1
  class SearchResultSerializer < ::ActiveModel::Serializer
    attributes :id, :keyword, :status,
               :total_adwords_advertisers_at_top,
               :adwords_links_at_top,
               :total_adwords_advertisers_at_bottom,
               :adwords_links_at_bottom,
               :total_non_adwords_links,
               :non_adwords_links,
               :total_count_of_links,
               :time_taken,
               :total_number_of_records,
               :created_at,
               :updated_at
    belongs_to :report


    def created_at
      object.created_at.in_time_zone.iso8601 if object.created_at
    end

    def updated_at
      object.updated_at.in_time_zone.iso8601 if object.created_at
    end
  end
end
