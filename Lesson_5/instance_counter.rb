module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_accessor :count
    
    # я пошел данным путём, поскольку:
    # 1. Судя по ТЗ, register_instance впредь будет использоваться исключительно при создании инстанса классов
    # 2. Исходя из п.1 - можно сделать всё короче и красивее, избавившись от register_instance и от InstanceMethods
    # 3. Не нужно редактировать методы initialize классов, куда мы подключаем модуль
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

