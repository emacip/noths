require "#{File.dirname(__FILE__)}/../lib/rule"

class Checkout

  def initialize(rules)
    @items = []
    @items_hash = {}
    Rule.add(rules)
  end

  def scan(item)
    @items << item
    @items_hash[item.code] ||= 0;
    @items_hash[item.code] += 1;
    self
  end

  def total
    sum=0
    @items = Rule.match(@items_hash, @items)
    @items.each do |i|
      sum += i.price
    end
    sum = Rule.give_total(sum)
  end

  def first(co)
    item_first = co[0]
  end

  def to_s
    @items.each {|i| "#{i.to_s}"}
  end

end