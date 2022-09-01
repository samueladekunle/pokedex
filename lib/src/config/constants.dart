// Constants

/// The extent of each tile in the main axis of a grid.
const double kMaxGridExtent = 200;

/* -------- Type definitions ------------ */
typedef JsonResponse = Map<String, dynamic>;

/* ---------- API URLs ----------- */
const kPokeAPIBaseUrl = 'https://pokeapi.co/api/v2/';

/* ----------- Error messages ----------- */
const kDefaultErrorMessage = 'An error occurred, please try again later';

const kNoInternetMessage = 'No Internet connection';

/* ------- API status codes -------- */
const kUnauthorisedStatusCode = 401;

const kForbiddenStatusCode = 403;
