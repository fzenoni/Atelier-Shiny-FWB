library(shiny)

# Define UI ----
ui <- page_fluid(

  textInput("nom",
           "Votre nom"),
  selectInput("cat",
              "Catégorie",
              choices = c("Générale", "Développement", "Déploiement")),
  textAreaInput("question", "Question"),
  actionButton("bouton", "Envoyer")


)

# Define server (empty) ----
server <- function(input, output, session) {
}

# Create Shiny app ----
shinyApp(ui, server)
