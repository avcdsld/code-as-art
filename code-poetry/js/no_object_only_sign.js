function Sign(x) {
  return {
    interpretant: () => Sign(x),
    object: () => void 0
  }
}

for (let s = Sign(Sign); s; s = s.interpretant());
