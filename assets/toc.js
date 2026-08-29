(function () {
  var toc = document.getElementById('doc-toc');
  var content = document.getElementById('doc-content');
  if (!toc || !content) return;
  var list = toc.querySelector('ul');
  var headings = [].slice.call(content.querySelectorAll('h2, h3'));
  if (!headings.length) { toc.parentNode.removeChild(toc); return; }

  var links = headings.map(function (h, i) {
    if (!h.id) {
      h.id = (h.textContent || '').toLowerCase().replace(/[^\w\s-]/g, '')
        .trim().replace(/\s+/g, '-') || 'section-' + i;
    }
    var li = document.createElement('li');
    if (h.tagName === 'H3') li.className = 'toc-sub';
    var a = document.createElement('a');
    a.href = '#' + h.id;
    a.textContent = h.textContent;
    li.appendChild(a);
    list.appendChild(li);
    return a;
  });
  toc.classList.add('is-ready');

  function spy() {
    var mark = window.scrollY + 130;
    var id = headings[0].id;
    for (var i = 0; i < headings.length; i++) {
      if (headings[i].getBoundingClientRect().top + window.scrollY - mark <= 0) id = headings[i].id;
      else break;
    }
    links.forEach(function (a) { a.classList.toggle('is-active', a.hash === '#' + id); });
  }
  spy();
  var ticking = false;
  window.addEventListener('scroll', function () {
    if (ticking) return;
    ticking = true;
    requestAnimationFrame(function () { spy(); ticking = false; });
  }, { passive: true });
})();
