// Indgangspunkt: binder UI-modulerne sammen.
import { config } from './config.js';
import { notify } from './ui/dom.js';
import { initSearchForm } from './ui/search-form.js';

document.getElementById('mode-banner').hidden = !config.useMock;

initSearchForm(document.getElementById('search-form'), {
  onSearch(criteria) {
    notify(`Søger ${criteria.check_in} – ${criteria.check_out} for ${criteria.guests_count} gæst(er).`);
  },
});
