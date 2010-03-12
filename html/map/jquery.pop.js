//
//  pop! for jQuery
//  v0.2 requires jQuery v1.2 or later
//
//  Licensed under the MIT:
//  http://www.opensource.org/licenses/mit-license.php
//
//  Copyright 2007,2008 SEAOFCLOUDS [http://seaofclouds.com]
//

(function($) {

  $.pop = function(options){

    // inject html wrapper
    function initpops (){
      $(".pop").each(function() {
        var pop_classes = $(this).attr("class");
        $(this).addClass("pop_menu");
        $(this).wrap("<div class='"+pop_classes+"'></div>");
        $(".pop_menu").attr("class", "pop_menu");
        $(this).before(" <div class='pop_toggle'></div> ");
      });
    }
    initpops();

    // assign reverse z-indexes to each pop
    var totalpops = $(".pop").size() + 1000;
    $(".pop").each(function(i) {
     var popzindex = totalpops - i;
     $(this).css({ zIndex: popzindex });
    });
    // close pops if user clicks outside of pop
    activePop = null;
    function closeInactivePop() {
      $(".pop").each(function (i) {
        if ($(this).hasClass('active') && i!=activePop) {
          $(this).removeClass('active');
          }
      });
      return false;
    }
    $(".pop").mouseover(function() { activePop = $(".pop").index(this); });
    $(".pop").mouseout(function() { activePop = null; });

    $(document.body).click(function(){
     closeInactivePop();
    });
    // toggle that pop
    $(".pop_toggle").click(function(){
      $(this).parent(".pop").toggleClass("active");
    });
  }

})(jQuery);