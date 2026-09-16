def is_new_year?
  Time.now.year == 2025 && task.status == :done
end
