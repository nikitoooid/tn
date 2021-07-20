print "Введите длинну стороны A: "
a = gets.chomp.to_f

print "Введите длинну стороны B: "
b = gets.chomp.to_f

print "Введите длинну стороны C: "
c = gets.chomp.to_f

if a>=b+c || b>=a+c || c>=a+b
    "Это не может быть треугольником!"
elsif a*a+b*b==c*c || a*a+c*c==b*b || b*b+c*c==a*a
    puts "Треугольник является прямоугольным"
elsif a==b && b==c && c==a
    puts "Треугольник является равносторонним"
elsif a==b || b==c || c==a
    puts "Треугольник является равнобедренным"
else
    puts "Треугольник является самым обычным и скучным"
end