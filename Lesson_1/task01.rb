print "Введите ваше имя: "
name = gets.chomp

print "Введите ваш рост: "
height = gets.chomp.to_i

weight = ( height - 110 ) * 1.15

if weight < 0
    puts "#{name}, ваш вес уже оптимальный!"
else
    puts "#{name}, ваш идеальный вес: #{weight} кг"
end