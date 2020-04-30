$(function(){
  $('.price_calc').on('input', function(){
    var data = $('.price_calc').val();
    var profit = Math.round(data * 0.97)
    var fee = (data - profit)
    $('.selectbox-block-money__box__bellow__right').html(fee)
    $('.selectbox-block-money__box__bellow__right').prepend('¥')
    $('.selectbox-block-money__profit__right').html(profit)
    $('.selectbox-block-money__profit__right').prepend('¥')
    $('#price').val(profit)
    if(data < 300 || data > 9999999) {
    $('.selectbox-block-money__box__bellow__right').html('ー');
    $('.selectbox-block-money__profit__right').html('ー');
    }
  })
})