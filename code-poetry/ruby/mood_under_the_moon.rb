def night?
  Time.now.hour >= 22 || Time.now.hour < 4
end
  
night? ? :negative : :positive