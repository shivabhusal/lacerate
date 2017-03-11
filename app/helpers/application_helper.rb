module ApplicationHelper
  def label_for(status)
    {
        pending:     'label label-primary',
        in_progress: 'label label-info',
        done:        'label label-success'
    }[status.to_sym] || 'label label-primary'
  end
end
