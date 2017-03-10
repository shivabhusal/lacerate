module Api::V1
  class SearchResultSerializer < ::ActiveModel::Serializer
    attributes :id, :payload, :status
    belongs_to :report


    def created_at
      object.created_at.in_time_zone.iso8601 if object.created_at
    end

    def updated_at
      object.updated_at.in_time_zone.iso8601 if object.created_at
    end
  end
end
