library(shiny)
library(httr)
library(jsonlite)

# Função para obter a lista de Pokémon
get_pokemon_list <- function() {
  url <- "https://pokeapi.co/api/v2/pokemon?limit=151" # Limitar aos primeiros 151 Pokémon
  response <- GET(url)
  data <- content(response, as = "parsed")
  pokemon_names <- sapply(data$results, function(p) p$name)
  return(pokemon_names)
}

# Função para obter os detalhes de um Pokémon específico
get_pokemon_details <- function(pokemon_name) {
  url <- paste0("https://pokeapi.co/api/v2/pokemon/", pokemon_name)
  response <- GET(url)
  data <- content(response, as = "parsed")
  return(data)
}

# Função para calcular uma "pontuação de batalha" com base nos atributos principais
calculate_battle_score <- function(stats) {
  score <- sum(sapply(stats, function(stat) stat$base_stat))
  return(score)
}

# UI do Shiny
ui <- fluidPage(
  titlePanel("Comparação de Batalha entre Pokémon"),
  sidebarLayout(
    sidebarPanel(
      selectInput("pokemon1", "Escolha o Primeiro Pokémon:", choices = get_pokemon_list()),
      selectInput("pokemon2", "Escolha o Segundo Pokémon:", choices = get_pokemon_list()),
      actionButton("compare", "Comparar Pokémon")
    ),
    mainPanel(
      h3("Comparação de Pokémon"),
      fluidRow(
        column(6,
               h4("Pokémon 1"),
               textOutput("pokemon1_name"),
               textOutput("pokemon1_hp"),
               textOutput("pokemon1_attack"),
               textOutput("pokemon1_defense"),
               textOutput("pokemon1_speed"),
               uiOutput("pokemon1_image")
        ),
        column(6,
               h4("Pokémon 2"),
               textOutput("pokemon2_name"),
               textOutput("pokemon2_hp"),
               textOutput("pokemon2_attack"),
               textOutput("pokemon2_defense"),
               textOutput("pokemon2_speed"),
               uiOutput("pokemon2_image")
        )
      ),
      h3("Resultado da Comparação"),
      textOutput("battle_result")
    )
  )
)

# Server do Shiny
server <- function(input, output, session) {
  
  # Observador para realizar a comparação quando o botão é pressionado
  observeEvent(input$compare, {
    # Obter detalhes dos dois Pokémon selecionados
    pokemon1_details <- get_pokemon_details(input$pokemon1)
    pokemon2_details <- get_pokemon_details(input$pokemon2)
    
    # Exibir informações do Pokémon 1
    output$pokemon1_name <- renderText({ paste("Nome:", pokemon1_details$name) })
    output$pokemon1_hp <- renderText({ paste("HP:", pokemon1_details$stats[[1]]$base_stat) })
    output$pokemon1_attack <- renderText({ paste("Ataque:", pokemon1_details$stats[[2]]$base_stat) })
    output$pokemon1_defense <- renderText({ paste("Defesa:", pokemon1_details$stats[[3]]$base_stat) })
    output$pokemon1_speed <- renderText({ paste("Velocidade:", pokemon1_details$stats[[6]]$base_stat) })
    output$pokemon1_image <- renderUI({
      tags$img(src = pokemon1_details$sprites$front_default, height = "150px", width = "150px")
    })
    
    # Exibir informações do Pokémon 2
    output$pokemon2_name <- renderText({ paste("Nome:", pokemon2_details$name) })
    output$pokemon2_hp <- renderText({ paste("HP:", pokemon2_details$stats[[1]]$base_stat) })
    output$pokemon2_attack <- renderText({ paste("Ataque:", pokemon2_details$stats[[2]]$base_stat) })
    output$pokemon2_defense <- renderText({ paste("Defesa:", pokemon2_details$stats[[3]]$base_stat) })
    output$pokemon2_speed <- renderText({ paste("Velocidade:", pokemon2_details$stats[[6]]$base_stat) })
    output$pokemon2_image <- renderUI({
      tags$img(src = pokemon2_details$sprites$front_default, height = "150px", width = "150px")
    })
    
    # Calcular uma pontuação de batalha para cada Pokémon
    pokemon1_score <- calculate_battle_score(pokemon1_details$stats)
    pokemon2_score <- calculate_battle_score(pokemon2_details$stats)
    
    # Determinar o vencedor
    if (pokemon1_score > pokemon2_score) {
      result <- paste("O vencedor provável é:", pokemon1_details$name)
    } else if (pokemon2_score > pokemon1_score) {
      result <- paste("O vencedor provável é:", pokemon2_details$name)
    } else {
      result <- "É um empate!"
    }
    output$battle_result <- renderText({ result })
  })
}

# Executar o app Shiny
shinyApp(ui, server)
