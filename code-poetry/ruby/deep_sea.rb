class DeepSea
  def initialize(depth)
    @mystery = depth == rand(100..500) ?
      Coelacanth.new : DeepSea.new(depth + 1)
  end
end

class Coelacanth
end

DeepSea.new(0)