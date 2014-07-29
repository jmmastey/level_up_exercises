# Shopping Cart Test Plan

* Just a general description, but organized in a way that will help digest the testing plan

There are 3 primary stages: Shopping (browsing the store), Checkout (Pre-confirmation, editing order details), Confirmation (Post-checkout). These three phases will help to organize an effective test plan.

## Browsing

Browsing is the act of continue to shop around without directly managing the shopping cart's details. While browsing, the user should see a cart widget somewhere. Tests may include the ability to add new items (with different quantities) and have the cart widget update accordingly (if the user opts to continue shopping after adding a new item).

## Checkout (Pre-confirm)

### Manage Items

Remove, Change Quantity, Save item for later.

### Paymen

Coupons, Reward(other), Billing (Type/Info/Address/etc)

### Shipping (Address)
- This is an important case as the shipping address may impact the billing or other order details.

## Confirmation

- Order Confirmation (details)
- Tracking Info
- Order Id (Reference/Contact/etc)

## Testing Edge Cases and Notes

- Quantity in shopping mode correctly updates cart (widget)
- Shipping Address adjusts cost/delivery details/estimates
- Billing info helder (auto select card type)
- Shipping restrictions on certain items
-- Geolocation
- Other restrictions on Items
-- Age (Alcohol)
- Variations in state tax
