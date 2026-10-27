// Små DOM-hjælpere, som deles af UI-modulerne.

// Viser feltfejl i elementer med data-error-for="<feltnavn>" og markerer
// felterne med aria-invalid, så skærmlæsere også får fejlen.
export function showFieldErrors(form, errors = {}) {
  form.querySelectorAll('[data-error-for]').forEach((el) => {
    const name = el.dataset.errorFor;
    const message = errors[name] ?? '';
    el.textContent = message;
    const field = form.elements.namedItem(name);
    if (field) field.setAttribute('aria-invalid', message ? 'true' : 'false');
  });

  const firstInvalid = form.querySelector('[aria-invalid="true"]');
  if (firstInvalid) firstInvalid.focus();
}

export function setBusy(button, busy, busyLabel) {
  if (!button) return;
  if (busy) {
    button.dataset.label = button.textContent;
    button.textContent = busyLabel;
    button.disabled = true;
  } else {
    button.textContent = button.dataset.label ?? button.textContent;
    button.disabled = false;
  }
}

let toastTimer;

// Kort statusbesked i #toast (aria-live).
export function notify(message, type = 'info') {
  const toast = document.getElementById('toast');
  if (!toast) return;
  toast.textContent = message;
  toast.dataset.type = type;
  toast.hidden = false;
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => {
    toast.hidden = true;
  }, 4000);
}
