// Indgangspunkt: binder UI-modulerne sammen.
import { config } from './config.js';
import { bookingService } from './services/booking-service.js';
import { notify } from './ui/dom.js';
import { initRoomsView } from './ui/rooms-view.js';
import { initSearchForm } from './ui/search-form.js';

document.getElementById('mode-banner').hidden = !config.useMock;

const roomsView = initRoomsView(document.getElementById('rooms'), {
  service: bookingService,
  onSelect(room) {
    notify(`Værelse ${room.room_number} valgt.`);
  },
});

initSearchForm(document.getElementById('search-form'), {
  onSearch(criteria) {
    roomsView.load(criteria);
  },
});
