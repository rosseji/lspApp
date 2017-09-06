
library(shiny)
library(plotly)
library(lsp)


ls <- read_rds("data/master_ls.rds")



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
                    selected = pluck(ls, input$sel_sheet,"working_tbl", input$sel_series_type_in) %>% names() %>% head(3) %>% tail(1),
                    multiple = T)
        
      })
  
    })
    
  })
  
  
  output$plot <- renderPlotly({
    df <- pluck(ls, input$sel_sheet, "working_tbl", input$sel_series_type_in) %>% 
      gather(cat, var, 3:length(.)) %>% 
      filter(cat %in% c(input$sel_var_in))
      
     
      p <- ggplot(df, aes(x = Date, y = as.numeric(var), col = cat, group = cat)) +
        geom_line()
    
      
      if(input$legend_toggle) {
        ggplotly(p)
      }  else {
        ggplotly(p) %>% 
          layout(showlegend = FALSE)
      }
      
      
      
      
  })
    
  
  
})
