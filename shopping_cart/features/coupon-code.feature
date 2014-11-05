Feature: User submits coupon code

  Happy:
    User enters recognized unconditional coupon code: The associated coupon
    rebate is itemized in cart total (free shipping, percent-rebate, dollar-rebate)
    User enters item-specific coupon and has applicable item in cart: coupon
    rebate is itemized in ....
    User enters coupon with minimum purchase requirement and meets the
    requirement: rebate is itemized in .....
  Sad:
    User enters expired coupon code: No rebate applies and warning appears
    User enters coupon code which does not apply to items in cart: No rebate is
    applied and warning appears
    User enters coupon code with unmet minimum purchase requirement: No rebate
    is offers, warning appears explaining how to meet purchase requirements,
    as a placeholder the zero-value rebate is still itemized in cart total
  Bad:
    User enters unrecognized coupon code: No rebate is applied and warning
    appears


Feature: User with stocked cart from prior unauthenticated session logs in and
    has empty cart assoc. with account

  Happy:
    Items from authenticated session are retained in authenticated session and
    thereafter stored with session



Feature: Authenticated user with cart items logs out and back in to find same
  items

  Happy:
    Items' price and availability haven't changed and he finds same items in cart
  Sad:
    Items' price and availability have changed and a one-time highly visible
    warning is displayed in an unobtrusive fashion, and items are anunciated in
    itemized cart view
  Bad:
    Items have become permanently unavailable: item is properly anunciated and a
    visible unobtrusive warning is displayed


