my_hash= {:a => 10, :b => 20, :c => 23, :d => 2}
my_hash.reject  { |key, value| value < 20 }