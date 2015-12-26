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
* The data is a R timeseries object with a frequency of 12

The data for the first three years (in thousand litres) is:

```
##        Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec
## 1980 15136 16733 20016 17708 18019 19227 22893 23739 21133 22591 26786 29740
## 1981 15028 17977 20008 21354 19498 22125 25817 28779 20960 22254 27392 29945
## 1982 16933 17892 20533 23569 22417 22084 26580 27454 24081 23451 28991 31386
```


---

## Application Idea

The Goal is the forecast of future bottled wine sales in Australia.  
A special class of time series modelling functions is applied: An ARIMA model.  
  
A non-seasonal ARIMA model is defined by the following equation:
$$ y'_{t} = c + \phi_{1}y'_{t-1} + \cdots + \phi_{p}y'_{t-p} + \theta_{1}e_{t-1} + \cdots + \theta_{q}e_{t-q} + e_{t}$$
(Look [here](https://www.otexts.org/fpp/8/5) for more explanations.)  
The degrees of the ARIMA model are determined with the forecast::auto.arima() function. The best model is selected based on the AICc criterium (The lower, the better).


```r
model<-auto.arima(wineind, max.order=6, stepwise=T, approximation = T)
```

```
## [1] "Coefficients of model:"
##        ar1        ma1        ma2       sma1 
##  0.4298680 -1.4673462  0.5339475 -0.6600360
```

--- 

## The Shiny application - Functional aspects
### Functional scope
The shiny Application interactively shows the forecast of Australian bottled wine sales:
* The forecast period can be chosen between 5 and 200 month
* You can comapre models with and without Box-Cox transformation of the data
* For a detailed view the plotted timespan can be adjusted
* The forecast can be plotted with and without confidence intervals 

### Further Improvements
* Make the training dataset selectable
* Selection of testset to compare forecast and real data
* Include external regressors in ARIMA model and show the effect on forecast

---

## The Shiny application - Technical aspects
<br>
* The model calculation is the most computational intensive part:
    + Therefore the model calculation is made reactive
    + Model is only calculated when Box-Cox CheckBox input changes  
<br>
* Cross-dependence between the forecast length input and the plotting range slider:
    + When the forecast period changes also the accessible range of plotting range slider changes
    + Therefore the maximum of the slider range has to be reset
    + This is done via the updateSliderInput() function
    + Slider is rendered in server.R with renderUI() function

