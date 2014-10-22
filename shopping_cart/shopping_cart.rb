class ShoppingCart
  attr_accessor :amount

  INVENTORY = ["eggs","bread","butter","cheese"]
  

  def initialize(cartstatus=[], options={})
    @cartstatus = cartstatus
  end

  def add_item(item)
    @cartstatus<< INVENTORY[item].key
  end

  def cart_balance

  end

  def delete_item()
    @quantity -= 1 if item deleted
  end

  def change_quantity()

  end
end