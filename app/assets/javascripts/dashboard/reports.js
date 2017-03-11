$(function(){
  if($('.reports.index, .reports.show').length === 0 ) return false;
  $('#report-list, #result-list').DataTable();
});
