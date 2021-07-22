print "Day: "
d = gets.chomp.to_i
print "Month: "
m = gets.chomp.to_i
print "Year: "
y = gets.chomp.to_i


this_year = [ 31, (y % 4 == 0) || (y % 100 == 0 && y % 400 == 0) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

current = 0
for i in 0...(m-1) do
    current += this_year[i]
end
current += d

puts "This is #{current}-th day of #{y} year."