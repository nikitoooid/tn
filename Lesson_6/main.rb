# Модули
require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
# Классы
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'train_car.rb'
require_relative 'text_interface.rb'

interface = TextInterface.new
interface.run