class Cat
  def initialize(house); @house_id = house.object_id; end
  def exist; self; end
  def vanish; end
end

class House
  def initialize; @master = :sick; end
  def exist; self; end
  def collapse; disappear; end
  private
  def disappear; self unless nil; end
end

class Moon
  def illuminate(cats); cats.each { |cat| cat.exist.vanish }; end
end

class Poem
  def exist
    house = House.new
    cats = [Cat.new(house), Cat.new(house)]
    Moon.new.illuminate(cats)
  end
end
