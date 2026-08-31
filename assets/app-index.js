// App-index screenshots strip: let a plain vertical mouse wheel scroll it
// horizontally. Everything else (touch, trackpad, Shift+wheel, arrow keys)
// already works without this. The site ships no other JavaScript.
(function () {
  var strip = document.querySelector(".app-shots__strip");
  if (!strip) return;
  strip.addEventListener(
    "wheel",
    function (e) {
      if (Math.abs(e.deltaY) <= Math.abs(e.deltaX)) return; // let real horizontal scroll pass
      var max = strip.scrollWidth - strip.clientWidth;
      if (max <= 0) return;
      // At an edge and pushing further out -> let the page scroll instead.
      if ((strip.scrollLeft <= 0 && e.deltaY < 0) || (strip.scrollLeft >= max && e.deltaY > 0)) return;
      strip.scrollLeft += e.deltaY;
      e.preventDefault();
    },
    { passive: false }
  );
})();
