// Indgangspunkt: binder UI-modulerne sammen.
import { config } from './config.js';
import { bookingService } from './services/booking-service.js';
import { initBookingForm } from './ui/booking-form.js';
import { initRoomsView } from './ui/rooms-view.js';
import { initSearchForm } from './ui/search-form.js';

document.getElementById('mode-banner').hidden = !config.useMock;

const searchForm = document.getElementById('search-form');
const confirmation = document.getElementById('confirmation');
let lastCriteria = null;

const bookingForm = initBookingForm({
  section: document.getElementById('guest'),
  confirmation,
  service: bookingService,
  onBack() {
    roomsView.load(lastCriteria);
  },
  onCreated() {
    roomsView.hide();
  },
});

const roomsView = initRoomsView(document.getElementById('rooms'), {
  service: bookingService,
  onSelect(room) {
    bookingForm.open(lastCriteria, room);
  },
});

initSearchForm(searchForm, {
  onSearch(criteria) {
    lastCriteria = criteria;
    bookingForm.reset();
    roomsView.load(criteria);
  },
});

confirmation.querySelector('[data-new-booking]').addEventListener('click', () => {
  bookingForm.reset();
  searchForm.scrollIntoView({ behavior: 'smooth', block: 'start' });
  searchForm.elements.check_in.focus({ preventScroll: true });
});
