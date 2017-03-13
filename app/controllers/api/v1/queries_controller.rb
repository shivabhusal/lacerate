module Api::V1
  class QueriesController < BaseController
    # Note: RecordNotFound conditions are handled in BaseController
    respond_to :json

    def search
      query  = Query.new(query_params.merge(user: current_user))
      result = query.execute
      respond_with do |format|
        if result.present?
          format.json { render json: QuerySerializer.new(query, params: query_params).to_json, status: 200 }
        else
          raise LacerateRecordNotFound
        end
      end
    end

    private

    def query_params
      params.require(:query).permit(:caret, :url, :word)
    end
  end
end
