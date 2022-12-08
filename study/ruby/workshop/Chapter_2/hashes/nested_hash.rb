my_hash = { :bill => { :name => "Bill", :age => 55 }, :steve => { :name => "Steve", :age => 60 }, :eric => { :name => "Eric", :age => 50 } }
my_hash.sort_by { |key, value| value[:age] }
