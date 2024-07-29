class Soldier
  def initialize
    @alive = true
    @power = 100
    Thread.new { work }
  end

  def work
    while @alive
      @power -= rand(1..5)
      @alive = false if @power < 0
      puts @power
      sleep rand
    end
  end

  def care
    @power = [@power + rand(1..5), 100].min
  end
end

soldier = Soldier.new
