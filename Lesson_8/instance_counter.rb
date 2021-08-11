# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_accessor :count

    def new(*arg)
      @count ||= 0
      @count += 1
      super(*arg)
    end

    def instances
      @count
    end
  end
end
