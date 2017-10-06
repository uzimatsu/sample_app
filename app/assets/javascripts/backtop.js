$(function () {
  // 非表示状態
  $('#back-top').hide();
  //スクロール時の位置を判定、場所によって、表示表示状態を決める
  $(window).scroll(function () {
    if ($(this).scrollTop() > 60) {
      $('#back-top').fadeIn();
    }else {
      $('#back-top').fadeOut();
    }
  });

  // クリックされたら上に戻る
  $('#back-top a').click(function () {
    // 0.5秒でスクロールのトップに戻す
    $('body, html').animate({
      scrollTop:0
    }, 400);
    return false;
  });
});
