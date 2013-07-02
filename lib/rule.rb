class Rule

  attr_reader :type, :amount, :value, :code
  @@rules = []

  def initialize(params={})
    @type   = params[:type]
    @amount = params[:amount]
    @value  = params[:deduct]
    @code   = params[:product]
  end

  def to_s
    "Rules-> type:#{type}, amount:#{amount}, value:#{value}, code:#{code}"
  end

  def self.add(item)
    @@rules << item if item.class == Rule
    @@rules += item if item.class == Array
  end

  def self.give_total(total)
    r = @@rules.find { |r| r.type == :discount }
    total = discount(total, r.value) if total > r.amount
    total
  end

  def self.match(products, items)
    result = items.find_all do |item|
      rules = @@rules.find_all { |rule| rule.code == item.code }
      rules.each do |apply_rule|
        item.price = apply_rule.value if products[apply_rule.code] >= apply_rule.amount
      end
    end
    items
  end

  def self.discount(amount, percentage_off)
    you_pay = amount - ((amount * percentage_off) / 100)
    (you_pay * 100).round.to_f / 100
  end

end