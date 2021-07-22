cart = Hash.new

loop do
    print "Input product name: "
    name = gets.chomp
    break if name == "stop"
    
    print "Input product price: "
    price = gets.chomp.to_f
    
    print "Input quantity: "
    quantity = gets.chomp.to_f

    cart[name] = {price: price, qnt: quantity}
end

# вывести на экран хеш
puts cart

# вывести итоговую сумму за каждый товар
cart.each { |product, data| puts "#{product}: #{data[:price] * data[:qnt]}" }

# вывести на экран итоговую сумму всех покупок в "корзине"
puts "Total: #{ cart.values.inject(0) {|total, data| total + data[:price] * data[:qnt]} }"