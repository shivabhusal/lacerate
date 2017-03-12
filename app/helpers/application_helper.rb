module ApplicationHelper
  def label_for(status)
    {
        pending:     'label label-primary',
        in_progress: 'label label-info',
        done:        'label label-success'
    }[status.to_sym] || 'label label-primary'
  end

  def report_analytics_data(reports)
      data = (0..(Integer(params[:chart_filter]) || 30)).to_a.map do |i|
        <<-EOS
         {
             y: '#{i.days.ago.strftime('%Y-%m-%d')}',
             a: #{reports.from_date(i.days.ago).count},
             b: #{reports.from_date(i.days.ago).map(&:keyword_count).sum}
         }
        EOS
      end

    "[#{data.join(',')}]".html_safe
  end
end
