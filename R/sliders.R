text_slider_module_ui = function(id, state, label, content) {
  ns = shiny::NS(id)

  if (is.na(state))
    state = label[1]

  shiny::div(
    shiny::div(
      style = "display: inline-block; vertical-align: middle; max-width: 25%; min-width: 20%; padding-right: 1.5rem;",
      shinyWidgets::sliderTextInput(
        ns("text_slider"),
        label = NULL,
        choices = label,
        # assuming content is a vector?
        selected = state
      )
    ),
    shiny::div(style = "display: inline-block; vertical-align: middle; padding-top: 2%; max-width: 62%",
               content)
  )
}

text_slider_module_server = function(input, output, session, state, reactive_input = TRUE){
  ns = session$ns

  if(reactive_input){
    shiny::observeEvent(state(), {
      shinyWidgets::updateSliderTextInput(session, "slider_text", selected = state())
    })
  }

  observe(print(input$text_slider))
  return(shiny::reactive(input$text_slider))
}



text_slider_pair_module_ui = function(id, state, label, content) {
  ns = shiny::NS(id)

  if(is.na(state)) state = 0
  customSliderInput(ns('slider'), state, as.character(label), as.character(content))
#
#   shiny::div(
#     shiny::div(
#       style = "display: inline-block; vertical-align: middle; max-width: 25%; min-width: 20%; padding-right: 1.5rem;",
#       shiny::sliderInput(ns('slider'), label = label, min = 0, max = 100, value = state)
#     ),
#     shiny::div(
#       style = "display: inline-block; vertical-align: middle; padding-top: 2%; width: 10%;",
#       shiny::numericInput(ns("text"), label = '', min = 0, max = 100, value = state)
#     ),
#     shiny::div(
#       style = "display: inline-block; vertical-align: middle; padding-top: 2%; max-width: 62%",
#       content
#     )
#   )
}

text_slider_pair_module_server = function(input, output, session, state, reactive_input = TRUE) {
  ns = session$ns
  # if(reactive_input){
  #   shiny::observeEvent(state(), {
  #     shiny::updateSliderInput(session, "slider", value = max(0, round(state())))
  #     shiny::updateNumericInput(session, "text", value = max(0, round(state())))
  #   })
  # }else {
  #   if(is.na(state)) {
  #     state = 0
  #   }
  # }
  #
  # slider_d = shiny::reactive(input$slider) %>% shiny::throttle(500)
  # text_d = shiny::reactive(input$text) %>% shiny::throttle(500)
  #
  # shiny::observeEvent(slider_d(),{
  #   # print("slider moved")
  #   shiny::updateNumericInput(session, 'text', value = input$slider)
  # })
  # shiny::observeEvent(text_d(), {
  #   shiny::updateSliderInput(session, "slider", value = input$text)
  # })
  #
  # observe({
  #   if(is.null(slider_d())){
  #     print("null slider")
  #   }
  # })
  return(
    # reactive(slider_d())
    reactive(as.numeric(input$slider$state))
  )
}


