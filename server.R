require(shiny)
require(ggplot2)
shinyServer(
      function(input, output) {
            output$fx <- renderText({
                  x5 <- ifelse(input$a5 == 0, "",
                               paste0(input$a5,"*x5 + "))
                  x4 <- ifelse(input$a4 == 0, "",
                               paste0(input$a4,"*x4 + "))
                  x3 <- ifelse(input$a3 == 0, "",
                               paste0(input$a3,"*x3 + "))
                  x2 <- ifelse(input$a2 == 0, "",
                               paste0(input$a2,"*x2 + "))
                  x1 <- ifelse(input$a1 == 0, "",
                               paste0(input$a1,"*x + "))
                  x0 <- input$a0 # nesessary simplification 
                                    # to avoid "plus" problem
                  paste0("f(x) = ",x5,x4,x3,x2,x1,x0)
            })
            output$int <- renderText({
                  paste0("x lies in an interval of [",
                         input$xlow, ":", input$xup, "]")
                  })
            output$plot <- renderPlot({
                  x <- seq(input$xlow, input$xup, by = 0.01)
                  y <- input$a5 * x^5 +
                        input$a4 * x^4 +
                        input$a3 * x^3 +
                        input$a2 * x^2 +
                        input$a1 * x +
                        input$a0
                  qplot(x, y) + ylab("f(x)")
            })
            output$roots <- renderText({
                  is_null_coef <- (input$a5 == 0 & input$a4 == 0 &
                                         input$a3 == 0 & input$a2 == 0 &
                                         input$a1 == 0 & input$a0 == 0)
                  if (is_null_coef) {
                        return ('Every x in the interval.')
                  } else {
                        x <- seq(input$xlow, input$xup, by = 0.01)
                        y <- input$a5 * x^5 +
                              input$a4 * x^4 +
                              input$a3 * x^3 +
                              input$a2 * x^2 +
                              input$a1 * x +
                              input$a0
                        roots <- numeric()
                        for (i in 1:length(x)) {
                              if (y[i] == 0) {
                                    roots <- c(roots,x[i])
                              }
                        }
                        for (i in 1:(length(x)-1)) {
                              if (y[i]*y[i+1] < 0) {
                                    roots <- c(roots, (x[i]+x[i+1])/2)
                              }
                        }
                        if (length(roots) == 0) {
                              return('No roots on the interval found.')
                        }
                        if (length(roots) == 1) {
                              return(paste0(
                                    'x = ',
                                    round(roots, digits = 1),
                                    ' is a root.'))
                        }
                        if (length(roots) > 1) {
                              roots_string <- as.character(
                                    round(roots[1], digits = 1))
                              for (i in 2:length(roots)) {
                                    roots_string <- paste0(
                                          roots_string,
                                          ", ",
                                          round(roots[i], digits = 1))
                              }
                              return(paste0(
                                    'x in {',
                                    roots_string,
                                    '} are roots.')) 
                        }
                  }
            })
      }
)