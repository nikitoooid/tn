# frozen_string_literal: false

module ManageTrainsActions
  MANAGE_TRAINS_MENU_ITEMS = [
    { title: 'Show cars info', action: :train_cars_info },
    { title: 'Set route', action: :select_train_route },
    { title: 'Add train car', action: :add_train_car },
    { title: 'Remove train car', action: :remove_train_car },
    { title: 'Take a space in the train', action: :take_car_space }
  ].freeze

  def train_cars_info(train)
    clear_puts("All cars of train #{train.number}:")

    print_car_list(train)

    print 'Press Enter to exit.'
    gets
    system 'clear'
  end

  def select_train_route(train)
    puts 'Select route.'
    route = text_interface(@routes)
    train.route = route
    puts "Route successfuly added to the train no.#{train.number}"
  end

  def add_train_car(train)
    train_car = create_car_by_type(train.type)
    train.add_car(train_car)

    if train.cars.include? train_car
      puts "#{train_car.type.capitalize} car successfuly added to the train no.#{train.number}"
    else
      puts "An error occured while adding a #{train_car.type} car!"
    end
  end

  def remove_train_car(train)
    clear_puts('Select train car.')

    train_car = text_interface(train.cars)
    train.remove_car(train_car)

    puts "#{train_car.type} car successfully removed from train no.#{train.number}"
  end

  def take_car_space(train)
    clear_puts('Select train car.')

    print_car_list(train)

    car_index = gets.chomp.to_i - 1
    train_car = train.cars[car_index]

    train_car.type == :cargo ? take_a_volume(train_car) : take_a_seat(train_car)
  end

  def take_a_seat(train_car)
    train_car.take_a_seat
    puts 'You took 1 seat in the car!'
  end

  def take_a_volume(train_car)
    print 'Enter the volume you want to occupy: '
    volume = gets.chomp.to_i
    train_car.take_a_volume(volume)
    clear_puts("You took #{volume} of volume in the car!")
  end

  def create_train_by_class(train_class)
    begin
      print 'Enter train number: '
      train = train_class.new(gets.chomp.capitalize)
    rescue RuntimeError => e
      clear_puts(e.message)
      retry
    end

    @trains << train
    clear_puts("#{train.type.capitalize} train #{train.number} created!")
  end

  def create_car_by_type(type)
    case type
    when :passenger
      clear_puts('Set total seats: ')
      seats = gets.chomp.to_i
      PassengerCar.new(seats)
    when :cargo
      clear_puts('Set total volume: ')
      volume = gets.chomp.to_i
      CargoCar.new(volume)
    end
  end
end
