class TextInterface
  def initialize
    @stations = []
    @trains = []
    @routes = []

    # пункты основного меню
    @menu_items = [
      "Create station",
      "Create train",
      "Create route",
      "Manage routes",
      "Manage trains",
      "Move train",
      "Station info"
    ]
  end

  #запуск программы
  def run
    system "clear"
    loop do
      case text_interface(@menu_items)
      when 0
        create_station()
      when 1
        create_train()
      when 2
        create_route()
      when 3
        manage_routes()
      when 4
        manage_trains()
      when 5
        move_train()
      when 6
        station_info()
      end
    end
  end

  # private       # все методы ниже не используются вне класса.
  
  # текстовый интерфейс
  def text_interface(items)
    puts ""                                                                                   #отступ для красоты
  
    result=0;
    loop do
      # выводим пункты (определяем класс объекта, поданного на вход)
      items.each_with_index do |item, i|
        case item
        when Train || CargoTrain || PassengerTrain then item = item.number                    #если поезд - выводим его номер
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
    case text_interface(["Add station", "Remove station"])
    when 0
      puts "Add station:"
      station = text_interface(@stations)
      route.add_station(station)
      puts "Station #{station.name} successfully added to the route!"
    when 1
      puts "Remove station:"
      station = text_interface(route.stations)
      route.remove_station(station)
      puts "Station #{station.name} successfully deleted from the route!"
    end

  end

  # Управление поездами
  def manage_trains

    puts "Select train."
    train = text_interface(@trains)

    case text_interface(["Set route", "Add train car", "Remove train car"])
    when 0
      puts "Select route."
      route = text_interface(@routes)
      train.set_route(route)
      puts "Route successfuly added to the train no.#{train.number}"
    when 1
      train_car = TrainCar.new(train.type)
      train.add_car(train_car)
      
      #проверка, добавился ли вагон
      if train.speed == 0
        puts "#{train_car.type} car successfuly added to the train no.#{train.number}"
      else
        puts "Train in move!"
      end
    when 2
      train_car = text_interface(train.cars)
      train.remove_car(train_car)
      puts "#{train_car.type} car successfully removed from train no.#{train.number}"
    end

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

  # Информация о станции
  def station_info
    station = text_interface(@stations)

    system "clear"

    puts "All trains on station #{station.name}:"
    station.trains.each { |t| puts "no.#{t.number}"}

    print "Press Enter to exit."
    gets
    system "clear"
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
    puts "Train created!"
  end
end