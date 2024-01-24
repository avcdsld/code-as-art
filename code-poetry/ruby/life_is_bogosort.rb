def bogosort(array)
  array.shuffle! until array.each_cons(2).all? { |a, b| a <= b }
  array
end
  
alias life_is bogosort