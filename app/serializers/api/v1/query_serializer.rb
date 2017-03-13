module Api::V1
  class QuerySerializer < ::ActiveModel::Serializer
    attributes :params, :created_at, :result

    def initialize(resource, options)
      @params = options[:params]
      super(resource, options)
    end

    def result

    end

    def created_at
      DateTime.now.in_time_zone.iso8601
    end
  end
end
