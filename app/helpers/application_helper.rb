module ApplicationHelper
  def label_for(status)
    {
        pending:     'label label-primary',
        in_progress: 'label label-info',
        done:        'label label-success'
    }[status.to_sym] || 'label label-primary'
  end

  # Generates data to be fetched to the Morris.js Area chart
  # @return [String]
  #
  # Example:
  # [
  #   {
  #     y: '2017-03-11 07:10:10',
  #     a: 3,
  #     b: 12
  #   }
  # ]
  # #
  def report_analytics_data(reports)
      data = (0..(params[:chart_filter] || Config::DEFAULT_CHART_WINDOW).to_i).to_a.map do |i|
        <<-EOS
         {
             y: '#{i.days.ago.strftime('%Y-%m-%d %H:%M:%S')}',
             a: #{reports.from_date(i.days.ago).count},
             b: #{reports.from_date(i.days.ago).map(&:keyword_count).sum}
         }
        EOS
      end

    "[#{data.join(',')}]".html_safe
  end
end
