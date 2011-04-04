$(document).ready(function(){
  function setupDrawing() {
    
    var drawingElem = document.getElementById('drawing');
    if (!drawingElem) return;

    var scale = 3;
    var canvasLength = 128;
    var width = scale*canvasLength;
    var height = scale*canvasLength;

    var brushSize = 1;
    var brushCol = "rgb(0,0,0)";

    $(drawingElem).attr('width', width).attr('height', height);
    var context = drawingElem.getContext('2d');
    context.drawImage(drawingElem, 0, 0, canvasLength, canvasLength, 0, 0, width, height);

    function drawBrush(targetContext, data, tx, ty) {
      tx = Math.floor(tx);
      ty = Math.floor(ty);
      //console.log(tx, ty);
      var w = 8, h = 8;
      for (var y = 0; y < h; ++y) {
        for (var x = 0; x < w; ++x) {
          if (data[y*w + x] === 1) {
            targetContext.fillRect(tx*scale + x*scale - 15, ty*scale + y*scale - 15, scale, scale);
          }
        }
      }
    }

    var pixelBrush = context.createImageData(1, 1);

    var pixelBrush = [
      0,0,0,0,0,0,0,0,
      0,0,0,0,0,0,0,0,
      0,0,0,0,0,0,0,0,
      0,0,0,1,0,0,0,0,
      0,0,0,0,0,0,0,0,
      0,0,0,0,0,0,0,0,
      0,0,0,0,0,0,0,0,
      0,0,0,0,0,0,0,0,
    ];

    var circleBrush = [
      0,0,0,0,0,0,0,0,
      0,0,0,0,0,0,0,0,
      0,0,0,1,1,0,0,0,
      0,0,1,1,1,1,0,0,
      0,0,1,1,1,1,0,0,
      0,0,0,1,1,0,0,0,
      0,0,0,0,0,0,0,0,
      0,0,0,0,0,0,0,0,
    ];

    var largeCircleBrush = [
      0,0,0,1,1,0,0,0,
      0,1,1,1,1,1,1,0,
      0,1,1,1,1,1,1,0,
      1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,
      0,1,1,1,1,1,1,0,
      0,1,1,1,1,1,1,0,
      0,0,0,1,1,0,0,0,
    ];

    var largeSquareBrush = [
      1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,
    ];

    var brush = pixelBrush;
    var down = false;
    var lastX = null;
    var lastY = null;

    function setLastPos(event) {
      lastX = Math.floor(event.offsetX / scale);
      lastY = Math.floor(event.offsetY / scale);
    }

    function draw(event) {
      if (down) {
        var x = Math.floor(event.offsetX / scale);
        var y = Math.floor(event.offsetY / scale);
        if (x >= canvasLength) x = canvasLength - 1;
        if (y >= canvasLength) y = canvasLength - 1;
        if (lastX === null)
          lastX = x;
        if (lastY === null)
          lastY = y;
        context.fillStyle = brushCol;
        bresenham(lastX, lastY, x, y, function(i, j) { drawBrush(context, brush, i, j); });
        lastX = x;
        lastY = y;
      }
    }
    $(drawingElem).mousedown(function(event){
      console.log('mouse down', event);
      down = true;
      setLastPos(event);
      draw(event);
      return false;
    }).mouseup(function(event){
      //console.log('mouse up', event);
      down = false;
    }).mouseenter(function(event){
      //console.log('mouse enter', event);
      setLastPos(event);
      draw(event);
    }).mouseleave(function(event){
      //console.log('mouse leave', event);
      draw(event);
    }).mousemove(function(event){
      //console.log('mouse move', event);
      draw(event);
    });

    $('button.pixel').click(function(){
      brush = pixelBrush;
    });
    $('button.black').click(function(){
      brushCol = "black";
    });
    $('button.white').click(function(){
      brushCol = "white";
    });
    $('button.circle.small').click(function(){
      brush = circleBrush;
    });
    $('button.circle.large').click(function(){
      brush = largeCircleBrush;
    });
    $('button.square.large').click(function(){
      brush = largeSquareBrush;
    });
    $('button.black.clear').click(function(){
      context.fillStyle = "black";
      context.fillRect(0, 0, width, height);
    });
    $('button.white.clear').click(function(){
      context.fillStyle = "white";
      context.fillRect(0, 0, width, height);
    });

    $('button').html("<canvas width="+8*scale+" height="+8*scale+"></canvas>");
    var c = $('button.black.circle.small canvas')[0].getContext('2d');
    c.fillStyle = "#000000";
    console.log(c.fillStyle);
    drawBrush(c, circleBrush, 0, 0);
    //c.fillRect(0, 0, 8, 8);
  }

  setupDrawing();

  function bresenham(x0, y0, x1, y1, callback) {
    var t;
    var steep = Math.abs(y1 - y0) > Math.abs(x1 - x0);
    if (steep) {
      x0 ^= y0; y0 ^= x0; x0 ^= y0; // swap x0 and y0
      x1 ^= y1; y1 ^= x1; x1 ^= y1; // swap x1 and y1
    }
    if (x0 > x1) {
      x0 ^= x1; x1 ^= x0; x0 ^= x1; // swap x0 and x1
      y0 ^= y1; y1 ^= y0; y0 ^= y1; // swap y0 and y1
    }
    var dx = x1 - x0;
    var dy = Math.abs(y1 - y0);
    var error = -(dx + 1) / 2;
    var yi;
    if (y0 < y1) {
      yi = 1;
    } else {
      yi = -1;
    }
    for (; x0 <= x1; x0++) {
      if (steep) {
        callback(y0, x0);
      } else {
        callback(x0, y0);
      }
      error += dy;
      if (error >= 0) {
        y0 += yi;
        error -= dx;
      }
    }
  }
});
