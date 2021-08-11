# frozen_string_literal: false

module ManageRoutesActions
  MANAGE_ROUTES_MENU_ITEMS = [
    { title: 'Add station', action: :add_station_to_route },
    { title: 'Remove station', action: :remove_station_from_route }
  ].freeze

  def add_station_to_route(route)
    puts 'Add station:'
    station = text_interface(@stations)
    route.add_station(station)
    puts "Station #{station.name} successfully added to the route!"
  end

  def remove_station_from_route(route)
    puts 'Remove station:'
    station = text_interface(route.stations)
    route.remove_station(station)
    puts "Station #{station.name} successfully deleted from the route!"
  end
end
