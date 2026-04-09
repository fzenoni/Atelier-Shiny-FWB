library(shiny)
library(bslib)

ui <- page_fluid(
  h2("Sondage Shiny"),
  layout_columns(
    col_widths = c(6, 6),
    div(
      sliderInput(
        "exp",
        "Expérience de 0 (novice) à 5 (expert)",
        min = 0,
        max = 5,
        value = 2
      ),
      selectInput(
        "usage",
        "J'écris des applications Shiny...",
        choices = c(
          "tous les jours",
          "toutes les semaines",
          "tous les mois",
          "tous les ans"
        )
      ),
      hr(),
      checkboxInput("preference", "Je préfère Power BI à Shiny."),
      textAreaInput(
        "apprendre",
        "Sur quel sujet voudriez-vous en savoir plus ?"
      )
    ),
    div(
      plotOutput("plt")
    )
  ),
  actionButton("envoyer", "Envoyer")
)

server <- function(input, output, session) {}

shinyApp(ui, server)
