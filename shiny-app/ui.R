shinyUI(
    fluidPage(
        # Application title
        headerPanel("Australian wine sale production forecast"),
        sidebarPanel(
            h3('Please Provide Parameter settings:'),
            br(),
            numericInput('fcperiod', 'Forecast length in months', 24, min = 5, max = 200, step = 1),
            uiOutput("TimeControl"),
            checkboxInput('UseBoxCox', "Use Box-Cox transformation for input data", value=T),
            radioButtons('Errorbars', 'Show Prediction Errorbars', c("Errors", "No errors"), selected="Errors", inline=T),
            br(),
            p(h5("Just provide the parameters in arbitrary order. Whenever a parameter changes the output plot 
                 is updated. When you change the number of month forecasted, the plotting interval selection slider 
                 will be adapted to the changed properties."))
        ),
        mainPanel(
            h3('Time series with forecast'),
            plotOutput('Forecast'),
            p(h5("The provided historical data is plotted as a black line.",
                 "The forecast data is plotted as a blue line. The caption of the plot shows which ARIMA model 
                 was chosen by the auto.arima() function",
                 "The errorbars are shown from blue to gray. Blue are the lower confidence level bounds and 
                 gray are the higher confidence level bounds. The lightest gray is a confidence level of 99 %."))
        )
    )
)