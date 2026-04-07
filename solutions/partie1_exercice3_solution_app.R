library(shiny)
library(bslib)

# UI
ui <- page_fluid(
  navset_tab(
    nav_panel(
      "Onglet 1",
      layout_sidebar(
        sidebar = sidebar(
          title = "Paramètres",
          checkboxGroupInput(
            "cbx",
            "Fonctionnalités",
            choices = c("1", "2", "3")
          )
        ),
        card(
          card_header("Info"),
          p("... quelques infos ...")
        )
      )
    ),
    nav_panel(
      "Onglet 2",
      img(src = "logo_FWB_couleur.png")
    )
  )
)

# Server
server <- function(input, output, session) {
  # empty for now
}

shinyApp(ui, server)
