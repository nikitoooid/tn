# frozen_string_literal: false

module MainMenuActions
  MAIN_MENU_ITEMS = [
    { title: 'Create station', action: :create_station },
    { title: 'Create train', action: :create_train },
    { title: 'Create route', action: :create_route },
    { title: 'Manage routes', action: :manage_routes },
    { title: 'Manage trains', action: :manage_trains },
    { title: 'Move train', action: :move_train },
    { title: 'Station info', action: :station_info }
  ].freeze

  def create_station
    print 'Enter station name: '
    station = Station.new(gets.chomp.capitalize)
    @stations << station

    clear_puts('Station created!')
  end

  def create_train
    case text_interface(['Cargo train', 'Passenger train'])
    when 0 then create_train_by_class(CargoTrain)
    when 1 then create_train_by_class(PassengerTrain)
    end
  end

  def create_route
    puts 'Select first station:'
    start_station = text_interface(@stations)
    puts 'Select final station:'
    final_station = text_interface(@stations)

    route = Route.new(start_station, final_station)
    @routes << route

    puts "Route #{start_station.name} --> #{final_station.name} successfully created"
  end

  def manage_routes
    puts 'Select route.'
    route = text_interface(@routes)

    run_action(@manage_routes_menu_items, route)
  end

  def manage_trains
    clear_puts('Select train.')
    train = text_interface(@trains)

    run_action(@manage_trains_menu_items, train)
  end

  def move_train
    puts 'Select train.'
    train = text_interface(@trains)

    if train.route.nil?
      puts 'No route assigned to the train!'
      return
    end

    puts 'Select direction.'
    text_interface(%w[Forward Backward]).zero? ? train.move(:forward) : train.move(:backward)
  end

  def station_info
    station = text_interface(@stations)

    clear_puts("All trains on station #{station.name}:")

    block = lambda do |train|
      print "Train no.: #{train.number};   type: #{train.type};   has #{train.cars.length} cars;"
    end
    station.each_train_to_block(block)

    print 'Press Enter to exit.'
    gets
    system 'clear'
  end
end
