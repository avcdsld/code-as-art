life = Fiber.new do
  Fiber.yield
end

def chance
  life.resume
end
