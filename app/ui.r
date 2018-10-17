library(shiny)

navbarPage(
    title='My First Shiny App',
    tabPanel(
        title='First Page',
        'Hello, there'
    ),
    tabPanel(
        title='Second Page',
        'You must be going'
    )
)