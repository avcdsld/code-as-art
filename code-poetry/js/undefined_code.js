// As of September 2023, Unicode 0x30000 to 0xDFFFF are undefined,
// but something might be discovered in the future.
String.fromCodePoint(0x30000 + Math.random() * 0xAFFFF | 0)