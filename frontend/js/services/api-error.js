// Ensartet fejl fra service-laget. Følger API'ets fejlformat
// { "error": "VALIDATION_ERROR", "message": "...", "details": [] }.
export class ApiError extends Error {
  constructor(status, code, message, details = []) {
    super(message);
    this.name = 'ApiError';
    this.status = status;
    this.code = code;
    this.details = Array.isArray(details) ? details : [];
  }

  // details: [{ field: 'check_out', message: '...' }] -> { check_out: '...' }
  get fieldErrors() {
    return Object.fromEntries(
      this.details.filter((d) => d && d.field).map((d) => [d.field, d.message]),
    );
  }
}

export function validationError(errors, message = 'Bookingen indeholder ugyldige felter.') {
  const details = Object.entries(errors).map(([field, msg]) => ({ field, message: msg }));
  return new ApiError(422, 'VALIDATION_ERROR', message, details);
}
