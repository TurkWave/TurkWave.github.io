// App-index media strip: mouse-wheel-to-scroll, click-hold-drag-to-pan with a
// free-coasting fling on release, and click-to-load for YouTube video items.
// The strip pans without snap points or a speed cap. No other JS on the site.
(function () {
  var strip = document.querySelector(".app-shots__strip");
  if (!strip) return;

  var glide = 0;
  function stopGlide() {
    if (glide) { cancelAnimationFrame(glide); glide = 0; }
  }

  // --- vertical mouse wheel scrolls the strip horizontally -----------------
  strip.addEventListener(
    "wheel",
    function (e) {
      if (Math.abs(e.deltaY) <= Math.abs(e.deltaX)) return; // real horizontal scroll: leave it
      var max = strip.scrollWidth - strip.clientWidth;
      if (max <= 0) return;
      // At an edge and pushing further out -> hand back to the page.
      if ((strip.scrollLeft <= 0 && e.deltaY < 0) || (strip.scrollLeft >= max && e.deltaY > 0)) return;
      stopGlide();
      strip.scrollLeft += e.deltaY;
      e.preventDefault();
    },
    { passive: false }
  );

  // --- click, hold and drag to pan (mouse / pen; touch scrolls natively) ---
  var dragging = false, startX = 0, startLeft = 0, moved = 0;
  var vx = 0, lastX = 0, lastT = 0;

  strip.addEventListener("pointerdown", function (e) {
    if (e.pointerType === "touch" || e.button !== 0) return;
    stopGlide();
    dragging = true;
    moved = 0;
    vx = 0;
    startX = lastX = e.clientX;
    startLeft = strip.scrollLeft;
    lastT = e.timeStamp;
    strip.classList.add("is-dragging");
    e.preventDefault(); // suppress native image drag + text selection
  });

  window.addEventListener("pointermove", function (e) {
    if (!dragging) return;
    var dx = e.clientX - startX;
    if (Math.abs(dx) > moved) moved = Math.abs(dx);
    var dt = e.timeStamp - lastT;
    if (dt > 0) vx = (e.clientX - lastX) / dt; // px per ms, last sample wins
    lastX = e.clientX;
    lastT = e.timeStamp;
    strip.scrollLeft = startLeft - dx; // 1:1 with the cursor, unclamped
  });

  function release() {
    if (!dragging) return;
    dragging = false;
    strip.classList.remove("is-dragging");
    var v = vx * 15; // hand-off velocity, ~px per frame
    if (Math.abs(v) < 0.6) return; // a plain click / slow release: no fling
    (function step() {
      strip.scrollLeft -= v;
      v *= 0.94; // gentle decay, coasts to a stop
      glide = Math.abs(v) > 0.15 ? requestAnimationFrame(step) : 0;
    })();
  }
  window.addEventListener("pointerup", release);
  window.addEventListener("pointercancel", release);
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
    stopGlide();
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
