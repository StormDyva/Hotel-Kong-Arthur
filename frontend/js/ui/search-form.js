// Trin 1: søgeformular med check-in, check-out og antal gæster.
import { addDays, todayIso } from '../lib/dates.js';
import { validateStay } from '../lib/validation.js';
import { showFieldErrors } from './dom.js';

export function readSearchForm(form) {
  const data = new FormData(form);
  return {
    check_in: data.get('check_in'),
    check_out: data.get('check_out'),
    guests_count: data.get('guests_count'),
  };
}

export function initSearchForm(form, { onSearch }) {
  const today = todayIso();
  const { check_in: checkIn, check_out: checkOut } = form.elements;

  checkIn.min = today;
  checkIn.value ||= today;
  checkOut.min = addDays(checkIn.value, 1);
  checkOut.value ||= addDays(checkIn.value, 1);

  // Hold check-out mindst én nat efter check-in, når check-in ændres.
  checkIn.addEventListener('change', () => {
    const earliestCheckOut = addDays(checkIn.value, 1);
    checkOut.min = earliestCheckOut;
    if (earliestCheckOut && (!checkOut.value || checkOut.value < earliestCheckOut)) {
      checkOut.value = earliestCheckOut;
    }
  });

  form.addEventListener('submit', (event) => {
    event.preventDefault();
    const criteria = readSearchForm(form);
    const { valid, errors } = validateStay(criteria, { today });
    showFieldErrors(form, errors);
    if (!valid) return;
    onSearch({ ...criteria, guests_count: Number(criteria.guests_count) });
  });
}
