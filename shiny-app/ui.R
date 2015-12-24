shinyUI(
    fluidPage(
        # Application title
        headerPanel("Australian wine sale production"),
        sidebarPanel(
            h3('Please Provide Parameter settings:'),
            br(),
            numericInput('fcperiod', 'Forecast length in months', 24, min = 5, max = 200, step = 1),
            uiOutput("TimeControl"),
            checkboxInput('UseBoxCox', "Use Box-Cox Transformation for input data", value=T),
            radioButtons('Errorbars', 'Show Prediction Errorbars', c("Errors", "No errors"), selected="Errors", inline=T)
            #submitButton('Update view', icon("refresh"))
        ),
        mainPanel(
            h3('Time series with forecast'),
            plotOutput('Forecast'),
            h4('Which resulted in a prediction of')
        )
    )
)