sliders_group_module_ui = function(id = 'test', state = c(20,20,40), label = paste("Slider", 1:3), content = rep('', length(label))) {
  ns = shiny::NS(id)
  labels = label
  text_content = purrr::map2(labels, content, function(x, y) {
    glue::glue("
               **{x}**

               {y}
               ")
  })

  shiny::tagList(
    # shinyjs::useShinyjs(),
    # text_slider_pair_module_ui(ns('slider1'), state[1], labels[1], text_content[[1]]),
    # text_slider_pair_module_ui(ns('slider2'), state[2], labels[2], text_content[[2]]),
    # text_slider_pair_module_ui(ns('slider3'), state[3], label[3], text_content[[3]])
    customSliderTripleInput(ns('sliders'), state = state, label = as.character(label), content = as.character(text_content))
  )
}

sliders_group_module_server = function(input, output, session, state = c(20, 20, 40)) {
  # observeEvent(state(),{
  #   print('initialise group state')
  #   my_state = state()
  #   reactive_state$s1 = my_state[1]
  #   reactive_state$s2 = my_state[2]
  #   reactive_state$s3 = my_state[3]
  # })
  #
  # reactive_state = shiny::reactiveValues(
  #   s1 = NULL,# state[1],
  #   s2 = NULL,# state[2],
  #   s3 = NULL# state[3]
  # )
  #
  # return_val = reactive({
  #   # req(reactive_state$s1)
  #   # req(reactive_state$s2)
  #   # req(reactive_state$s3)
  #   c(reactive_state$s1, reactive_state$s2, reactive_state$s3)
  # })
  # observe({
  #   req(reactive_state$s1)
  #   req(reactive_state$s2)
  #   req(reactive_state$s3)
  #   print(paste("trip reactive state: ", c(reactive_state$s1, reactive_state$s2, reactive_state$s3)))
  #   # print(c(reactive_state$s1, reactive_state$s2, reactive_state$s3))
  # })
  #
  # slider1 = shiny::callModule(text_slider_pair_module_server, "slider1", state = shiny::reactive(reactive_state$s1))
  # slider2 = shiny::callModule(text_slider_pair_module_server, "slider2", state = shiny::reactive(reactive_state$s2))
  # slider3 = shiny::callModule(text_slider_pair_module_server, "slider3", state = shiny::reactive(reactive_state$s3))
  #
  # get_ratio = function(a, b) {
  #   if(a == 0 & b == 0) {
  #     vals = c(0.5, 0.5)
  #   } else if(b == 0) {
  #     vals = c(1,0)
  #   } else {
  #     vals = c(a/b, 1)/(1 + a/b)
  #   }
  #   return(vals)
  # }
  #
  # observe({
  #   req(slider1())
  #   req(slider2())
  #   req(slider3())
  #   print(paste("trip slider", slider1(), slider2(), slider3()))
  # })
  #
  # total_1_2 = shiny::reactive({
  #   req(slider1())
  #   req(slider2())
  #   slider1() + slider2()
  # })
  #
  # ratio_2_3 = shiny::reactive({
  #   req(slider3())
  #   req(slider2())
  #   get_ratio(slider2(), slider3())
  # })
  #
  # ratio_1_2 = shiny::reactive({
  #   req(slider1())
  #   req(slider2())
  #   get_ratio(slider1(), slider2())
  # })
  #
  # # allow_auto_trigger = reactiveVal(TRUE)
  #
  # shiny::observeEvent(slider1(),{
  #   isolate({multipliers = ratio_2_3()
  #   available = 100 - slider1()
  #   vals = multipliers*available
  #
  #   # detect if both same value and both x.5
  #   # print(vals)
  #   # print(vals[1] == vals[2])
  #   # print((vals[1]*2) %% 2)
  #   # print((vals[2]*2) %% 2)
  #
  #   if(vals[1] == vals[2] & (vals[1]*2) %% 2 & (vals[2]*2) %% 2) {
  #     vals[1] = floor(vals[1])
  #     vals[2] = ceiling(vals[2])
  #   }
  #
  #   reactive_state$s1 = slider1()
  #   reactive_state$s2 = vals[1]
  #   reactive_state$s3 = vals[2]})
  # })
  #
  # shiny::observeEvent(slider2(), {
  #   isolate({max = 100 - slider1()
  #   if(slider2() > max) {
  #     reactive_state$s2 = max + rnorm(1,0,0.001)
  #     # reactive_state$s2 = max-0.1
  #   }
  #   reactive_state$s3 = 100 - slider1() - slider2()})
  # })
  #
  # shiny::observeEvent(slider3(), {
  #   shiny::isolate({
  #     max = 100 - slider1()
  #     print(max)
  #     if(slider3() > max) {
  #       print("slider 3 true")
  #       reactive_state$s3 = max + rnorm(1,0,0.001)
  #       # reactive_state$s3 = max + 0.1
  #       reactive_state$s2 = 0
  #     }else{
  #       reactive_state$s2 = 100  - slider1() - slider3()
  #     }
  #   })
  # })

  return({
    # print(paste("res length", length(isolate(return_val()))))
    # return_val
    reactive(as.numeric(unlist(input$sliders$state)))
  })
}


# ## example
# state = c(20, 20, 40)
# ui = shiny::bootstrapPage(
#   sliders_group_module_ui('test', state = state)
# )
#
# server = function(input, output, session) {
#   x = callModule(sliders_group_module_server, 'test', state = state)
#   observe({
#     print(x())
#   })
# }
#
# shiny::shinyApp(ui, server)
