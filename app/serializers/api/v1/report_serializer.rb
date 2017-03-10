module Api::V1
  class ReportSerializer < ::ActiveModel::Serializer
    attributes :id, :payload, :status, :created_at
    has_many :search_results

    def created_at
      object.created_at.in_time_zone.iso8601 if object.created_at
    end

    def updated_at
      object.updated_at.in_time_zone.iso8601 if object.created_at
    end
  end
end
