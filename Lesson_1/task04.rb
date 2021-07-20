print "Введите коэффициент a: "
a = gets.chomp.to_f

print "Введите коэффициент b: "
b = gets.chomp.to_f

print "Введите коэффициент c: "
c = gets.chomp.to_f

d = b**2 - 4*a*c

if d<0
    puts "Дискриминант: #{d}, корней нет!"
elsif d==0
    puts "Дискриминант: #{d}, корень: #{( -1*b + Math.sqrt(d) )/( 2*a )}"
else 
    puts "Дискриминант: #{d}, корень 1: #{( -1*b + Math.sqrt(d) )/( 2*a )}, корень 2: #{( -1*b - Math.sqrt(d) )/( 2*a )}"
end