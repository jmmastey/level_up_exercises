## EVE Online Market

The purpose of this application is to provide an interface for users to track and predict item prices in the MMORPG **EVE Online**.

EVE Online has a dynamic, entirely player-driven market.  Some researchers have even taken to studying EVE Online as a small simulation of real-world market trends.

### Phase 1
For this project, I will be using the [EVE Central API](http://dev.eve-central.com/evec-api/start) to retrieve historical prices from the game.  The application will then analyze these prices using linear regression to predict future prices of the items.  I will then display these predictions in both tabular and graph formats.  All prices retrieved using the API will be cached for future use, and the API will then only be consulted for new items or prices recorded since the last API call.

### Phase 2
After the initial project is complete, I will then modify the prediction algorithms to include raw components as a factor.  As every item in the EVE Online universe is manufactured by players from raw resources and other manufactured components, it would make sense that the prices of an item's components would affect the price of the item itself.
