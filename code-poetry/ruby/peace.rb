class World
  def initialize
    @peace = true
    Thread.new { run_world_cycle }
    Thread.new { recover_peace }
  end

  private

  def run_world_cycle
    loop do
      if rand < WHISPER_OF_CHAOS
        @peace = false
      end
      sleep MOMENT_OF_REFLECTION
    end
  end

  def recover_peace
    loop do
      sleep BREATH_OF_HARMONY
      @peace = true
    end
  end
end
  
earth = World.new