Feature: Line items in cart content page

Happy
  Line for available item with same price appears normally showing name, price, and quantity and
  contributes to cart total
Sad:
  Line for item gone out-of-stock is anunciated with "out of stock" warning and
  contributes to cart total
  Line item for item with changed proce is anunciated with "price change"
  warning
  Line for discontinued items is anunciated with "discontinued" warning and does
  not contribute to cart total
Bad:

