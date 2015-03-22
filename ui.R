require(shiny)
require(ggplot2)
shinyUI(pageWithSidebar(
      headerPanel("Plotting polynomial function graphs on an interval"),
      sidebarPanel(
            p(strong('I want to render your graph,
              please provide me with your input!')),
            p('I would like to know the coefficients of the polynom.'),
            numericInput("a5",
                         label = p('coefficient of x',tags$sup(5),':'),
                         value = 0),
            numericInput("a4",
                         label = p('coefficient of x',tags$sup(4),':'),
                         value = 0),
            numericInput("a3",
                         label = p('coefficient of x',tags$sup(3),':'),
                         value = 0),
            numericInput("a2",
                         label = p('coefficient of x',tags$sup(2),':'),
                         value = 0),
            numericInput("a1",
                         label = p('coefficient of x',':'),
                         value = 0),
            numericInput("a0",
                         label = p('constant',':'),
                         value = 0),
            p('And I would also like to know the interval for',strong('x.')),
            sliderInput("xlow", label = "Lower bound for x:",
                        min = -100, max = -1, value = -50),
            sliderInput("xup", label = "Upper bound for x:",
                        min = 1, max = 100, value = 50)
      ),
      mainPanel(
            p('Hi! I am an app for building polynomial function graphs.
              The functions I support are polynoms of one variable',
              strong('(x).'),
              'The maximum power of a polynom I support is 5.'),
            p('As a nice additional feature, I also estimates the roots of the
              function on the same interval. Woo-hoo! Please note that the
              roots are rounded to the first decimal place.'),
            p('I am very straightforward to use:'),
            tags$ol(
                  tags$li("Input the coefficients of your polynomial function",
                          strong('f(x).'),
                          "If you want polynoms of a power lesser than 5,
                          input zeros as coefficients
                          of the higher powers of x"), 
                  tags$li("Choose the interval for x on which the graph
                          will be displayed. As I love when a graph crosses
                          the vertical axis, a lower boundary is always
                          negative, while the upper boundary is
                          always positive. The widest interval I support is
                          [-100:100], while the narrowest is [-1:1].")
            ),
            textOutput("fx"),
            textOutput("int"),
            plotOutput("plot"),
            p(strong('Roots:'),textOutput("roots"))
      )
))