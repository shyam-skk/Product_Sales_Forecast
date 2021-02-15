# Product_Sales_Forecast
Predicted the sales for two products A & B for the period - October 2017 to December 2018

Sales forecasts enable you to manage your business more effectively. A sales forecast is
an estimate of the number of goods and services you can realistically sell over the
forecast period. Here we are provided with past sale history of two different types of
consumable items in a certain store during the period of January 2002 to September
2017. Our items are named as Item A & Item B and the number of sales during the past
specified period is given in full digits. So our major business objective is to predict sales
of two products for the period of October 2017 to December 2018. Based on the nature,
behavior, and properties of the time series given, here we will test and build
appropriate forecast model on the test time series object and we will select the best fit
model for the forecast the product.

The project follows the listed prosedure and expalines it with appropriate answers.

1. Read the data as time series objects in R. Plot the data. What are the major
features you notice in the series? How do the two series differ?

2. Before a formal extraction of time series components is done, can you check for
seasonal changes in the data for the two series separately? Particularly whether
there is more variability in a season compared to the others, whether seasonal
variations are changing across years etc. Compare the behavior of the two series.

3. Decompose each series to extract trend and seasonality, if there are any. Which
seasonality is more appropriate – additive or multiplicative? Explain the seasonal
indices. In which month(s) do you see higher sales and which month(s) you see
lower sales? Any difference in the nature of demand for the two items?

4. Can you extract the residuals for the two decomposition exercises and check if
they form a stationary series? Do a formal test for stationarity writing down the
null and alternative hypothesis. What is your conclusion in each case?

5. Before the final forecast is undertaken one would like to compare a few models.
Use the last 21 months as hold-out sample fit a suitable exponential smoothing
model to the rest of the data and calculate MAPE. What are the values of α, β,
and γ? What role do they play in the modeling? For the same hold-out period
compare forecast by decomposition and compute MAPE. Which model gives
smaller MAPE? Give a comparison between the two demands.

6. Use the ‘best’ model obtained from above to forecast demand for the period Oct
2017 to December 2018 for both items. Provide forecasted values as well as their
upper and lower confidence limits. If you are the store manager what decisions
would you make after looking at the demand for the two items over years?
