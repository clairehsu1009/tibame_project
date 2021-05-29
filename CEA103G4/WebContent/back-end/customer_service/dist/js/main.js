$(document).ready(function () {
  "use strict";


  /*****************************************
  **:::::TABLE OF INDEX::::::::::
  *---------------------------------------
  *1::PRELOADER
  *2::SEARCHBAR
  *3::PERFECT SCROLLBAR
  *4::INFORMATION PANEL
  *5::MFB
  *6::RESPONSIVE
  *7::CHATAPP LIST
  ******************************************/

    /*--------------------------------------------------------------
    1::PRELOADER START
    --------------------------------------------------------------*/
    function hideLoader() {
      $('.preloader').hide();
    }
    
    $(window).ready(hideLoader);
    
    // Strongly recommended: Hide loader after 20 seconds, even if the page hasn't finished loading
    setTimeout(hideLoader, 20 * 1000);
  
    /*--------------------------------------------------------------
    PRELOADER START
    --------------------------------------------------------------*/
    /*--------------------------------------------------------------
    2::SEARCHBAR START
    --------------------------------------------------------------*/
    var sp = document.querySelector('.iconbox-search');
    var searchbar = document.querySelector('.iconbox-searchbar');
    var shclose = document.querySelector('.search-close');
  
    function changeClass() {
      searchbar.classList.add('search-visible');
    }
  
    function closesearch() {
      searchbar.classList.remove('search-visible');
    }
    sp.addEventListener('click', changeClass);
    shclose.addEventListener('click', closesearch);
    
    /*--------------------------------------------------------------
    SEARCHBAR END
    --------------------------------------------------------------*/

    /*--------------------------------------------------------------
    3::PERFECT SCROLLBAR START
    --------------------------------------------------------------*/
    var selectors = ['.custom-scrollbar', '.custom-scrollbar2'];
    selectors.forEach(function (selector) {
      $(selector).each(function () {
        const ps = new PerfectScrollbar($(this)[0], {
          suppressScrollX: true,
          wheelPropagation :false,
          wheelSpeed: 2,
          minScrollbarLength: 20
        });
        ps.isRtl = false;
        ps.update();
      });
    });
    /*--------------------------------------------------------------
    PERFECT SCROLLBAR END
    --------------------------------------------------------------*/
    /*--------------------------------------------------------------
    4::INFORMATION PANEL START
    --------------------------------------------------------------*/
    $(".info-panel-opener").click(function () {
      $("body").addClass("info-panel-opened");
      $(".backdrop-overlay").removeClass("hidden");
      $('.slick-slider').slick({
        infinite: false,
        slidesToShow: 5,
        slidesToScroll: 3,
        arrows:false
      });
    });
    $(".information-panel__closer").click(function () {
      $("body").removeClass("info-panel-opened");
      $(".backdrop-overlay").addClass("hidden");
    });
    /*--------------------------------------------------------------
    INFORMATION PANEL END
    --------------------------------------------------------------*/
    /*--------------------------------------------------------------
    5::MFB EVENT START
    --------------------------------------------------------------*/
    $(function () {

      var $win = $(window); // or $box parent container
      var $box = $("#mfbMenu");

      $win.on("click.Bst", function (event) {
        if (
          $box.has(event.target).length == 0 //checks if descendants of $box was clicked
          &&
          !$box.is(event.target) //checks if the $box itself was clicked
        ) {
          $("#mfbMenu").attr('data-mfb-state', "close")
        }
      });

    });
    /*--------------------------------------------------------------
    MFB EVENT END
    --------------------------------------------------------------*/
    /*--------------------------------------------------------------
    6::RESPONSIVE START
    --------------------------------------------------------------*/
   
    $(".nav-item-moreoptions").on('click', function () {
      $(".sidebar-bottom-nav").toggleClass("d-block")
    });

    $(function () {
      var $window = $(window),
        $body = $('body');
  
      function resize() {
        if ($window.width() < 992) {
          $(".chatapp-user-list-body ul li, .settings-nav-menu a").removeClass("active");

          $(".conversation").on('click', function () {
            $(".chatapp__conversations").addClass("open");
          });
           $(".calllist").on('click', function () {
            $(".ca-content__callswrapper").addClass("open");
          });
          $(".contactlist").on('click', function () {
            $(".contactist-profile-wrapper").addClass("open");
          });
          $(".settings-nav-menu").on('click', function () {
            $(".settings-nav-content").addClass("open");
          });

          $(".back-button-md").on('click', function () {
            $(".chatapp__conversations, .ca-content__callswrapper, .contactist-profile-wrapper, .settings-nav-content").removeClass("open");
            $(".chatapp-user-list-body ul li, .settings-nav-menu a").removeClass("active");
          });
          return $body.addClass('small-devices');
        }
      }
  
      $window
        .resize(resize)
        .trigger('resize');
    })
    /*--------------------------------------------------------------
    RESPONSIVE END
    --------------------------------------------------------------*/
    /*--------------------------------------------------------------
    7::CHATAPP LIST JQUERY START
    --------------------------------------------------------------*/
    $(".chatapp-user-list-body ul li").on('click', function () {
      $('.chatapp-user-list-body ul li.active').removeClass('active');
      $(this).addClass('active');
    });
    /*--------------------------------------------------------------
    CHATAPP LIST JQUERY END
    --------------------------------------------------------------*/
    

  
});     

