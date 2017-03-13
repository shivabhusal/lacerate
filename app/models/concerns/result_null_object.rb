# This class implements the NullObjectPattern
class ResultNullObject
  attr_reader :data

  def initialize
    @data = OpenStruct.new(
        {
            count:                   0,
            non_adwords_links:       [],
            adwords_links_at_bottom: [],
            adwords_links_at_top:    []

        })
  end

  def method_missing(method_name, *params)
    data.send(method_name, *params)
  end
end
