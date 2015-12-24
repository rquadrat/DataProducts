.libPaths(c(.libPaths(), "/home/rodde/R/x86_64-pc-linux-gnu-library/3.2"))

require("forecast")
#require("rattle")

data("wineind")

lambda<-BoxCox.lambda(wineind)
model<-auto.arima(wineind, max.order=6, stepwise=T, approximation = T, lambda=lambda)
fc<-forecast(model, 24, fan=T)
stoptime<-tsp(fc$mean)[2]

shinyServer(
    function(input, output) 
    {
        output$Forecast <- renderPlot({
            fc<-forecast(model, input$fcperiod, fan=T, env)
            stoptime<<-tsp(fc$mean)[2]
            
            if (!is.null(input$TimeControl))
            {
                start<-input$TimeControl[1]
                end<-input$TimeControl[2]
            }
            else
            {
                start<-1980
                end<-stoptime
            }
            
            plot(fc, plot.conf=T, xlab="Time in years", ylab="Wine  sales in 1000 litres", xlim=c(start, end))#input$startdate
        })
        output$TimeControl<-renderUI({
            cat(stoptime)
            sliderInput('TimeControl', 'Start year of plotting interval', 1980, stoptime, c(1980,1996), 0.5)#, timeFormat = '%Y %m')
        })
    }
)

#auto.arima(max.order=6, stepwise=F, approximation = F, lambda=lambda)
# plot.conf=F