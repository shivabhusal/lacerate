$(function () {
  if ($('.reports.index, .reports.show').length === 0) return false;
  $('#report-list, #result-list').DataTable({"pageLength": 50});

  if ($('.in_progress').length > 0) {
    $('.in_progress').each(function (index) {
      var $item = $(this);
      var $intervals = [];
      $intervals[index] = setInterval(function () {
        $.ajax({
          type: 'get',
          url: '/reports/' + $item.data('id') + '/status',
          success: function (data) {
            if (data['status'] === 'done') {
              var $new_status = $("<span class='label label-success'>done</span>");

              $('#status-' + $item.data('id')).replaceWith($new_status);
              $('#loading-image-' + $item.data('id')).remove();
              clearInterval($intervals[index]);
            }

            $('#search-count-' + $item.data('id')).html(data['result_count']);

            var percent = parseFloat(data['result_count']) / Number(data['keyword_count']) * 100;
            $('#progress-' + $item.data('id')).width(percent + '%');
          }

        })
      }, 500);
    });


  }
});
