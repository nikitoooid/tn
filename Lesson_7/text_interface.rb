class TextInterface
  def initialize
    @stations = []
    @trains = []
    @routes = []

    # пункты основного меню
    @menu_items = [
      {title: "Create station", action: :create_station},
      {title: "Create train", action: :create_train},
      {title: "Create route", action: :create_route},
      {title: "Manage routes", action: :manage_routes},
      {title: "Manage trains", action: :manage_trains},
      {title: "Move train", action: :move_train},
      {title: "Station info", action: :station_info}
    ]

    # пункты меню управления маршрутами
    @manage_routes_menu_items = [
      {title: "Add station", action: :add_station_to_route},
      {title: "Remove station", action: :remove_station_from_route}
    ]

    # пункты меню управления поездами
    @manage_trains_menu_items = [
      {title: "Show cars info", action: :train_cars_info},
      {title: "Set route", action: :set_train_route},
      {title: "Add train car", action: :add_train_car},
      {title: "Remove train car", action: :remove_train_car},
      {title: "Take a space in the train", action: :take_car_space}
    ]

  end

  #запуск программы
  def run
    system "clear"
    loop do
      run_action(@menu_items)
    end
  end

  # private       # все методы ниже не используются вне класса.
  
  # текстовый интерфейс
  def text_interface(items)
    puts ""                                                                                   #отступ для красоты
    
    #определяем, подан на вход массив хэшей или массив объектов
    if items[0].class == Hash
      items = items.collect {|item| item[:title]}
    end

    result=0;
    loop do
      # выводим пункты (определяем класс объекта, поданного на вход)
      items.each_with_index do |item, i|
        case item
        when Train || CargoTrain || PassengerTrain then item = item.number                    #если поезд - выводим его номер
        when TrainCar || CargoCar || PassengerCar then item = "Car no. #{i}"                  #если вагон - выводим его номер в списке вагонов
        when Station then item = item.name                                                    #если станция - выводим имя станции
        when Route then item = "#{item.stations.first.name} --> #{item.stations.last.name}"   #если маршрут - выводим более-менее понятную информацию о маршруте
        end
        puts "#{i+1}. #{item}"                                                                # i+1 для того, чтобы можно было отследить неверный ввод
      end
      
      # просим выбрать пункт
      puts ""                                                                                 #отступ для красоты
      print "SELECT ITEM: "
      result = gets.chomp.to_i - 1                                                            # тут корректируем (ранее делали i+1)
      
      #очищаем экран
      system "clear"
  
      #если пользователь выбрал существующий пункт - прерываем цикл (чтобы вернуть результат), иначе шлём снова выбирать
      if result < 0 || result >= items.size
        puts"Please select an existing item!"
      else
        break
      end
    end
  
    #возвращаем результат выбора
    case items[result]
    when String then return result   #индекс пункта меню, если подавали на вход массив строк
    else items[result]         #конкретный объект, если подавали массив объектов
    end
  end

  # создание станций
  def create_station
    print "Enter station name: "
    station = Station.new(gets.chomp.capitalize)
    @stations << station

    system "clear"
    puts "Station created!"
  end

  # создание поезда
  def create_train
    case text_interface(["Cargo train", "Passenger train"])
    when 0; create_train_by_class(CargoTrain)
    when 1; create_train_by_class(PassengerTrain)
    end
  end

  #создание маршрута
  def create_route
    puts "Select first station:"
    start_station = text_interface(@stations)
    puts "Select final station:"
    final_station = text_interface(@stations)

    route = Route.new(start_station, final_station)
    @routes << route

    puts "Route #{start_station.name} --> #{final_station.name} successfully created"
  end

  # Управление маршрутами (добавление / удаление станций)
  def manage_routes
    
    puts "Select route."
    route = text_interface(@routes)
    
    # Редактируем маршрут
    run_action(@manage_routes_menu_items, route)

  end

  # Добавление станции к маршруту
  def add_station_to_route(route)
    puts "Add station:"
    station = text_interface(@stations)
    route.add_station(station)
    puts "Station #{station.name} successfully added to the route!"
  end

  # Удаление станции из маршрута
  def remove_station_from_route(route)
    puts "Remove station:"
    station = text_interface(route.stations)
    route.remove_station(station)
    puts "Station #{station.name} successfully deleted from the route!"
  end

  # Управление поездами
  def manage_trains
    system "clear"

    puts "Select train."
    train = text_interface(@trains)

    run_action(@manage_trains_menu_items, train)
  end

  # Задать поезду маршрут
  def set_train_route(train)
    puts "Select route."
    route = text_interface(@routes)
    train.set_route(route)
    puts "Route successfuly added to the train no.#{train.number}"
  end

  # Задать поезду маршрут
  def add_train_car(train)
    train_car = create_car_by_type(train.type)
    train.add_car(train_car)
    
    #проверка, добавился ли вагон
    if train.cars.include? train_car
      puts "#{train_car.type.capitalize} car successfuly added to the train no.#{train.number}"
    else
      puts "An error occured while adding a #{train_car.type} car!"
    end
  end

  # Задать поезду маршрут
  def remove_train_car(train)
    system "clear"

    puts "Select train car."
    train_car = text_interface(train.cars)
    train.remove_car(train_car)

    puts "#{train_car.type} car successfully removed from train no.#{train.number}"
  end

  # Движение поезда
  def move_train
    puts "Select train."
    train = text_interface(@trains)

    if train.route.nil?
      puts "No route assigned to the train!"
      return
    end

    puts "Select direction."
    case text_interface(["Forward","Backward"])
    when 0
      train.move("forward")
    when 1
      train.move("backward")
    end
  end

  # Вывод на экран списка поездов на станции
  def station_info
    station = text_interface(@stations)

    system "clear"

    puts "All trains on station #{station.name}:"
    
    block = -> (train) do
      print "Train no.: #{train.number};  "
      print "type: #{train.type};  "
      puts  "has #{train.cars.length} cars;"
    end
    station.each_train_to_block(block)

    print "Press Enter to exit."
    gets
    system "clear"
  end

  # Вывод на экран списка вагонов поезда
  def train_cars_info(train)
    system "clear"

    puts "All cars of train #{train.number}:"
    
    print_car_list(train)
    
    print "Press Enter to exit."
    gets
    system "clear"
  end

  # Печать на экран списка вагонов поезда
  def print_car_list(train)
    block = -> (car,i) do
      print "Car no.: #{i+1};  "
      print "type: #{car.type};  "
      print "free #{car.type == "cargo" ? "volume" : "seats"}: #{car.free_space};  "
      puts "occupied #{car.type == "cargo" ? "volume" : "seats"}: #{car.occupied_space};"
    end
    train.each_car_to_block(block)
  end

  # Занять место в вагоне
  def take_car_space(train)
    system "clear"

    puts "Select train car."
    print_car_list(train)

    car_index = gets.chomp.to_i - 1
    train_car = train.cars[car_index]

    if train_car.type == "cargo"
      print "Enter the volume you want to occupy: "
      volume = gets.chomp.to_i
      train_car.take_a_volume(volume)
      system "clear"
      puts "You took #{volume} of volume in the car!"
    else
      train_car.take_a_seat
      puts "You took 1 seat in the car!"
    end
  end

  # Вспомогательный метод (Создание поезда)
  def create_train_by_class(trainClass)
    begin
      print "Enter train number: "
      train = trainClass.new(gets.chomp.capitalize)
    rescue RuntimeError => e
      system "clear"
      puts e.message
      retry
    end

    @trains << train
    system "clear"
    puts "#{train.type.capitalize} train #{train.number} created!"
  end

  # Вспомогательный метод (Создание вагона)
  def create_car_by_type(type)
    system "clear"
    case type
      when "passenger"
        print "Set total seats: "
        volume = gets.chomp.to_i
        return PassengerCar.new(volume)
      when "cargo"
        print "Set total volume: "
        volume = gets.chomp.to_i
        return CargoCar.new(volume)
    end
  end

  # Вспомогательный метод (Запуск действия)
  def run_action(actions, *args)
    index = text_interface(actions)
    action = actions[index][:action]
    send(action, *args)
  end

end