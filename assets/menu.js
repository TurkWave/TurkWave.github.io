// Header menu: the light/dark theme and the increased-contrast toggles. The
// stored choice is already applied pre-paint by the inline snippet in
// _layouts/default.html - this file only wires the two buttons and keeps their
// pressed state (and the theme label) in sync. With nothing stored, both fall
// back to the OS setting.
(function () {
  var root = document.documentElement;
  var KEY_THEME = "tw-theme";
  var KEY_CONTRAST = "tw-contrast";

  function store(key, val) {
    try {
      if (val) localStorage.setItem(key, val);
      else localStorage.removeItem(key);
    } catch (e) {}
  }

  function systemDark() {
    return !!(window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches);
  }
  function activeTheme() {
    return root.getAttribute("data-theme") || (systemDark() ? "dark" : "light");
  }
  function contrastOn() {
    return root.getAttribute("data-contrast") === "more";
  }

  var themeBtn = document.querySelector(".menu-theme");
  var contrastBtn = document.querySelector(".menu-contrast");

  function sync() {
    if (themeBtn) {
      var dark = activeTheme() === "dark";
      themeBtn.setAttribute("aria-pressed", dark ? "true" : "false");
      var label = themeBtn.querySelector(".site-menu__btn-label");
      if (label) label.textContent = dark ? "Dark" : "Light";
    }
    if (contrastBtn) {
      contrastBtn.setAttribute("aria-pressed", contrastOn() ? "true" : "false");
    }
  }

  if (themeBtn) {
    themeBtn.addEventListener("click", function () {
      var next = activeTheme() === "dark" ? "light" : "dark";
      root.setAttribute("data-theme", next);
      store(KEY_THEME, next);
      sync();
    });
  }

  if (contrastBtn) {
    contrastBtn.addEventListener("click", function () {
      if (contrastOn()) {
        root.removeAttribute("data-contrast");
        store(KEY_CONTRAST, null);
      } else {
        root.setAttribute("data-contrast", "more");
        store(KEY_CONTRAST, "more");
      }
      sync();
    });
  }

  // Track the OS palette while the reader hasn't pinned a theme.
  if (window.matchMedia) {
    try {
      window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change", function () {
        if (!root.getAttribute("data-theme")) sync();
      });
    } catch (e) {}
  }

  sync();
})();
