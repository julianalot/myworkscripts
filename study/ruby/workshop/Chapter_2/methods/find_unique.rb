def find_unique! test_array
  test_array.uniq!
end
test_array = [1, 2, 3, 1, 2, 3]
puts find_unique! test_array
#[1,2,3]
