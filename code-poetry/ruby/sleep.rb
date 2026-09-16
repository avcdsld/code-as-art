children_care_time = rand(4..6)
work_time = rand(8..12)
meal_time = rand(1..2)
research_time = rand(0..4)

sleep_time = 24 \
  - children_care_time \
  - work_time \
  - meal_time \
  - research_time

sleep(sleep_time)
