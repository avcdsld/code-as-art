const today = new Date(),
      xmas = new Date(today.getFullYear(), 11, 25),
      diff = (xmas - today) / 86400000,
      eveCount = Math.ceil(diff);

console.log(`Merry Xmas${
  eveCount > 0 ? ' Eve'.repeat(eveCount) : ''}`);
