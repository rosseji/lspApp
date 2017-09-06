library(shiny)
library(plotly)
library(lsp)

ls <- read_rds("data/master_ls.rds")


shinyUI(fluidPage(
  
  # Application title
  titlePanel("ABS Preview Tool"),

  fluidPage(
    
    column(4, selectInput("sel_sheet",
                "Select a Catalogue Number",
                choices = names(ls))),
    column(2,uiOutput("sel_series_type_out")),
    column(4, uiOutput("sel_var_out")),
    column(2,checkboxInput("legend_toggle",
                  "Toggle Legend",
                  value = T))
  ),
  
  plotlyOutput("plot", width = "100%", height = 700)
))