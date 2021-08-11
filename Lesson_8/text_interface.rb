# frozen_string_literal: false

# required actions
require_relative 'main_menu_actions'
require_relative 'manage_routes_actions'
require_relative 'manage_trains_actions'

class TextInterface
  include MainMenuActions
  include ManageRoutesActions
  include ManageTrainsActions

  def initialize
    @stations = []
    @trains = []
    @routes = []

    @menu_items = MAIN_MENU_ITEMS
    @manage_routes_menu_items = MANAGE_ROUTES_MENU_ITEMS
    @manage_trains_menu_items = MANAGE_TRAINS_MENU_ITEMS
  end

  def run
    system 'clear'
    loop do
      run_action(@menu_items)
    end
  end

  def text_interface(items)
    puts ''

    # detect type of input array
    items = items.collect { |item| item[:title] } if items[0].is_a? Hash

    # select item from list
    result = select_item(items)

    # return result
    items[result].instance_of?(String) ? result : items[result]
  end

  def format_item(item)
    result = item.number if item.is_a? Train
    result = "Car no. #{i}" if item.is_a? TrainCar
    result = item.name if item.is_a? Station
    result = "#{item.stations.first.name} --> #{item.stations.last.name}" if item.is_a? Route
    result = item if item.is_a? String

    result
  end

  def print_items(items)
    items.each_with_index do |item, i|
      item_string = format_item(item)
      puts "#{i + 1}. #{item_string}"
    end
  end

  def select_item(items)
    result = 0
    loop do
      # print menu items
      print_items(items)

      # ask to select item
      print "\nSELECT ITEM: "
      result = gets.chomp.to_i - 1
      system 'clear'

      break unless result.negative? || result >= items.size

      puts 'Please select an existing item!'
    end
    result
  end

  def print_car_list(train)
    block = lambda do |car, i|
      print "Car no.: #{i + 1};  "
      print "type: #{car.type};  "
      print "free #{car.type == :cargo ? 'volume' : 'seats'}: #{car.free_space};  "
      puts "occupied #{car.type == :cargo ? 'volume' : 'seats'}: #{car.occupied_space};"
    end
    train.each_car_to_block(block)
  end

  def clear_puts(string)
    system 'clear'
    puts string
  end

  def run_action(actions, *args)
    index = text_interface(actions)
    action = actions[index][:action]
    send(action, *args)
  end
end
