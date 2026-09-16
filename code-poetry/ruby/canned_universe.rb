class CannedUniverse
  def initialize(universe = self)
    @universe = universe
  end

  def open
    -> { self.class.new(@universe) }
  end
end
