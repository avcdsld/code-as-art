const today = new Date(2023, 0, 1),
      xmas = new Date(today.getFullYear(), 11, 25),
      diff = (xmas - today) / 86400000,
      eveCount = Math.ceil(diff);

console.log(`Merry Xmas${
  eveCount > 0 ? ' Eve'.repeat(eveCount) : ''}`);
