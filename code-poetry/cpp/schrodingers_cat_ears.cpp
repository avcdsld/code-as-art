#include <meta>

struct cat;

static_assert(!std::meta::is_complete_type(^^cat));
