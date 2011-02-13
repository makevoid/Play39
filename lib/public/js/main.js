$(function(){
  $("table#songs tr").click(function(){
    location.href = $(this).attr('data-url');
  });
});