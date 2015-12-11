$(function() {
  cWidth = $('body').width();
  liWidth = cWidth * 0.25;
  $("#weatherPro li").css("width", liWidth);
  allLiWidth = $("#weatherPro li").width() * gon.weather_info.length;
  $("#weatherPro").css("width", allLiWidth);
  var BLOCK_WIDTH = cWidth;
  var currentBlock = 0;
  var maxBlocks = 2;
  var speed = 400;

  var imgs;

  var swipeOptions = {
    triggerOnTouchEnd: true,
    swipeStatus: swipeStatus,
    allowPageScroll: "vertical",
    threshold: 75
  };

  $(function () {
    imgs = $("#weatherPro");
    imgs.swipe(swipeOptions);
  });
  function swipeStatus(event, phase, direction, distance) {
    //If we are moving before swipe, and we are going L or R in X mode, or U or D in Y mode then drag.
    if (phase == "move" && (direction == "left" || direction == "right")) {
        var duration = 0;

        if (direction == "left") {
            scrollImages((BLOCK_WIDTH * currentBlock) + distance, duration);
        } else if (direction == "right") {
            scrollImages((BLOCK_WIDTH * currentBlock) - distance, duration);
        }

    } else if (phase == "cancel") {
        scrollImages(BLOCK_WIDTH * currentBlock, speed);
    } else if (phase == "end") {
        if (direction == "right") {
            previousImage();
        } else if (direction == "left") {
            nextImage();
        }
    }
  }
  function previousImage() {
    currentBlock = Math.max(currentBlock - 1, 0);
    scrollImages(BLOCK_WIDTH * currentBlock, speed);
  }

  function nextImage() {
    currentBlock = Math.min(currentBlock + 1, maxBlocks - 1);
    scrollImages(BLOCK_WIDTH * currentBlock, speed);
  }
  function scrollImages(distance, duration) {
    imgs.css("transition-duration", (duration / 1000).toFixed(1) + "s");

    //inverse the number we set in the css
    var value = (distance < 0 ? "" : "-") + Math.abs(distance).toString();
    imgs.css("transform", "translate(" + value + "px,0)");
  }
});