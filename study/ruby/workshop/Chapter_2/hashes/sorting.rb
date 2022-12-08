my_hash = {:bill => 34, :steve => 66, :eric => 6}
my_hash.sort_by { |name, age| age }
my_hash.sort_by { |name, age| age }.reverse 