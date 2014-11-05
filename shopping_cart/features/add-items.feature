Feature: Add items to cart
  As a shopper
  I want to add items to my cart
  So I can purchase them

Happy:
  Add available item to cart and item appears in cart
  Add available item to cart when it exists and count increments
Sad:
  Add out-of-stock item
  Add items beyond available quantity
  Add invalid/missing SKU
Bad:
  Submit invalid form fields

