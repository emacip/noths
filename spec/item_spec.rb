#coding: utf-8
require "#{File.dirname(__FILE__)}/../lib/item"

# Model Item
describe Item do

  it "set item" do
    item  = Item.new("001", "Travel Card Holder", 9.25)
    item.code.should  == "001"
    item.name.should  == "Travel Card Holder"
    item.price.should == 9.25
  end

  it "get item" do
    item  = Item.new("001", "Travel Card Holder", 9.25)
    item.to_s.should == "Info Product -> //code: 001 name: Travel Card Holder price: 9.25 pounds"
  end


end