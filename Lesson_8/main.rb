# frozen_string_literal: true

# modules
require_relative 'manufacturer'
require_relative 'instance_counter'
# classes
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'train_car'
require_relative 'cargo_car'
require_relative 'passenger_car'
# text interface
require_relative 'text_interface'

interface = TextInterface.new
interface.run
