 /* Theme Name: Floaks
   Author: Themesdesign
   Version: 1.0.0
   File Description: Main JS file of the template
*/
 
 // STICKY
$(window).scroll(function() {
    var scroll = $(window).scrollTop();

    if (scroll >= 50) {
        $(".sticky").addClass("nav-sticky");
    } else {
        $(".sticky").removeClass("nav-sticky");
    }
});

// SmoothLink
$('.navbar-nav a').on('click', function(event) {
    var $anchor = $(this);
    $('html, body').stop().animate({
        scrollTop: $($anchor.attr('href')).offset().top - 0
    }, 1500, 'easeInOutExpo');
    event.preventDefault();
});


// scrollspy
$(".navbar-nav").scrollspy({
    offset:20
});

// Swiper
var swiper = new Swiper('.swiper-container', {
    slidesPerView: 1.6,
    spaceBetween: 10,
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },

    breakpoints: {
        576: {
          slidesPerView: 1,
          spaceBetween: 20,
        },
        768: {
          slidesPerView: 1,
          spaceBetween: 40,
        },
        1500: {
          slidesPerView: 1,
          spaceBetween: 50,
        },
      }
});

    // Portfolio filter
    $(window).on('load', function() {
      var $container = $('.portfolioContainer');
      var $filter = $('#filter');
      $container.isotope({
          filter: '*',
          layoutMode: 'masonry',
          animationOptions: {
              duration: 750,
              easing: 'linear'
          }
      });
      $filter.find('a').click(function() {
          var selector = $(this).attr('data-filter');
          $filter.find('a').removeClass('active');
          $(this).addClass('active');
          $container.isotope({
              filter: selector,
              animationOptions: {
                  animationDuration: 750,
                  easing: 'linear',
                  queue: false,
              }
          });
          return false;
      });
  });

   // video
   $('.video-play-icon, .video-play-icon-trigger').magnificPopup({
      disableOn: 700,
      type: 'iframe',
      mainClass: 'mfp-fade',
      removalDelay: 160,
      preloader: false,
      fixedContentPos: false
  });

  // Magnific Popup
  $('.mfp-image').magnificPopup({
      type: 'image',
      closeOnContentClick: true,
      mainClass: 'mfp-fade',
      gallery: {
          enabled: true,
          navigateByImgClick: true,
          preload: [0, 1]
      }
  });

// pricerange
    $("#pricerange1").ionRangeSlider({
        skin: "round",
        min: 0,
        max: 1000,
        from: 200,
        to: 800,
        hide_from_to: false,
        prefix: "$"
    });

    $("#pricerange2").ionRangeSlider({
        skin: "round",
        min: 0,
        max: 1000,
        from: 500,
        to: 800,
        hide_from_to: false,
        prefix: "$"
    });

    $("#pricerange3").ionRangeSlider({
        skin: "round",
        min: 0,
        max: 1000,
        from: 700,
        to: 800,
        hide_from_to: false,
        prefix: "$"
    });
    $("#pricerange4").ionRangeSlider({
        skin: "round",
        min: 0,
        max: 1000,
        from: 200,
        to: 800,
        hide_from_to: false,
        prefix: "$"
    });

    $("#pricerange5").ionRangeSlider({
        skin: "round",
        min: 0,
        max: 1000,
        from: 500,
        to: 800,
        hide_from_to: false,
        prefix: "$"
    });

    $("#pricerange6").ionRangeSlider({
        skin: "round",
        min: 0,
        max: 1000,
        from: 700,
        to: 800,
        hide_from_to: false,
        prefix: "$"
    });

    // video
$(".player").mb_YTPlayer();

// typed
$(".element").each(function(){
    var $this = $(this);
    $this.typed({
        strings: $this.attr('data-elements').split(','),
        typeSpeed: 100, // typing speed
        backDelay: 3000 // pause before backspacing
    });
});


$('.main-slider').flexslider({
    slideshowSpeed: 5000,
    directionNav: false,
    controlNav: true,
    autoplay: true,
    animation: "fade"
});