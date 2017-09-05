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







shinyServer(function(input, output) {

  observeEvent(input$sel_sheet, {
    
    output$sel_series_type_out <-  renderUI({
     
      selectInput("sel_series_type_in",
                  "Select a Catalogue Number",
                  choices = pluck(ls, input$sel_sheet , "working_tbl") %>% names())
       
    })
    
    
    observeEvent(input$sel_series_type_in, {
      
      output$sel_var_out <-  renderUI({
        
        selectInput("sel_var_in",
                    "Select a Type",
                    choices = pluck(ls, input$sel_sheet,"working_tbl", input$sel_series_type_in) %>% names(),
                    multiple = T)
        
      })
  
    })
    
  })
  
  
  output$plot <- renderPlotly({
    df <- pluck(ls, input$sel_sheet, "working_tbl", input$sel_series_type_in) %>% 
      gather(cat, var, 3:length(.)) %>% 
      filter(cat %in% c(input$sel_var_in))
      
     
      ggplot(df, aes(x = Date, y = as.numeric(var), col = cat, group = cat)) +
        geom_line()
      
      ggplotly()
  })
    
  
  
})
