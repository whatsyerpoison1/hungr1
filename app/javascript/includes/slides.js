document.addEventListener("turbolinks:load", () => {
  var $activeSlide = $('#slides .slide:first-child');
  $activeSlide.addClass('showing');

  $('#decline').on('click', function () {
    updateSlide('decline');
  });

  $('#approve').on('click', function () {
    updateSlide('approve');
  });

  function updateSlide(action) {
    $activeSlide.removeClass('showing');

    let user_id = $activeSlide.data('id')

    $.ajax({
      url: '/' + action + '/' + user_id,
      method: 'post',
      dataType: 'ajax'
    })

    $activeSlide = $activeSlide.next('.slide');
    $activeSlide.addClass('showing')
  }
});
