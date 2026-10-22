// App-index media strip: click-hold-drag-to-pan with a free-coasting fling on
// release, click-to-load for YouTube video items, and click-a-screenshot (or
// the app icon) to open it in a blurred-backdrop lightbox (Esc / click /
// browser Back to close - the lightbox takes its own history entry, so Back
// closes it before leaving the page). Inside the lightbox the image zooms:
// click / double-tap toggles 1x <-> 2.5x, the mouse wheel zooms toward the
// cursor, two-finger pinch zooms on touch, and while zoomed you drag to pan.
// The strip pans without snap points or a speed cap. The mouse wheel is left
// alone on the strip - vertical wheeling scrolls the page. The FAQ card strip
// gets its own click-hold-drag that eases to the nearest card. No other JS on
// the site.
(function () {
  var strip = document.querySelector(".app-shots__strip");

  var glide = 0;
  function stopGlide() {
    if (glide) { cancelAnimationFrame(glide); glide = 0; }
  }

  // Drag state - shared so the strip's own click handler can tell a pan from
  // a tap. `dragged` is per-gesture: cleared on pointerdown, raised once the
  // pointer moves past the tap threshold, and consumed by the click handler.
  var dragging = false, startX = 0, startLeft = 0, dragged = false;
  var vx = 0, lastX = 0, lastT = 0;

  // --- enlarge an image (screenshot or app icon) over a blurred backdrop ---
  var box = null, lastFocus = null, historyPushed = false;

  function closeLightbox(fromPopstate) {
    if (!box) return;
    document.removeEventListener("keydown", onLightboxKey);
    window.removeEventListener("popstate", onPopstate);
    box.remove();
    box = null;
    document.body.style.overflow = "";
    if (lastFocus && lastFocus.focus) lastFocus.focus();
    // Undo the history entry the open pushed, so a later Back leaves the page -
    // unless Back is what closed us, in which case that entry is already gone.
    if (historyPushed && !fromPopstate) history.back();
    historyPushed = false;
  }

  function onLightboxKey(e) {
    if (e.key === "Escape" || e.key === "Esc") closeLightbox();
  }

  // Back button: pop our pushed entry, close the lightbox, stay on the page.
  function onPopstate() { closeLightbox(true); }

  function openLightbox(img) {
    if (box) return;
    lastFocus = document.activeElement;

    box = document.createElement("div");
    box.className = "shot-lightbox";
    box.setAttribute("role", "dialog");
    box.setAttribute("aria-modal", "true");
    box.setAttribute("aria-label", img.alt || "Screenshot");

    var big = document.createElement("img");
    big.className = "shot-lightbox__img";
    big.src = img.currentSrc || img.src;
    big.alt = img.alt || "";
    big.draggable = false;

    var close = document.createElement("button");
    close.type = "button";
    close.className = "shot-lightbox__close";
    close.setAttribute("aria-label", "Close");
    close.innerHTML = "×";

    box.appendChild(big);
    box.appendChild(close);

    // --- zoom + pan, scoped to this lightbox instance -------------------------
    // `scale`/`tx`/`ty` drive a single CSS transform on the image. Zooming
    // toward a point keeps that point under the cursor; panning is only live
    // while zoomed in. `moved` lets the click handler tell a pan / pinch from
    // a plain tap, so a drag never toggles the zoom or closes the box.
    var scale = 1, tx = 0, ty = 0;
    var MIN = 1, MAX = 6;
    var pointers = new Map();
    var pinchDist = 0, pinchScale = 1, moved = false;
    var panBaseX = 0, panBaseY = 0, panDownX = 0, panDownY = 0;

    function apply() {
      big.style.transform =
        "translate(" + tx + "px," + ty + "px) scale(" + scale + ")";
      big.classList.toggle("is-zoomed", scale > MIN + 0.001);
    }
    function clampPan() {
      var w = big.clientWidth, h = big.clientHeight;
      var maxX = Math.max(0, (w * scale - Math.min(w * scale, box.clientWidth)) / 2 + 24);
      var maxY = Math.max(0, (h * scale - Math.min(h * scale, box.clientHeight)) / 2 + 24);
      tx = Math.min(maxX, Math.max(-maxX, tx));
      ty = Math.min(maxY, Math.max(-maxY, ty));
    }
    function setScale(next, cx, cy) {
      next = Math.min(MAX, Math.max(MIN, next));
      var rect = big.getBoundingClientRect();
      var ox = rect.left + rect.width / 2;
      var oy = rect.top + rect.height / 2;
      var k = next / scale;
      tx -= (cx - ox) * (k - 1);
      ty -= (cy - oy) * (k - 1);
      scale = next;
      if (scale <= MIN + 0.001) { scale = MIN; tx = 0; ty = 0; }
      clampPan();
      apply();
    }

    big.addEventListener("wheel", function (e) {
      e.preventDefault();
      setScale(scale * (e.deltaY < 0 ? 1.2 : 1 / 1.2), e.clientX, e.clientY);
    }, { passive: false });

    big.addEventListener("click", function (e) {
      e.stopPropagation(); // a tap on the image must never reach the backdrop
      if (moved) { moved = false; return; }
      if (scale > MIN) setScale(MIN, e.clientX, e.clientY);
      else setScale(2.5, e.clientX, e.clientY);
    });

    big.addEventListener("pointerdown", function (e) {
      try { big.setPointerCapture(e.pointerId); } catch (err) {}
      pointers.set(e.pointerId, { x: e.clientX, y: e.clientY });
      // Only enter the drag cursor / no-transition mode when there is
      // something to move: already zoomed in, or a pinch is starting.
      if (scale > MIN + 0.001 || pointers.size === 2) big.classList.add("is-panning");
      if (pointers.size === 2) {
        var p = Array.from(pointers.values());
        pinchDist = Math.hypot(p[0].x - p[1].x, p[0].y - p[1].y);
        pinchScale = scale;
      } else {
        moved = false;
        panDownX = e.clientX; panDownY = e.clientY;
        panBaseX = tx; panBaseY = ty;
      }
    });

    big.addEventListener("pointermove", function (e) {
      if (!pointers.has(e.pointerId)) return;
      pointers.set(e.pointerId, { x: e.clientX, y: e.clientY });
      var p = Array.from(pointers.values());
      if (p.length === 2) {
        var dist = Math.hypot(p[0].x - p[1].x, p[0].y - p[1].y);
        if (pinchDist > 0) {
          setScale(pinchScale * (dist / pinchDist),
                   (p[0].x + p[1].x) / 2, (p[0].y + p[1].y) / 2);
          moved = true;
        }
      } else if (p.length === 1 && scale > MIN) {
        var dx = e.clientX - panDownX, dy = e.clientY - panDownY;
        if (Math.abs(dx) + Math.abs(dy) > 4) moved = true;
        tx = panBaseX + dx; ty = panBaseY + dy;
        clampPan();
        apply();
      }
    });

    function endPointer(e) {
      pointers.delete(e.pointerId);
      try { big.releasePointerCapture(e.pointerId); } catch (err) {}
      if (pointers.size < 2) pinchDist = 0;
      // Dropping from a pinch to one finger: re-seat the pan baseline on the
      // finger that stays down so the next drag doesn't jump.
      if (pointers.size === 1) {
        var last = Array.from(pointers.values())[0];
        panDownX = last.x; panDownY = last.y;
        panBaseX = tx; panBaseY = ty;
        moved = true; // this gesture already zoomed - don't let it toggle
      }
      if (pointers.size === 0) big.classList.remove("is-panning");
    }
    big.addEventListener("pointerup", endPointer);
    big.addEventListener("pointercancel", endPointer);

    box.addEventListener("click", function (e) {
      if (e.target !== big) closeLightbox(); // backdrop or close button
    });

    document.body.appendChild(box);
    document.body.style.overflow = "hidden";
    document.addEventListener("keydown", onLightboxKey);
    // Add a history entry so the browser Back button closes this view first
    // and only then navigates away from the page.
    try {
      history.pushState({ shotLightbox: true }, "");
      historyPushed = true;
      window.addEventListener("popstate", onPopstate);
    } catch (err) {
      historyPushed = false;
    }
    close.focus();
  }

  // The app icon enlarges the same way a screenshot does.
  var heroLogo = document.querySelector(".app-hero__logo");
  if (heroLogo) {
    heroLogo.addEventListener("click", function () { openLightbox(heroLogo); });
  }

  // --- FAQ cards: one card per view; mouse users click-hold-drag, then the
  // strip eases to the nearest card (a flick moves one card). Touch scrolls and
  // snaps natively. Snapping is off while dragging, or it fights scrollLeft. ---
  var faq = document.querySelector(".app-faq__strip");
  if (faq) {
    var fDown = false, fMoved = false, fStartX = 0, fStartLeft = 0;
    var fVx = 0, fLastX = 0, fLastT = 0, fStartIdx = 0;

    // Cards snap by their centre, so compare centres, not left edges.
    function centerX(el) {
      var r = el.getBoundingClientRect();
      return r.left + r.width / 2;
    }
    function nearestFaqCard(cards, center) {
      var best = 0, bestDist = Infinity;
      for (var i = 0; i < cards.length; i++) {
        var d = Math.abs(centerX(cards[i]) - center);
        if (d < bestDist) { bestDist = d; best = i; }
      }
      return best;
    }

    faq.addEventListener("pointerdown", function (e) {
      if (e.pointerType === "touch" || e.button !== 0) return;
      fDown = true;
      fStartIdx = nearestFaqCard(faq.querySelectorAll(".app-faq__card"), centerX(faq));
      fMoved = false;
      fVx = 0;
      fStartX = fLastX = e.clientX;
      fStartLeft = faq.scrollLeft;
      fLastT = e.timeStamp;
      faq.classList.add("is-dragging");
    });

    window.addEventListener("pointermove", function (e) {
      if (!fDown) return;
      var dx = e.clientX - fStartX;
      if (Math.abs(dx) > 6) fMoved = true;
      var dt = e.timeStamp - fLastT;
      if (dt > 0) fVx = (e.clientX - fLastX) / dt;
      fLastX = e.clientX;
      fLastT = e.timeStamp;
      faq.scrollLeft = fStartLeft - dx;
    });

    function faqRelease() {
      if (!fDown) return;
      fDown = false;
      var cards = faq.querySelectorAll(".app-faq__card");
      var center = centerX(faq);
      var best = nearestFaqCard(cards, center);
      // A quick flick advances one card even if the drag was short - but only
      // when the drag still lands on the card it started from.
      if (best === fStartIdx && Math.abs(fVx) > 0.4) {
        best = Math.max(0, Math.min(cards.length - 1, best + (fVx < 0 ? 1 : -1)));
      }
      if (cards[best]) {
        faq.scrollTo({
          left: faq.scrollLeft + centerX(cards[best]) - center,
          behavior: "smooth"
        });
      }
      setTimeout(function () { faq.classList.remove("is-dragging"); }, 400);
    }
    window.addEventListener("pointerup", faqRelease);
    window.addEventListener("pointercancel", faqRelease);

    // A drag ends with a synthetic click on the <summary>: swallow it so the
    // card doesn't open/close after a pan.
    faq.addEventListener("click", function (e) {
      if (fMoved) { fMoved = false; e.preventDefault(); }
    });
  }

  if (!strip) return;

  // --- screenshot frames: 9:16 by default, 16:9 for landscape images. The
  // orientation is only known once the image has loaded, so it is set then. ---
  function frameScreenshot(img) {
    if (!img.naturalWidth) return;
    img.parentNode.classList.toggle("app-shots__item--wide", img.naturalWidth > img.naturalHeight);
  }
  Array.prototype.forEach.call(strip.querySelectorAll(".app-shots__item > img"), function (img) {
    if (img.complete) frameScreenshot(img);
    img.addEventListener("load", function () { frameScreenshot(img); });
  });

  // --- click, hold and drag to pan (mouse / pen; touch scrolls natively) ---
  strip.addEventListener("pointerdown", function (e) {
    if (e.pointerType === "touch" || e.button !== 0) return;
    stopGlide();
    dragging = true;
    dragged = false;
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
    if (Math.abs(dx) > 6) dragged = true; // past the tap threshold: it's a pan
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

  // One click handler for the whole strip. A drag ends with a synthetic click:
  // swallow it and clear the flag, so a later keyboard activation (Enter on a
  // focused item, which fires no pointerdown) is never suppressed. Otherwise a
  // YouTube facade swaps in the real player, and a screenshot opens in the
  // lightbox. No capture phase and no stopPropagation needed - preventDefault
  // alone cancels the facade's link, and nothing else on the page listens for
  // clicks.
  strip.addEventListener("click", function (e) {
    if (dragged) { dragged = false; e.preventDefault(); return; }

    var facade = e.target.closest && e.target.closest(".yt-facade");
    if (facade) {
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
      return;
    }

    var t = e.target;
    if (t.tagName === "IMG" && t.parentNode.classList.contains("app-shots__item")) {
      openLightbox(t);
    }
  });
})();
