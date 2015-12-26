---
title       : Forecasting Australian wine sales
subtitle    : Using the forecast and shiny packages
author      : rquadrat
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Data Description

* The data is included in the R forecast package
* Data can be found at [datamarket.com](https://datamarket.com/data/set/22q2/monthly-australian-wine-sales-thousands-of-litres-by-wine-makers-in-bottles-1-litre)
* It contains Australian total wine sales by wine makers in bottles smaller and equal to 1 litre
* Data is from January 1980 to August 1994

The first few entries (in thousand litres) are:

```
##        Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec
## 1980 15136 16733 20016 17708 18019 19227 22893 23739 21133 22591 26786 29740
## 1981 15028 17977 20008 21354 19498 22125 25817 28779 20960 22254 27392 29945
## 1982 16933 17892 20533 23569 22417 22084 26580 27454 24081 23451 28991 31386
```


---

## Applied model

The Goal is the forecast of future wine sales in Australia. 
A special class of time series modelling functions is applied: 
A non-seasonal ARIMA model is defined by:
$$ y'_{t} = c + \phi_{1}y'_{t-1} + \cdots + \phi_{p}y'_{t-p} + \theta_{1}e_{t-1} + \cdots + \theta_{q}e_{t-q} + e_{t}$$
The degrees of the ARIMA model are determined with the forecast::auto.arima() function. The best model is selected based on the AICc criterium (The lower the better)

```r
model<-auto.arima(wineind, max.order=6, stepwise=T, approximation = T)
```

```
## [1] "Coefficients of model:"
##        ar1        ma1        ma2       sma1 
##  0.4298680 -1.4673462  0.5339475 -0.6600360
```

---

## The shiny application
* Allows

---

## Further Improvements

* Other model as ets or tbats can be used for comparison
* a dataset could be made selective 
* include testset for forecast quality validation
