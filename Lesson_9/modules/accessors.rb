# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*methods)
      methods.each do |method|
        # create classic getters
        send(:attr_reader, method.to_sym, "#{method}_history".to_sym)
        # create custom setter for working with history
        define_method("#{method}=".to_sym) do |v|
          instance_variable_set("@#{method}".to_sym, v)

          history_var = "@#{method}_history".to_sym
          instance_variable_get(history_var) || instance_variable_set(history_var, [])
          instance_variable_get(history_var).push(instance_variable_get("@#{method}".to_sym))
        end
      end
    end

    def strong_attr_accessor(method, type)
      # create classic getters
      send(:attr_reader, method.to_sym, "#{method}_type".to_sym)
      # save method type
      instance_variable_set("@#{method}_type".to_sym, type)
      method_type = instance_variable_get("@#{method}_type".to_sym)
      # create custom setter
      define_method("#{method}=".to_sym) do |v|
        v.is_a? method_type ? instance_variable_set("@#{method}".to_sym, v) : raise('Invalid method type')
      end
    end
  end
end
