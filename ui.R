library(shiny)
library(plotly)
library(lsp)

ls <- read_rds("data/master_ls.rds")


shinyUI(fluidPage(
  
  # Application title
  titlePanel("ABS Preview Tool"),
  
  plotlyOutput("plot", width = "100%", height = 700),
  
  fluidPage(
    
    column(4, selectInput("sel_sheet",
                "Select a Catalogue Number",
                choices = names(ls))),
    column(4,uiOutput("sel_series_type_out")),
    column(4, uiOutput("sel_var_out")),
    checkboxInput("legend_toggle",
                  "Toggle Legend",
                  value = T)
  )
  
))