// KartBalance Event Tracking
(function() {
  'use strict';

  // Only run if gtag is available
  if (typeof gtag !== 'function') return;

  document.addEventListener('click', function(e) {
    var link = e.target.closest('a');
    if (!link) return;

    var href = link.getAttribute('href') || '';
    var page = window.location.pathname;

    // App Store clicks
    if (href.indexOf('apps.apple.com') !== -1) {
      gtag('event', 'app_store_click', {
        source_page: page,
        link_text: link.textContent.trim().substring(0, 50)
      });
    }

    // CTA clicks
    if (link.closest('.app-cta')) {
      gtag('event', 'cta_click', {
        source_page: page,
        cta_type: 'app_download'
      });
    }

    // Outbound clicks
    if (href.indexOf('http') === 0 && href.indexOf(window.location.hostname) === -1) {
      gtag('event', 'outbound_click', {
        url: href,
        source_page: page
      });
    }
  });
})();
