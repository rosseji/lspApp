library(shiny)
library(plotly)
library(lsp)

files <- list.files("examples") %>%
  map( ~ list(
    name = str_replace(.x, ".xls", ""),
    file_path =  glue("examples/{.x}")
  )) %>%
  set_names(map_chr(., "name"))


ls <- files %>%
  map( ~ process_sheet(.x))



# ls$`310101`$working_tbl$Original$
# 
# pluck(ls, "310101", "working_tbl") %>% names()
# 
# names(ls$`310101`$working_tbl)

shinyUI(fluidPage(

  # Application title
  titlePanel("ABS Tool"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("sel_sheet",
                  "Select a Catalogue Number",
                  choices = names(ls)),
      uiOutput("sel_series_type_out"),
      uiOutput("sel_var_out")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("plot")
    )
  )
))
