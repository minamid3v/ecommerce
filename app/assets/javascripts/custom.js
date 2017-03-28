$(document).on('turbolinks:load', function(){
  $('input.only-number').on('keyup', function(event){
    if(isNaN($(this).val())){
      $(this).val(1)
    }
  });

  $(document).on('click', '')
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $('#image-upload').change(function(){
    $('#img_prev').removeClass('hidden');
    $('#current-profile-image').addClass('hidden');
    readURL(this);
  });

  $('.multi-item-carousel').carousel({
    interval: 2000
  });

  $('.multi-item-carousel .item').each(function(){
    var next = $(this).next();
    if (!next.length) {
      next = $(this).siblings(':first');
    }
    next.children(':first-child').clone().appendTo($(this));

    if (next.next().length>0) {
      next.next().children(':first-child').clone().appendTo($(this));
    } else {
    	$(this).siblings(':first').children(':first-child').clone().appendTo($(this));
    }
  });

  $('.hot-trends-items').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3,
    autoplay: true,
    autoplaySpeed: 2000
  });

  $('.slider-vertical').remove();
  $('#price-slider').slider({});

  $('.product-rate').empty();
  $('.product-rate').raty({
    path: 'https://raw.githubusercontent.com/wbotelhos/raty/master/lib/images/',
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    readOnly: true,
    score: function(){
      return $(this).attr('data-score');
    }
  });

  $('.user-rate-product').empty();
  $('.user-rate-product').raty({
    path: 'https://raw.githubusercontent.com/wbotelhos/raty/master/lib/images/',
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    score: function(){
      return $(this).attr('data-score');
    },
    readOnly: $(this).attr('read-only') == 'true',
    click: function(score, event){
      product_id = $('.user-rate-product').attr('product-id');
      rate_id = $('.user-rate-product').attr('rate-id');
      user_id = $('.user-rate-product').attr('user-id');
      $.ajax({
        method: 'post',
        url: product_id + '/ratings/',
        data: {
          rating: {
            product_id: product_id,
            user_id: user_id,
            point: score
          }
        },
        success: function(){
          $('.user-rate-product').raty('score', score);
          $('.user-rate-product').raty('readOnly', true);
        }
      });
      return false;
    },
  });

  $('.recently-viewed-rating').empty();
  $('.recently-viewed-rating').raty({
    path: 'https://raw.githubusercontent.com/wbotelhos/raty/master/lib/images/',
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    score: function(){
      return $(this).attr('data-score');
    },
    readOnly: true
  });

  $('.admin-rate-product').empty();
  $('.admin-rate-product').raty({
    path: 'https://raw.githubusercontent.com/wbotelhos/raty/master/lib/images/',
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    score: function(){
      return $(this).attr('data-score');
    },
    readOnly: true
  });

  function selectedTab(){
    url = window.location.href
    if (url.split('?tab=')[1] === 'suggested_product_tab'){
      $('a[href="#suggested_product_tab"]').tab('show');
    }
  }
  selectedTab();
});



$(document).on('click', '.number-spinner .btn', {}, function(e){
  currentVal = $(e.currentTarget).parent().parent().find('input').val();
  if($(e.currentTarget).attr('data-dir')=='up'){
    newVal = 1
  }else{
    if (currentVal === '1'){
      return false;
    }
    newVal = -1
  }
  product_id = $(e.currentTarget).attr('product');
  $.ajax({
    method: 'post',
    url: 'carts/',
    data: {
      product_id: product_id,
      quantity: newVal
    }
  });
  return false;
});

$(document).on('click', 'a.btn-remove-product', {}, function(e){
  product_id = $(e.currentTarget).attr('product');
  $.ajax({
    method: 'delete',
    url: '/carts',
    data: {
      product_id: product_id
    },
  });
  return false;
});

$(document).on('click', 'a.btn-add-to-cart', {}, function(e){
  product_id = $(e.currentTarget).attr('product');
  $.ajax({
    method: 'post',
    url: '/carts',
    data: {
      product_id: product_id,
      quantity: 1
    }
  });
  return false;
});
