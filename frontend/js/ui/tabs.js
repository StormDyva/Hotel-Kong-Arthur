// Skifter mellem "Ny booking" og "Bookingoversigt".
export function initTabs(nav, { onChange } = {}) {
  const tabs = [...nav.querySelectorAll('[role="tab"]')];

  function select(tab) {
    tabs.forEach((t) => {
      const selected = t === tab;
      t.setAttribute('aria-selected', String(selected));
      t.tabIndex = selected ? 0 : -1;
      document.getElementById(t.getAttribute('aria-controls')).hidden = !selected;
    });
    onChange?.(tab.getAttribute('aria-controls'));
  }

  nav.addEventListener('click', (event) => {
    const tab = event.target.closest('[role="tab"]');
    if (tab) select(tab);
  });

  nav.addEventListener('keydown', (event) => {
    if (event.key !== 'ArrowRight' && event.key !== 'ArrowLeft') return;
    const index = tabs.indexOf(document.activeElement);
    if (index < 0) return;
    const next = tabs[(index + (event.key === 'ArrowRight' ? 1 : tabs.length - 1)) % tabs.length];
    next.focus();
    select(next);
  });

  return { select: (panelId) => select(tabs.find((t) => t.getAttribute('aria-controls') === panelId)) };
}
