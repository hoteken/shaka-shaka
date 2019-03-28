$(function(){
  // モーダル表示用
  $('#dest-select').on('click',function(){
    $('#overlay,#result').fadeIn();
  });
  $('#close,#overlay').on('click', function(){
    $('#overlay,#result').fadeOut();
  });
  $('#result').on('click', function(e){
      e.stopPropagation();
  });

  // 確定ボタン
  $('.go').on('click', function(){
    $('#overlay,#result').fadeOut();
    swal("Changed Successfully!", "送付先の変更に成功しました", "success");
  });

  $('.request_ajax_update').on('ajax:complete', function(event) {
    var response;
    response = event.detail[0].response;
    $('#updated_by_ajax').html(response);
  });


});