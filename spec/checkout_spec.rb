#coding: utf-8
require "#{File.dirname(__FILE__)}/../lib/checkout"
require "#{File.dirname(__FILE__)}/../lib/rule"
require "#{File.dirname(__FILE__)}/../lib/item"

describe Checkout do

  before(:each) do
    @items = []
    @items << Item.new("001", "Travel Card Holder"     ,  9.25)
    @items << Item.new("002", "Personalised cufflinks" ,  45.00)
    @items << Item.new("003", "Kids T-shirt"           ,  19.95)
    @items << Item.new("004", "MacBook Pro"            , 999.95)

    @rules = []
    # If you spend over £60, then you get 10% off your purchase
    @rules << Rule.new(:type => :discount, :amount => 60, :deduct => 10)

    # If you buy 2 or more lavender hearts then the price drops to £8.50
    @rules << Rule.new(:type => :count, :amount => 2, :product => "001", :deduct => 8.50)
  end

  it "All products and rules its ok" do
    @items.count.should == 4
    @rules.count.should == 2
  end

  it "Returns 0 if basket is empty" do
    co = Checkout.new(@rules)
    co.total.should == 0
  end

  it "Add item to my basket" do
    co = Checkout.new(@rules)
    co.scan(@items[0])
    co.total.should == @items[0].price
  end

  it "Discount of 10% for Macbook Pro" do
    co = Checkout.new(@rules)
    co.scan(@items[3])
    co.total.should == 899.96
  end

  it "Two or more Travel Card Holder for £8.50" do
    co = Checkout.new(@rules)
    co.scan(@items[0]).scan(@items[0])
    co.total.should == 2 * 8.5
  end

  it "Returns the cost of two products with not rules discount" do
    co = Checkout.new(@rules)
    co.scan(@items[0]).scan(@items[1])
    co.total.should == @items[0].price + @items[1].price
  end

  context "Test code for Not on the High Street"  do

    it "Test1 Basket: 001,002,003     Total: £66.78" do
      co = Checkout.new(@rules)
      co.scan(@items[0]).scan(@items[1]).scan(@items[2])
      co.total.should == 66.78
    end

    it "Test2 Basket: 001,003,001     Total: £36.95" do
      co = Checkout.new(@rules)
      co.scan(@items[0]).scan(@items[2]).scan(@items[0])
      co.total.should == 36.95
    end

    it "Test3 Basket: 001,002,001,003 Total: £73.76" do
      co = Checkout.new(@rules)
      co.scan(@items[0]).scan(@items[1]).scan(@items[0]).scan(@items[2])
      co.total.should == 73.76
    end
  end

end