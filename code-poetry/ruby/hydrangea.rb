ph = 6.5
loop {
  puts ph < 7 ? :蒼 : :紅
  ph += rand(-1.0..1.0) / 10
  break if rand < 0.1
}
