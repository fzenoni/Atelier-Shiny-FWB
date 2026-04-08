library(shiny)
library(bslib)
library(ggplot2)
library(dplyr)
library(tidyr)

data <- read.csv('foods.csv')
data <- data |> arrange(Food)
names(data) <- c(
  'Aliment',
  'Grammes',
  'Calories',
  'Protéines',
  'Graisses',
  'Graisses Sat.',
  'Fibres',
  'Glucides',
  'Catégorie'
)


ui <- page_sidebar(
  title = "Si vous ne deviez manger qu'un seul aliment... ",
  sidebar = sidebar(
    tags$label("Sélection", class = "fw-bold"),
    selectizeInput("food", "Choissez un aliment", choices = data[["Aliment"]]),
    selectizeInput(
      "quant",
      "Quantité journalière à égaler",
      choices = c("Glucides", "Graisses", "Calories")
    ),
    tags$label("Apport quotidien recommandé", class = "fw-bold mt-3"),
    sliderInput("carbs", "Glucides (g)", min = 10, max = 500, value = 250),
    sliderInput("protein", "Protéines (g)", min = 10, max = 200, value = 50),
    sliderInput("fat", "Graisses (g)", min = 10, max = 200, value = 60),
    sliderInput("calories", "kcal", min = 1000, max = 4000, value = 2000)
  ),
  card(card_header("Valeurs nutritionnelles"), plotOutput('plt'))
)

# Server
server <- function(input, output, session) {
  input_map <- c(
    "Glucides" = "carbs",
    "Graisses" = "fat",
    "Calories" = "calories",
    "Protéines" = "protein"
  )

  food <- reactive({
    data |>
      filter(Aliment == input$food) |>
      select(Grammes, Calories, Protéines, Graisses, Glucides) |>
      pivot_longer(everything(), names_to = "name") |>
      mutate(
        value = value /
          (filter(pick(everything()), name == input$quant) |> pull(value)) *
          input[[input_map[input$quant]]]
      )
  })

  target <- reactive({
    data.frame(
      name = c("Protéines", "Graisses", "Glucides"),
      value = c(input$protein, input$fat, input$carbs)
    )
  })

  output$plt <- renderPlot({
    grams <- food() |> filter(name == "Grammes") |> pull(value)
    ggplot() +
      geom_col(
        data = food() |>
          filter(name %in% c("Protéines", "Graisses", "Glucides")),
        aes(x = name, y = value, fill = "Nutriments totaux consommés")
      ) +
      geom_col(
        data = target(),
        aes(x = name, y = value, color = "Apport recommandé"),
        fill = NA,
        linewidth = 1.5
      ) +
      scale_fill_manual(values = c("Nutriments totaux consommés" = "#ff843d")) +
      scale_color_manual(values = c("Apport recommandé" = "#007bc2")) +
      labs(
        title = paste("Quantité :", round(grams, 0), "g"),
        x = "Nutriment",
        y = "Grammes",
        fill = NULL,
        color = NULL
      ) +
      theme_minimal() +
      theme(legend.position = "bottom")
  })
}

shinyApp(ui, server)
