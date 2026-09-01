// App-index media strip: mouse-wheel-to-scroll, click-hold-drag-to-pan on
// desktop, and click-to-load for YouTube video items. The site ships no
// other JavaScript.
(function () {
  var strip = document.querySelector(".app-shots__strip");
  if (!strip) return;

  // --- vertical mouse wheel scrolls the strip horizontally -----------------
  strip.addEventListener(
    "wheel",
    function (e) {
      if (Math.abs(e.deltaY) <= Math.abs(e.deltaX)) return; // real horizontal scroll: leave it
      var max = strip.scrollWidth - strip.clientWidth;
      if (max <= 0) return;
      // At an edge and pushing further out -> let the page scroll instead.
      if ((strip.scrollLeft <= 0 && e.deltaY < 0) || (strip.scrollLeft >= max && e.deltaY > 0)) return;
      strip.scrollLeft += e.deltaY;
      e.preventDefault();
    },
    { passive: false }
  );

  // --- click, hold and drag to pan (mouse / pen; touch scrolls natively) ---
  var dragging = false, startX = 0, startLeft = 0, moved = 0;

  strip.addEventListener("pointerdown", function (e) {
    if (e.pointerType === "touch" || e.button !== 0) return;
    dragging = true;
    moved = 0;
    startX = e.clientX;
    startLeft = strip.scrollLeft;
    strip.classList.add("is-dragging");
    e.preventDefault(); // suppress native image drag + text selection
  });

  window.addEventListener("pointermove", function (e) {
    if (!dragging) return;
    var dx = e.clientX - startX;
    if (Math.abs(dx) > moved) moved = Math.abs(dx);
    strip.scrollLeft = startLeft - dx;
  });

  function endDrag() {
    if (!dragging) return;
    dragging = false;
    strip.classList.remove("is-dragging");
  }
  window.addEventListener("pointerup", endDrag);
  window.addEventListener("pointercancel", endDrag);
  strip.addEventListener("dragstart", function (e) { e.preventDefault(); });

  // A real drag ends with a click - swallow it (capture phase) so a video
  // facade or link under the cursor does not fire.
  strip.addEventListener(
    "click",
    function (e) {
      if (moved > 6) { e.preventDefault(); e.stopPropagation(); }
    },
    true
  );

  // --- YouTube facade: swap the poster for the real player on click --------
  strip.addEventListener("click", function (e) {
    var facade = e.target.closest && e.target.closest(".yt-facade");
    if (!facade) return;
    e.preventDefault();
    var id = facade.getAttribute("data-yt");
    if (!id) return;
    var frame = document.createElement("iframe");
    frame.src =
      "https://www.youtube-nocookie.com/embed/" + encodeURIComponent(id) + "?autoplay=1&rel=0";
    frame.title = facade.getAttribute("data-title") || "YouTube video";
    frame.allow = "autoplay; encrypted-media; picture-in-picture; fullscreen";
    frame.setAttribute("allowfullscreen", "");
    frame.referrerPolicy = "strict-origin-when-cross-origin";
    var item = facade.closest(".app-shots__item");
    if (item) item.classList.add("is-playing");
    facade.replaceWith(frame);
  });
})();
