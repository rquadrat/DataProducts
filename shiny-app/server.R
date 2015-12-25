require("forecast")
require("lubridate")

data("wineind")

shinyServer(
    function(input, output, session) 
    {
        getmodel<-reactive({
            islambda<-input$UseBoxCox
            
            if (islambda)
            {
                lambda<-BoxCox.lambda(wineind)
            }
            else
            {
                lambda<-NULL
            }
            
            model<-auto.arima(wineind, max.order=6, stepwise=T, approximation = T, lambda=lambda)
            
            model
        })
        
        output$Forecast <- renderPlot({
            fc<-forecast(getmodel(), input$fcperiod, fan=T)
            stoptime<<-tsp(fc$mean)[2]
            
            start<-input$TimeControl[1]
            end<-input$TimeControl[2]
            
            model<-reactive
            
            updateSliderInput(session, 'TimeControl', max=date_decimal(stoptime))
            
            if (input$Errorbars=="Errors")
            {
                error<-T
            }
            else
            {
                error<-F
            }
            
            plot(fc, plot.conf=error, xlab="Time in years", ylab="Wine  sales in 1000 litres", xlim=c(decimal_date(start), decimal_date(end)))#input$startdate
        })
        
        output$TimeControl<-renderUI({
            sliderInput('TimeControl', 'Start year of plotting interval', date_decimal(1980), date_decimal(stoptime), c(date_decimal(1980), date_decimal(stoptime)),
                        timeFormat = "%Y %b") #, timeFormat = '%Y %m')
        })
    }
)