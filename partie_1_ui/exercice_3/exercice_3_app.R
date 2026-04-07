library(shiny)
library(bslib)

# UI
ui <- page_fluid(
  navset_tab(
    # Insérez le code ici
  )
)

# Server
server <- function(input, output, session) {}

shinyApp(ui, server)
