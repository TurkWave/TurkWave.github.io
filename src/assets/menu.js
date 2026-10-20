// Header menu: the theme and the increased-contrast toggles. The stored choice
// is already applied pre-paint by the inline snippet in _layouts/default.html -
// this file only wires the two buttons and keeps their pressed state (and the
// theme label) in sync. The theme button cycles System -> Light -> Dark; in the
// System state nothing is stored and the palette follows the OS setting.
(function () {
  var root = document.documentElement;
  var KEY_THEME = "tw-theme";
  var KEY_CONTRAST = "tw-contrast";
  var THEMES = ["system", "light", "dark"];
  var THEME_LABELS = { system: "System", light: "Light", dark: "Dark" };

  function store(key, val) {
    try {
      if (val) localStorage.setItem(key, val);
      else localStorage.removeItem(key);
    } catch (e) {}
  }

  // The reader's explicit pick: "light" / "dark" when pinned, else "system".
  function themeChoice() {
    var t = root.getAttribute("data-theme");
    return t === "light" || t === "dark" ? t : "system";
  }
  function applyThemeChoice(choice) {
    if (choice === "light" || choice === "dark") {
      root.setAttribute("data-theme", choice);
      store(KEY_THEME, choice);
    } else {
      root.removeAttribute("data-theme");
      store(KEY_THEME, null);
    }
  }
  function contrastOn() {
    return root.getAttribute("data-contrast") === "more";
  }

  var themeBtn = document.querySelector(".menu-theme");
  var contrastBtn = document.querySelector(".menu-contrast");

  function sync() {
    if (themeBtn) {
      var choice = themeChoice();
      // "pressed" == the reader has overridden the OS setting.
      themeBtn.setAttribute("aria-pressed", choice === "system" ? "false" : "true");
      var label = themeBtn.querySelector(".site-menu__btn-label");
      if (label) label.textContent = THEME_LABELS[choice];
    }
    if (contrastBtn) {
      contrastBtn.setAttribute("aria-pressed", contrastOn() ? "true" : "false");
    }
  }

  if (themeBtn) {
    themeBtn.addEventListener("click", function () {
      var next = THEMES[(THEMES.indexOf(themeChoice()) + 1) % THEMES.length];
      applyThemeChoice(next);
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

  // Dismiss the drawer on a click outside it, or on Escape.
  var drawer = document.querySelector(".site-drawer");
  if (drawer) {
    document.addEventListener("click", function (e) {
      if (drawer.open && !drawer.contains(e.target)) drawer.removeAttribute("open");
    });
    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape" && drawer.open) {
        drawer.removeAttribute("open");
        var toggle = drawer.querySelector(".site-drawer__toggle");
        if (toggle) toggle.focus();
      }
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
