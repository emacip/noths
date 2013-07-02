class Item

  attr_accessor :code, :name, :price

  def initialize(code, name, price)
    @code  = code
    @name  = name
    @price = price
  end

  def to_s
    "Info Product -> //code: #{@code} name: #{@name} price: #{@price} pounds"
  end

end
