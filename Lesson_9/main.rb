# frozen_string_literal: true

# modules
require_relative './modules/accessors'
require_relative './modules/validation'
require_relative './modules/manufacturer'
require_relative './modules/instance_counter'
# classes
require_relative './classes/station'
require_relative './classes/route'
require_relative './classes/train'
require_relative './classes/cargo_train'
require_relative './classes/passenger_train'
require_relative './classes/train_car'
require_relative './classes/cargo_car'
require_relative './classes/passenger_car'
# text interface
require_relative './classes/text_interface'

interface = TextInterface.new
interface.run
