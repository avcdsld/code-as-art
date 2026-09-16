function* week(labor) {
  let day = 1;
  yield day++;
  yield day++;
  yield day++;
  yield day++;
  yield day++
  return ~(day|(labor||0));
}
