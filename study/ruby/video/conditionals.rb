system 'clear'

print 'Enter a number between 1 and 10: '
num = gets.to_i

if num > 10
    puts 'Between 1 and 10 please?'
elsif num > 5
    puts "#{num} is greater than 5"
elsif num == 5
    puts "#{num} is equal to 5"
else
    puts "#{num} is less than 5"
end