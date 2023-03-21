# Welcome to our RShiny Game
# Group 22
# Engineering Systems and Architecture
# Authors: Jason, Suzanne, Divya and Damien

# Part 0: References
#https://shiny.rstudio.com/reference/shiny/latest/modalDialog.html
#https://shiny.rstudio.com/reference/shiny/0.14/passwordInput.html
#https://shiny.rstudio.com/articles/sql-injections.html
#https://shiny.rstudio.com/reference/shiny/0.14/renderUI.html
#https://stackoverflow.com/questions/43641103/change-color-actionbutton-shiny-r
#https://shiny.rstudio.com/gallery/timer.html
#https://subscription.packtpub.com/book/application_development/9781785280900/8/ch08lvl1sec53/the-www-directory
#https://stackoverflow.com/questions/37033302/imageoutput-click-within-conditionalpanel
#http://rstudio.github.io/shinydashboard/get_started.html
#https://stackoverflow.com/questions/53601495/overlaying-images-in-r-shiny
#https://cran.r-project.org/web/packages/magick/vignettes/intro.html#Cut_and_edit
#https://nik01010.shinyapps.io/dashboardThemeDesigner/

# Part 1: Initialize all required libraries
library(tidyverse)
library(shiny)          # for app development
library(DBI)            # for connection to database
library(jsonlite)
library(shinydashboard) # for app development
library(rsconnect)      # for connection to database
library(shinyjs)        # for app development
library(lubridate)      # for timer
library(RMySQL)         # for clearing the connections
library(dashboardthemes)
library(magick)

# Part 2: Clear Database Connection
cons <- dbListConnections(MySQL())
for(con in cons)dbDisconnect(con)

# Part 3: Connect to Database
# Credits to Prof Jackson
#getAWSConnection <- function(){
#  conn <- dbConnect(
#    drv = RMySQL::MySQL(),
#    dbname = "student086",
#    host = "esddbinstance-1.ceo4ehzjeeg0.ap-southeast-1.rds.amazonaws.com",
#    username = "student086",
#    password = 'D3SbEA6k'
#  )
#  conn
#}
getAWSConnection <- function(){
  conn <- dbConnect(
    drv = RMySQL::MySQL(),
    dbname = "esa",
    host = "localhost",
    username = "root",
    password = 'student086'
  )
  conn
}

# Part 4: Helper Functions
# General (No specific Tab) #####################################################
# Design of UI
# Credits to Suzanne and Divya
customTheme <- shinyDashboardThemeDIY(
  ### general
  appFontFamily = "Arial"
  ,appFontColor = "#122842"
  ,primaryFontColor = "#637285"
  ,infoFontColor = "#122842"
  ,successFontColor = "#8CC4DE"
  ,warningFontColor = "#FE793D"
  ,dangerFontColor = "#FB4C1F"
  ,bodyBackColor = "#EEE2DC"
  
  ### header
  ,logoBackColor = "#FE793D"
  
  ,headerButtonBackColor = "#FB4C1F"
  ,headerButtonIconColor = "#FFFFFF"
  ,headerButtonBackColorHover = "#122842"
  ,headerButtonIconColorHover = "#F0D0C7"
  
  ,headerBackColor = "#FE793D"
  ,headerBoxShadowColor = ""
  ,headerBoxShadowSize = "0px 0px 0px"
  
  ### sidebar
  ,sidebarBackColor = "#122842"
  ,sidebarPadding = "0"
  
  ,sidebarMenuBackColor = "transparent"
  ,sidebarMenuPadding = "5"
  ,sidebarMenuBorderRadius = 0
  
  ,sidebarShadowRadius = ""
  ,sidebarShadowColor = "0px 0px 0px"
  
  ,sidebarUserTextColor = "#122842"
  
  ,sidebarSearchBackColor = "#F0F0F0"
  ,sidebarSearchIconColor = "#646464"
  ,sidebarSearchBorderColor = "#DCDCDC"
  
  ,sidebarTabTextColor = "#F0D0C7"
  ,sidebarTabTextSize = "14"
  ,sidebarTabBorderStyle = "none"
  ,sidebarTabBorderColor = "none"
  ,sidebarTabBorderWidth = "0"
  
  ,sidebarTabBackColorSelected = "#C2D1E5"
  ,sidebarTabTextColorSelected = "#122842"
  ,sidebarTabRadiusSelected = "0px"
  
  ,sidebarTabBackColorHover = "#F0D0C7"
  ,sidebarTabTextColorHover = "#ED481A"
  ,sidebarTabBorderStyleHover = "none solid none none"
  ,sidebarTabBorderColorHover = "#FE793D"
  ,sidebarTabBorderWidthHover = "5"
  ,sidebarTabRadiusHover = "0px"
  
  ### boxes
  ,boxBackColor = "#FFFFFF"
  ,boxBorderRadius = "13"
  ,boxShadowSize = "none"
  ,boxShadowColor = ""
  ,boxTitleSize = "14"
  ,boxDefaultColor = "#C2D1E5"
  ,boxPrimaryColor = "#D5E3F5"
  ,boxInfoColor = "#C2D1E5"
  ,boxSuccessColor = "#70AD47"
  ,boxWarningColor = "#ED7D31"
  ,boxDangerColor = "#F76A43"
  
  ,tabBoxTabColor = "#C2D1E5"
  ,tabBoxTabTextSize = "14"
  ,tabBoxTabTextColor = "#5F9BD5"
  ,tabBoxTabTextColorSelected = "#122842"
  ,tabBoxBackColor = "#F8F8F8"
  ,tabBoxHighlightColor = "#C8C8C8"
  ,tabBoxBorderRadius = "5"
  
  ### inputs
  ,buttonBackColor = "#C2D1E5"
  ,buttonTextColor = "#122842"
  ,buttonBorderColor = "#C2D1E5"
  ,buttonBorderRadius = "5"
  
  ,buttonBackColorHover = "#F0D0C7"
  ,buttonTextColorHover = "#DE481B"
  ,buttonBorderColorHover = "#F0D0C7"
  
  ,textboxBackColor = "#FFFFFF"
  ,textboxBorderColor = "#767676"
  ,textboxBorderRadius = "5"
  ,textboxBackColorSelect = "#F5F5F5"
  ,textboxBorderColorSelect = "#6C6C6C"
  
  ### tables
  ,tableBackColor = "#F8F8F8"
  ,tableBorderColor = "#EEEEEE"
  ,tableBorderTopSize = "1"
  ,tableBorderRowSize = "1"
)

# Tab 1: Welcome ################################################################
# (1) Modal to Register New Player by taking inputs of password1 and password2
# Credits to Prof Jackson
passwordModal <- function(failed = FALSE) {
  modalDialog(
    title = "Create a new password",
    passwordInput(inputId = "password1", label = "Enter a new password:"),
    passwordInput(inputId = "password2", label = "Confirm by re-entering the new password:"),
    "If successful, you will be assigned a Player Name to go with this password.",
    if (failed)
      div(tags$b("The passwords do not match. Try again.", style = "color: red;")),
    
    footer = tagList(
      modalButton(label = "Cancel"),
      actionButton(inputId = "passwordok", label = "OK")
    )
  )
}

# (2) Modal to Login for Existing Player by taking inputs are playername and password3
# Credits to Prof Jackson
loginModal <- function(failed = FALSE) {
  modalDialog(
    title = "Login",
    textInput(inputId = "playername", label = "Enter your assigned Player Name", value = "KeenPrettyWeather"),
    passwordInput(inputId = "password3", label = "Enter your password:"),
    if (failed)
      div(tags$b("There is no registered player with that name and password. Try again or re-register.", style = "color: red;")),
    
    footer = tagList(
      modalButton(label = "Cancel"),
      actionButton(inputId = "loginok", label = "OK")
    )
  )
}

# (3) Modal to Change Password
# Credits to Divya
newpasswordModal <- function(failed = FALSE, failed2 = FALSE, failed3 = FALSE, failed4 = FALSE){
  modalDialog(
    title = "Create a new password",
    uiOutput(outputId = "newloggedInAs"),
    passwordInput(inputId = "oldpassword", label = "Enter your old password:"),
    passwordInput(inputId = "newpassword1", label = "Enter new password:"),
    passwordInput(inputId = "newpassword2", label = "Re-enter new password:"),
    if (failed)
      tags$strong("The old password is invalid.", style = "color:red;"),
    if (failed2)
      tags$strong("Please fill in all blanks.", style = "color:red;"),
    if (failed3)
      tags$strong("Passwords do not match.", style = "color:red;"),
    if (failed4)
      tags$strong("Select a new password.", style = "color:red;"),
    footer = tagList(
      modalButton(label = "Cancel"),
      actionButton(inputId = "newpasswordok", label = "Confirm")
    )
  )
}

# (4) Modal to display Hint
# Credits to Damien
hintModal <- function(failed = FALSE){
  modalDialog(
    htmlOutput(outputId = "hintgenerated"),
    if (failed)
      div(tags$b("no hint", style = "color: red;")),
    
    footer = tagList(
      modalButton(label = "Close"),
    )
  )
}

# (5) Extract Player Info from Database in Login Modal using playername and password
# Credits to Prof Jackson
getPlayerID <- function(playername, password){
  #open the connection
  conn <- getAWSConnection()
  #password could contain an SQL insertion attack
  #Create a template for the query with placeholders for playername and password
  querytemplate <- "SELECT * FROM PlayerInfo WHERE playername=?id1 AND password=?id2;"
  query<- sqlInterpolate(conn, querytemplate, id1 = playername, id2 = password)
  result <- dbGetQuery(conn, query)
  # If the query is successful, result should be a dataframe with one row
  if (nrow(result)==1){
    playerid <- result$playerid[1]
  } else {
    playerid <- 0
  }
  #Close the connection
  dbDisconnect(conn)
  # return the playerid
  playerid
}

# (6) Extract PlayerName from Database in Register Modal
# Credits to Prof Jackson
getRandomPlayerName <- function(conn){
  #Given a connection, call the View 'LeaderRandomName' and return the resulting name
  result <- dbGetQuery(conn, "SELECT * FROM LeaderRandomName")
  # result should be a dataframe with a single row and a column named 'playername'
  playername <- result$playername[1]
  # To test what happens when there is a duplicate entry, we can override the random result
  #playername <- "SophisticatedImaginaryZoo" # This matches an existing player in my database
  playername
}

# (7) Craft Query to Insert Player Info into Database in Register Modal
# Credits to Prof Jackson
createNewPlayerQuery <- function(conn, playername, password){
  #password could contain an SQL insertion attack
  #Create a template for the query with placeholder for  password
  querytemplate <- "INSERT INTO PlayerInfo (playername,password) VALUES (?id1,?id2);"
  query<- sqlInterpolate(conn, querytemplate, id1 = playername, id2 = password)
}

# (8) Insert Player Info into Database in Register Modal
# Credits to Prof Jackson
registerPlayer <- function(password){
  #open the connection
  conn <- getAWSConnection()
  playername <- getRandomPlayerName(conn)
  query <- createNewPlayerQuery(conn, playername, password)
  # This query could fail to run properly so we wrap it in a loop with tryCatch()
  success <- FALSE
  iter <- 0
  MAXITER <- 5
  while(!success & iter < MAXITER){
    iter <- iter + 1
    tryCatch(
      {  # This is not a SELECT query so we use dbExecute
        result <- dbExecute(conn,query)
        success <- TRUE
      }, error=function(cond){print("registerPlayer: ERROR")
        print(cond)
        # The query failed, likely because of a duplicate playername
        playername <- getRandomPlayerName(conn)
        query <- createNewPlayerQuery(conn, playername, password) }, 
      warning=function(cond){print("registerPlayer: WARNING")
        print(cond)},
      finally = {print(paste0("Iteration ", iter, " done."))
      }
    )
  } # end while loop
  # This may not have been successful
  if (!success) playername = NULL
  #Close the connection
  dbDisconnect(conn = conn)
  playername
}

# (9) Change Password in Login Modal
# Credits to Divya
updatePassword <- function(playername, password){
  # open the connection
  conn <- getAWSConnection()
  # execute query
  querytemplate <- "UPDATE PlayerInfo SET password=?id1 WHERE playername=?id2"
  query <- sqlInterpolate(conn, querytemplate, id1 = password, id2 = playername)
  #print(query) #for debug
  result <- dbGetQuery(conn, query)
  
  # close the connection
  dbDisconnect(conn = conn)
  result
}

# Tab 2: Game ##################################################################
# (1) Extract Question Text
# Credits to Jason
getNextQuestion <- function(questionid = NULL){
  conn <- getAWSConnection()
  query <- paste("SELECT * FROM QuestionBank WHERE questionid = ")
  query <- paste0(query, questionid)
  question <- dbGetQuery(conn, query)
  questionid <- question$questionid
  questiontext <- question$questiontext
  
  dbDisconnect(conn)
  print(questiontext)
  question <- data.frame(
    id = questionid,
    text = questiontext
  )
  question
}
# getNextQuestion(2)


# (2) Get Injury Image for Question and all related data (answers)
# Credits to Jason
getARandomInjury <- function(){
  conn <- getAWSConnection()
  gameinjury <- dbGetQuery(conn, "SELECT * FROM InjuryList ORDER BY RAND() LIMIT 1")
  injuryid <- gameinjury$injuryid # a vector
  injuryname <- gameinjury$injuryname # a vector
  injurytypeid <- gameinjury$injurytypeid
  injuryspecsid <- gameinjury$injuryspecsid
  filename <- gameinjury$filename
  emergency <- gameinjury$emergency
  treatment <- gameinjury$treatmentid
  treatmentsequence <- gameinjury$treatmentsequence
  bandageid <- gameinjury$bandageid
  #Close the connection
  dbDisconnect(conn)
  injury <- data.frame(
    id = injuryid,
    name = injuryname,
    type = injurytypeid,
    specs = injuryspecsid,
    file = filename,
    emergency = emergency,
    treatment = treatment,
    treatmentsequence = treatmentsequence,
    bandageid = bandageid)
  injury 
}
# getARandomInjury()$file

# (3) Randomize Question Options for Display
# Credits to Jason
# Function takes input to extract only options relevant to injury image instead of all options
getRandomizedGameOptionsList <- function(questionid = NULL, injurytypeid = NULL, treatmentid = NULL){
  conn <- getAWSConnection()
  
  #setting up the query to take from their respective tables in the database.
  if (questionid == 1){table = "InjuryType"}
  else if (questionid == 2){table = "InjurySpecifications"}
  else if (questionid == 3){table = "CallAmbulance"}
  else if (questionid == 4){table = "TreatmentOrder"}
  else if (questionid == 5){table = "BandageOptions"}
  query <- paste("SELECT * FROM ")
  query <- paste0(query, table, " ")
  
  #filtering options in their respective tables, based on the chosen injury's "grouping"
  if (questionid %in% c(1,3,5)){
    query <- paste0(query, "ORDER BY RAND()")
    gameoptions <- dbGetQuery(conn, query)
  }
  else if (questionid ==2 ){
    query <- paste0(query, "WHERE injurytypeid = ", injurytypeid)
    query <- paste0(query, " ORDER BY RAND()")
    gameoptions <- dbGetQuery(conn, query)
  }
  else if (questionid ==4 ){
    query <- paste0(query, "WHERE treatmentid = ", treatmentid)
    query <- paste0(query, " ORDER BY RAND()")
    gameoptions <- dbGetQuery(conn, query)
  }
  
  #We have the applicable options in our hand now, and we need to record their unique IDs and filenames.
  #so that we can verify answer choosing and display images
  if (questionid == 1){optionids <- gameoptions$injurytypeid}
  else if (questionid == 2){optionids <- gameoptions$injuryspecsid}
  else if (questionid == 3){optionids <- gameoptions$emergency}
  else if (questionid == 4){optionids <- gameoptions$treatmentstepid}
  else if (questionid == 5){optionids <- gameoptions$bandageid}
  
  optionimage <- gameoptions$filename
  dbDisconnect(conn)
  
  
  #if its the first 3 questions, we want to get the hint info also.
  if (questionid %in% c(1,2,3)){
    optionhints <- gameoptions$hintid
    options <- data.frame(
      id = optionids,
      image = optionimage,
      hint = optionhints)}
  else{
    options <- data.frame(
      id = optionids,
      image = optionimage)
  }
  options
}
# getRandomizedGameOptionsList(questionid=1,
#                              injurytypeid=1)

# (4) Extract Hint Text
# Credit to Damien
getHint <- function(hintid){
  conn <- getAWSConnection()
  querytemplate <- "SELECT hintdescription FROM Hint WHERE hintid=?id1;"
  query<- sqlInterpolate(conn, querytemplate, id1 = hintid)
  result <- dbGetQuery(conn, query)
  dbDisconnect(conn)
  result
}

# (5) Check Answer
# Credits to Jason
getSelectionChecked <- function(questionid, injuryid, selectedoptionid){
  conn <- getAWSConnection()
  
  if (questionid == 1){optionids <- "injurytypeid"}
  else if (questionid == 2){optionids <- "injuryspecsid"}
  else if (questionid == 3){optionids <- "emergency"}
  else if (questionid == 4){optionids <- "treatmentsequence"}
  else if (questionid == 5){optionids <- "bandageid"}
  
  #print(optionids)
  
  querytemplate <- "SELECT * FROM InjuryList WHERE "
  querytemplate <- paste0(querytemplate, optionids, " =?id1 AND injuryid=?id2;")
  query<- sqlInterpolate(conn, querytemplate, id1 = selectedoptionid, id2 = injuryid)
  result <- dbGetQuery(conn, query)
  # If the query is successful, result should be a dataframe with one row
  
  if (nrow(result)==1){
    questionid <- questionid
  } else {
    questionid = 0
  }
  #Close the connection
  dbDisconnect(conn)
  # return the questionid that was answered correctly
  if (questionid!= 0){
    out <- cat("questionid ", questionid, " answered correctly.")
    1}
  else {
    out <- cat("Wrong")
    0
  }
  
}
#The function returns 1 if the answer pair posed to it is answered correctly, and 0 if it's wrong.
#testing
# getSelectionChecked(1,3,1)
# getSelectionChecked(3,36,0)
# getSelectionChecked(4,1,"1,2,3,5,3,4")
# getSelectionChecked(4,1,"1,2,3,4")

# (6) Start New Game
# Credits to Jason
startNewGame <- function(playerid, playercolor, gamestate){
  # gamestate is a list of some sort so we convert it to a JSON string
  jsongamestate <-  paste0("'", toJSON(gamestate), "'")
  #open the connection
  conn <- getAWSConnection()
  #We could encounter an error or warning when we interact with the AWS database so enclose with a TryCatch()
  tryCatch({
    # A gamestate record may or may not exist for this player and gamevariant.
    # An UPDATE query will fail if no matching record exists.
    # An INSERT query may fail (because of duplicates) if a matching record exists.
    # So the safest action to DELETE all matching records and then INSERT a new one.
    query <-  paste0("DELETE FROM GameState WHERE playerid=", playerid)
    result <- dbExecute(conn, query)
    # Now we can insert a new record for this game.
    query <- paste0("INSERT INTO GameState (playerid,turnstate,jsongamestate) VALUES (")
    query <- paste0(query, playerid, ",", playercolor, ",", jsongamestate, ")")
    #print(query)
    result <- dbExecute(conn, query)
  },
  error=function(cond){print(paste0("startNewGame ERROR: ", cond))},
  warning=function(cond){print(paste0("startNewGame WARNING: ", cond))},
  finally={}
  )
  #Close the connection
  dbDisconnect(conn)
}

# (7) Start new Login Session
# Credits to Jason
startNewLoginSession <- function(playerid, playercolor, gamestate){
  # convert gamestate to a JSON string
  jsongamestate <- paste0("'", toJSON(gamestate), "'")
  # open the connection
  conn <- getAWSConnection()
  # We could encounter an error or warning when we interact with the AWS database so enclose with a TryCatch()
  tryCatch({
    # A gamestate record may or may not exist for this player and gamevariant.
    # An UPDATE query will fail if no matching record exists.
    # An INSERT query may fail (because of duplicates) if a matching record exists.
    # So the safest action to DELETE all matching records and then INSERT a new one.
    query <-  paste0("DELETE FROM GameState WHERE playerid=", playerid)
    result <- dbExecute(conn, query)
    # Now we can insert a new record for this game.
    query <- paste0("INSERT INTO GameState (playerid,turnstate,jsongamestate) VALUES (")
    query <- paste0(query, playerid, ",", playercolor, ",", jsongamestate, ")")
    #print(query)
    result <- dbExecute(conn, query)
  },
  error=function(cond){print(paste0("startNewLoginSession ERROR: ", cond))},
  warning=function(cond){print(paste0("startNewLoginSession WARNING: ", cond))},
  finally={}
  )
  #Close the connection
  dbDisconnect(conn)
}

# (8) Update Game To Reflect Changes to Both Screens
# Credits to Prof Jackson
updateGame <- function(playerid, turnstate, gamestate){
  # gamestate is a list of some sort so we convert it to a JSON string
  jsongamestate <-  paste0("'", toJSON(gamestate), "'")
  print(jsongamestate)
  #open the connection
  conn <- getAWSConnection()
  #We could encounter an error or warning when we interact with the AWS database so enclose with a TryCatch()
  tryCatch({
    # A gamestate record should exist for this player and gamevariant.
    # So an UPDATE query should be safe.
    query <- paste0("UPDATE GameState SET turnstate=", turnstate, ", jsongamestate=", jsongamestate)
    
    query <- paste0(query," WHERE playerid=", playerid)
    result <- dbExecute(conn, query)
  },
  error=function(cond){print(paste0("updateGame ERROR: ", cond))},
  warning=function(cond){print(paste0("updateGame WARNING: ", cond))},
  finally={}
  )
  #Close the connection
  dbDisconnect(conn)
}

# (9) Update Timer
# Credits to Suzanne
updateTimer <- function(playerid, timerstate){
  # gamestate is a list of some sort so we convert it to a JSON string
  jsongamestate2 <-  paste0("'", toJSON(timerstate), "'")
  print(jsongamestate2)
  #open the connection
  conn <- getAWSConnection()
  #We could encounter an error or warning when we interact with the AWS database so enclose with a TryCatch()
  tryCatch({
    # A gamestate record should exist for this player and gamevariant.
    # So an UPDATE query should be safe.
    query <- paste0("UPDATE GameState SET jsongamestate2=", jsongamestate2)
    
    query <- paste0(query," WHERE playerid=", playerid)
    result <- dbExecute(conn, query)
  },
  error=function(cond){print(paste0("updateTimer ERROR: ", cond))},
  warning=function(cond){print(paste0("updateTimer WARNING: ", cond))},
  finally={}
  )
  #Close the connection
  dbDisconnect(conn)
}

# (10) Game State to show Accurate Info across both screens
# Credits to Jason
getGameTurnAndState <- function(playerid){
  #open the connection
  conn <- getAWSConnection()
  query <- paste0("SELECT turnstate,jsongamestate, jsongamestate2 FROM GameState WHERE playerid=",playerid)
  result <- dbGetQuery(conn,query)
  turnAndState <- list(turnstate = NULL, gamestate = list(), timerstate = list())
  if (nrow(result)>0){
    turnAndState$turnstate <- result$turnstate[1]
    turnAndState$gamestate <- fromJSON(result$jsongamestate[1])
    turnAndState$timerstate <- fromJSON(result$jsongamestate2[1])
  }
  #Close the connection
  dbDisconnect(conn)
  turnAndState
  print(turnAndState)#for debug
}


# Tab 3: Leaderboard ##################################################################
# (1) Publish Timings
# Credits to Suzanne
publishScore <- function(playerid, score){
  conn <- getAWSConnection()
  querytemplate <- "INSERT IGNORE INTO FirstAidScore(playerid, score, asoftime) VALUES (?id1, ?id2, DATE_ADD(NOW(), INTERVAL 8 HOUR))"
  query <- sqlInterpolate(conn, querytemplate, id1 = playerid, id2 = score)
  
  success <- FALSE
  tryCatch(
    {  # This is not a SELECT query so we use dbExecute
      result <- dbExecute(conn,query)
      print("Score published")
      success <- TRUE
    }, error=function(cond){print("publishScore: ERROR")
      print(cond)
    }, 
    warning=function(cond){print("publishScore: WARNING")
      print(cond)},
    finally = {}
  )
  dbDisconnect(conn)
}

# (2) Assemble Leaderboard
# Credits to Suzanne
getLeaderBoard <- function(){
  conn <- getAWSConnection()
  # Assemble the query
  query <- "SELECT pi.playername,fas.score,fas.asoftime FROM FirstAidScore as fas INNER JOIN PlayerInfo as pi"
  query <- paste0(query, " ON (fas.playerid=pi.playerid)")
  # faster speed is a higher score
  query <- paste0(query, " ORDER BY fas.score ASC,fas.asoftime ASC LIMIT 20")
  print(query) # for debugging
  result <- dbGetQuery(conn, query)
  dbDisconnect(conn)
  result
}

# Part 5: UI
# Credits to Divya, Suzanne and Jason
ui <- dashboardPage(
    dashboardHeader(title = "Collabear-aides"),
    
    # Credits to Jason
    dashboardSidebar(
      sidebarMenu(
      #https://fontawesome.com/icons?d=gallery
      menuItem("Welcome", tabName = "welcome", icon = icon("door-open")),
      menuItem("Game", tabName = "game", icon = icon("medkit")),
      menuItem("Leaderboard", tabName = "leaderboard", icon = icon("medal"))),
      useShinyjs()
    ),
    
    dashboardBody(
      customTheme,
      tabItems(
        # First Tab of Welcome
        # Credits to Suzanne and Divya
        tabItem(tabName = "welcome",
                h2("Welcome to Group 22's First Aid Game: Collabear-Aides"),
                tags$br(),
                actionButton(inputId = "register", label = "Register"),
                actionButton(inputId = "login", label = "Login"),
                tags$br(),
                tags$br(),
                tags$h5("Logged in as:"),
                htmlOutput(outputId = "loggedInAs"),
                tags$br(),
                uiOutput(outputId = "morePassword"),
                uiOutput(outputId = "conclusion"),
                tags$br(),
                tags$b("Instructions"),
                tags$p("As Collabear-aides, you and your partner are tasked with saving your patient."), 
                tags$p("Get yourselves into the leaderboard of", tags$b("fastest aiders"), "by saving your patient as fast as you can!"), 
                tags$p("Be careful though! If you make a mistake, there’s a", tags$b("10-second penalty"), "to your score!"),
                tags$br(),
                tags$b("Steps to Play:"),
                tags$p("1. Log into the same account as your partner and go over to the Game Tab on the left."),
                tags$p("2. In the Game Tab, select your role for the game!"),
                tags$p("3. If you are identifying the injury, choose your Hint Mode! There is no hint for treating the injury so good luck!"),
                tags$p("4. If you are identifying the injury, once ready, click 'Start Game' to begin! Have fun!")),
        
        # Second Tab of Game
        # Credits to Divya
        tabItem(tabName = "game",
                useShinyjs(),
                tags$b("Welcome to the game!"),
                tags$br(),
                uiOutput(outputId = "roles"),
                tags$style(type = "text/css",
                           ".shiny-output-error { visibility: hidden; }",
                           ".shiny-output-error:before { visibility: hidden; }"
                ),
                tags$br(),
                uiOutput(outputId = "hints"),
                tags$br(),
                fluidRow(
                  box(
                    title = "Are you ready?", width = 12,
                    htmlOutput(outputId = "playercolorchoice"),
                    htmlOutput(outputId = "playerhintchoice"),
                    uiOutput(outputId = "timerControls"),
                    tags$br(),
                    uiOutput(outputId = "moreControls"), # Start button
                    tags$br(),
                    htmlOutput(outputId = "questiongenerated"),
                    imageOutput(outputId = "injurypic"),
                    tags$br(),
                    tags$br(),
                    tags$br(),
                    tags$br(),
                    tags$br(),
                    # Gameboard
                    # Credits to Jason
                    imageOutput(outputId = "cell11", click = "click11", hover = "hover11", inline = TRUE), # height and width are for the containing div, not the image itself
                    imageOutput(outputId = "cell12", click = "click12",hover = "hover12",inline = TRUE), 
                    imageOutput(outputId = "cell13", click = "click13",hover = "hover13",inline = TRUE), 
                    imageOutput(outputId = "cell14", click = "click14",hover = "hover14",inline = TRUE),  
                    tags$br(),
                    imageOutput(outputId = "cell21", click = "click21",hover = "hover21",inline = TRUE), 
                    imageOutput(outputId = "cell22", click = "click22",hover = "hover22",inline = TRUE),  
                    imageOutput(outputId = "cell23", click = "click23",hover = "hover23",inline = TRUE), 
                    imageOutput(outputId = "cell24", click = "click24",hover = "hover24",inline = TRUE), 
                    tags$br(),
                    imageOutput(outputId = "cell31", click = "click31",hover = "hover31",inline = TRUE), 
                    imageOutput(outputId = "cell32", click = "click32",hover = "hover32",inline = TRUE),  
                    imageOutput(outputId = "cell33", click = "click33",hover = "hover33",inline = TRUE), 
                    imageOutput(outputId = "cell34", click = "click34",hover = "hover34",inline = TRUE),  
                    tags$br(),
                    imageOutput(outputId = "cell41", click = "click41",hover = "hover41",inline = TRUE), 
                    imageOutput(outputId = "cell42", click = "click42",hover = "hover42",inline = TRUE),  
                    imageOutput(outputId = "cell43", click = "click43",hover = "hover43",inline = TRUE), 
                    imageOutput(outputId = "cell44", click = "click44",hover = "hover44",inline = TRUE),  
                    tags$br(),
                    uiOutput(outputId = "clearorderchoice"),
                    imageOutput(outputId = "cell51", click = "click51",inline = TRUE), 
                    imageOutput(outputId = "cell52", click = "click52",inline = TRUE), 
                    imageOutput(outputId = "cell53", click = "click53",inline = TRUE), 
                    imageOutput(outputId = "cell54", click = "click54",inline = TRUE),
                    imageOutput(outputId = "cell61", click = "click61",inline = TRUE), 
                    imageOutput(outputId = "cell62", click = "click62",inline = TRUE), 
                    imageOutput(outputId = "cell63", click = "click63",inline = TRUE), 
                    imageOutput(outputId = "cell64", click = "click64", inline = TRUE),
                    uiOutput(outputId = "clicknext"),
                    uiOutput(outputId = "wrongans")
                  )
                ), uiOutput(outputId = "gameend")),
        
        # Third Tab of Leaderboard
        # Credits to Suzanne
        tabItem(tabName = "leaderboard",
                h2("Fastest Aiders"),
                htmlOutput(outputId = "score"),
                tableOutput(outputId = "toptwentyscores"))
        )
      
    )
)
 

# Part 6: Server
# Credits to Jason and Suzanne and Divya
server <- function(input, output, session){
  # Initialize Game Parameters
  # Credits to Jason
  MAXTURNS <- 999
  vals <- reactiveValues(password = NULL, 
                         playerid = NULL,
                         playername = NULL,
                         playercolor = 0, # 1 indicates identification, 2 indicates treatment
                         turnstate = NULL, 
                         score = NULL, # running timer
                         conclusion = NULL)
  
  # Grid Dimensions
  # Credits to Jason
  GRIDSIZE <- 4 # column
  GRIDSIZE2 <- 4 # row
  pieces <- matrix(rep(0,GRIDSIZE2*GRIDSIZE), nrow = GRIDSIZE2, ncol = GRIDSIZE, byrow = TRUE)
  
  gamevals <- reactiveValues(turncount = 0,
                             pieces = pieces,
                             progress = 0, # increments and tracks the questionid
                             selected = 0, # store the selected option every turn.
                             randomlist = NULL, # stores the list of random options generated for that question.
                             questiongenerated = NULL, # stores the question info
                             player1in = 0, player2in = 0, # track whether 2 players have chosen unique roles. if only 1 role is chosen, player2in == 1
                             orderchoice = NULL, # store the order for question 4
                             injurygenerated = NULL, # stores the injury generated for this game session
                             hinttext = NULL, # text to display for hint
                             hintmode = 2, # 0 if OFF, 1 is ON
                             wrongans = NULL) # track if answer is wrong
  
  # Initiate Timer
  # Credits to Suzanne
  timer <- reactiveValues(score = 0, active = FALSE)

  # Tab 1: Welcome ##################################################################  
  # If user clicks on Register
  # Credits to Prof Jackson
  observeEvent(input$register, {
    showModal(passwordModal(failed = FALSE))
  })
  
  # If user clicks on Ok within Register 
  # Credits to Prof Jackson
  observeEvent(input$passwordok, {
    # Check that password1 exists and it matches password2
    if (str_length(input$password1) >0 && (input$password1 == input$password2)) {
      #store the password and close the dialog
      vals$password <- input$password1
      print(vals$password) # for debugging
      vals$playername = registerPlayer(vals$password)
      if (!is.null(vals$playername)){
        vals$playerid <- getPlayerID(vals$playername, vals$password)
        initialstate <- list(player1in = gamevals$player1in, player2in = gamevals$player2in)
        vals$turnstate <- 1
        startNewLoginSession(vals$playerid, vals$turnstate, initialstate)
      }
      print(vals$playerid) # for debugging
      removeModal()
    } else {
      showModal(passwordModal(failed = TRUE))
    }
  })
  
  # If user clicks on Login
  # Credits to Prof Jackson
  observeEvent(input$login, {
    showModal(loginModal(failed = FALSE))
  })
  
  # If user clicks on Ok within Login
  # Credits to Prof Jackson
  observeEvent(input$loginok, {
    # Get the playerID and check if it is valid
    playerid <- getPlayerID(input$playername, input$password3)
    if (playerid>0) {
      #store the playerid and playername and close the dialog
      vals$playerid <- playerid
      #print(vals$playerid) # for debugging
      vals$playername <- input$playername
      #print(vals$playername) # for debugging
      removeModal()
      initialstate <- list(player1in = gamevals$player1in, player2in = gamevals$player2in)
      vals$turnstate <- 1
      startNewLoginSession(vals$playerid, vals$turnstate, initialstate)
    } else {
      showModal(loginModal(failed = TRUE))
    }
  })
  
  # Show Player Name or Otherwise
  # Credits to Jason
  output$loggedInAs <- renderUI({
    if (is.null(vals$playername))
      "Not logged in yet."
    else
      vals$playername
  })
  
  # UI for Changing Password to Popup after Logged In
  # Credits to Divya
  output$morePassword <- renderUI({
    req(vals$playerid)
    tagList(
      actionButton(inputId = "changepassword", label = "Change your Password")
    )
  })
  
  # If user clicks on Change Password
  # Credits to Divya
  observeEvent(input$changepassword, {
    showModal(newpasswordModal(failed = FALSE))
  })
  
  # If newpasswordModal opens
  # Credits to Divya
  output$newloggedInAs <- renderUI({
    vals$playername
  })
  
  # If user clicks Ok in Change Password
  # Credits to Divya
  observeEvent(input$newpasswordok, {
    # check username exists and passwords match
    playerid <- getPlayerID(vals$playername, input$oldpassword)
    if (playerid==0) {
      showModal(newpasswordModal(failed = TRUE))
      vals$conclusion <- "Change was unsuccessful."
    } else if (playerid>0 && str_length(input$newpassword1)==0 && str_length(input$newpassword2)==0) {
      showModal(newpasswordModal(failed2 = TRUE))
      vals$conclusion <- "Change was unsuccessful."
    } else if (playerid>0 && str_length(input$newpassword1)>0 && input$newpassword1!=input$newpassword2) {
      showModal(newpasswordModal(failed3 = TRUE))
      vals$conclusion <- "Change was unsuccessful."
    } else if (playerid>0 && str_length(input$newpassword1)>0 && input$newpassword1==input$newpassword2 && input$newpassword1==input$oldpassword) {
      showModal(newpasswordModal(failed4 = TRUE))
      vals$conclusion <- "Change was unsuccessful."
    } else {
      vals$password <- updatePassword(vals$playername, input$newpassword1)
      vals$conclusion <- "New password is in effect."
      removeModal()
    }
  })
  
  # UI for Change Password Conclusion
  # Credits to Divya
  output$conclusion <- renderUI({
    vals$conclusion
  })
  
# Tab 2: Game ##################################################################  
  # Show roles after Login
  # Credits to Divya
  output$roles <- renderUI({
    if (is.null(vals$playername)){
      "Not logged in yet."}
    else{
      tagList(
        tags$b("Select your role below:"),
        uiOutput(outputId = "turnbutton1"),
        tags$p("Identification: You will aim to deduce the injury sustained by your patient based on the given information."),
        uiOutput(outputId = "turnbutton2"),
        tags$p("Treatment: You will aim to treat the identified injury accurately and promptly."))
    }
  })
  
  # Show Hints after Options have been Chosen
  # Credits to Divya
  output$hints <- renderUI({
    req(gamevals$player2in == 1)
    req(vals$playercolor == 1)
    tagList(
      tags$p("Click 'On' to enable Hints for Injury Identification. Else, click 'Off'."),
      tags$p("There are no hints available for Injury Treatment. Good luck!"),
      tags$p("If Hint Mode is enabled, hover over the option to view the hint!"),
      radioButtons(inputId = "hintmode", label = "Hint Mode", choices = c("On" = "On","Off" = "Off"))
    )
  })
  
  # If user clicks Hint Mode
  # Credits to Damien
  observeEvent(input$hintmode,{
    if(input$hintmode == "On"){
      gamevals$hintmode <- 1
    }
    else gamevals$hintmode <- 0
  })
  
  # Display Hint Mode on Screen
  # Credits to Divya
  output$playerhintchoice <- renderUI({
    if (gamevals$hintmode == 1) {
      result <- tags$h5("Hint Mode is 'On'.")}
    if (gamevals$hintmode == 0){
      result <- tags$h5("Hint Mode is 'Off'.")}
    result
  })
  
  # Hint Popup
  # Credits to Jason and Divya
  output$hintgenerated <- renderUI({
    if (!is.null(vals$playername) && gamevals$questiongenerated$id %in% c(1,2,3) &&
        gamevals$hintmode == 1){
      text1 <- paste("Here is a hint: ", gamevals$hinttext[1] )
      tags$b(text1)
    } else {
      tags$b("Hint Mode is 'Off'.", style = "color: red;")
    }
  })
  
  # Display Question Once Game Starts
  # Credits to Jason and Divya
  output$questiongenerated <- renderUI({
    if (is.null(vals$playername)){
      tags$br()
    }
    else{
      tags$br()
      tags$h3(gamevals$questiongenerated$text)
    }
  })
  
  # Display Injury Image
  # Credits to Jason and Divya
  output$injurypic <- renderImage({
    if (is.null(vals$playername)){
      "Not logged in yet."}
    else{
      imgsrc = gamevals$injurygenerated$file
      list(src = imgsrc, style = "position:relative;z-order:999")
      }
    }, 
    deleteFile = FALSE)
    
  # React to change in Player Role
  # Credits to Jason
  output$playercolorchoice <- renderUI({
    result <- tags$h5("Select your side to play on.")
    if (vals$playercolor == 2) {
      result <- tags$h5("You are on the", tags$b("Treatment"), " side.")}
    if (vals$playercolor == 1){
      result <- tags$h5("You are on the", tags$b("Injury Identification")," side.")}
    result
  })
  
  # Show roles if both players are logged in
  # Credits to Jason
  output$turnbutton1 <- renderUI({
    if(!is.null(gamevals$player1in) && (gamevals$player1in==0) ){
      actionButton(inputId = "p1submit", label = "Play as Identification")  # this is a 'do something' button
    } else {
      actionButton(inputId = "notturn1", label = "Play as Identification", style = "font-style:italic;color: #6C6C6C; background-color: #C8C8C8; border-color: #C8C8C8") # this is a 'do nothing' button
    }
  })
  
  observeEvent(input$p1submit,{
    gamevals$player1in <- 1
    vals$playercolor <- 1
    disable("p1submit")
    hide("p2submit")
    initialstate <- list(player1in = gamevals$player1in, player2in = gamevals$player2in)
    updateGame(vals$playerid, vals$turnstate, initialstate)
  })
  
  
  output$turnbutton2 <- renderUI({
    if(!is.null(gamevals$player2in) && (gamevals$player2in==0) ){
      actionButton(inputId = "p2submit", label = "Play as Treatment")  # this is a 'do something' button
    } else {
      actionButton(inputId = "notturn2", label = "Play as Treatment", style = "font-style:italic;color: #6C6C6C; background-color: #C8C8C8; border-color: #C8C8C8") # this is a 'do nothing' button
    }
  })
  
  observeEvent(input$p2submit,{
    gamevals$player2in <- 1
    vals$playercolor <- 2
    hide("p1submit")
    disable("p2submit")
    initialstate <- list(player1in = gamevals$player1in, player2in = gamevals$player2in)
    updateGame(vals$playerid, vals$turnstate, initialstate)    
  })
  
  # If user selects options for Question 4
  # Credits to Jason and Divya
  output$clearorderchoice <- renderUI({
    req(gamevals$orderchoice)
    tagList(
      tags$b("View your order choice below! To clear order choice, click the button. "),
      actionButton(inputId = "clearorderchoice", label = "Clear Order Choice"))
  })
  
  # If user clicks on Clear Order Choice 
  # Credits to Jason
  observeEvent(input$clearorderchoice,{
    gamevals$orderchoice <- NULL
    newstate <- list(orderchoice = gamevals$orderchoice,
                     questiongenerated = gamevals$questiongenerated,
                     injurygenerated = gamevals$injurygenerated,
                     randomlist = gamevals$randomlist,
                     progress  = gamevals$progress,
                     turncount = gamevals$turncount,
                     pieces = gamevals$pieces)
    updateGame(vals$playerid, vals$turnstate, newstate)
    
  })
  
  # Display Start Game Button only if two players are logged in
  # Credits to Divya
  output$moreControls <- renderUI({
    req(vals$playerid)
    req(gamevals$player2in==1)
    req(gamevals$hintmode != 2)
    tagList(
      actionButton(inputId = "startgame", label = "Start Game")
    )
  })
  
  # Display Timer and State of Turn
  # Credits to Jason and Suzanne
  output$timerControls <- renderUI({
    req(vals$playerid)
    tagList(
      htmlOutput(outputId = "stateofturn"),
      textOutput(outputId = "timeelapsed"))
  })
  
  # Running timer on screen
  # Credits to Suzanne
  output$timeelapsed <- renderText({
    req(gamevals$injurygenerated)
    paste("Time elapsed:", seconds_to_period(timer$score))
  })
  
  # Updating timer for both players
  # Credits to Suzanne
  observe({
    req(vals$playerid)
    invalidateLater(1000, session)
    isolate({
      if(timer$active)
      {
        timer$score <- round(timer$score+1,2)
      }
    })
    newtimerstate <- list(timerstate = timer$score, active = timer$active)
    updateTimer(vals$playerid, newtimerstate)
  })
  
  # Start timer when you start game
  # Credits to Suzanne
  observeEvent(input$startgame, {
    if (timer$score == 0) {timer$active <- TRUE
    }
  })
  
  # If question is answered incorrectly
  # Credits to Divya
  output$wrongans <- renderUI({
    req(gamevals$wrongans == TRUE)
    showModal(modalDialog(
      title = "Wrong answer, try again!",
      tags$p("10 seconds has been added to your timer!"),
      easyClose = TRUE
    ))
  })
  
  # Change State of Turn
  # Credits to Jason and Suzanne and Divya
  output$stateofturn <- renderUI({
    req(vals$playerid)
    invalidateLater(1000,session) # trigger a timing event in milliseconds
    # Read back the information from the database
    allstate <- getGameTurnAndState(vals$playerid)
    vals$turnstate <- allstate$turnstate
    gamevals$progress <- allstate$gamestate$progress
    # update timer for both players 
    timer$score <- allstate$timerstate$timerstate
    timer$active <- allstate$timerstate$active
    # update score for both players
    vals$score <- allstate$gamestate$score
    
    gamevals$turncount <- allstate$gamestate$turncount
    gamevals$pieces <-  allstate$gamestate$pieces
    
    gamevals$randomlist <- allstate$gamestate$randomlist
    gamevals$questiongenerated <- allstate$gamestate$questiongenerated
    
    gamevals$player1in <- allstate$gamestate$player1in
    gamevals$player2in <- allstate$gamestate$player2in
    
    gamevals$orderchoice <- allstate$gamestate$orderchoice
    
    gamevals$injurygenerated <- allstate$gamestate$injurygenerated
    gamevals$hinttext<- allstate$gamestate$hinttext
    gamevals$wrongans <- allstate$gamestate$wrongans
    gamevals$selected <- allstate$gamestate$selected
    
    text <- "The game has not started."
    if(!is.null(vals$turnstate)){
      if (vals$turnstate==0) text <- "Game is OVER." else {
        if (vals$turnstate ==1) {text <- "It is Identification player's turn to play."} 
        else {text <- "It is Treatment player's turn to play."}
      }
    }  
    text  
  })
  
  # When Start Game is clicked
  # Credits to Jason
  observeEvent(input$startgame,{
    #for debugging:
    #print("player1in")
    #print(gamevals$player1in)
    #print("player2in")
    #print(gamevals$player2in)
    
    tryCatch(expr={
      if (req(gamevals$player1in) == 1 && req(gamevals$player2in) == 1 ){
        gamevals$turncount <- 0
        gamevals$progress <- 0
        gamevals$pieces <- matrix(rep(0,GRIDSIZE2*GRIDSIZE), nrow = GRIDSIZE2, ncol = GRIDSIZE, byrow = TRUE)
        vals$turnstate <- 1  # force identification's turn first
        # Initializing all our values.
        gamevals$injurygenerated <- getARandomInjury()
        gamevals$questiongenerated <- getNextQuestion(questionid = 1)
        gamevals$randomlist <- getRandomizedGameOptionsList(questionid = 1,
                                                            injurytypeid = gamevals$injurygenerated$type)
        
        # print("gamestart pressed") #debugging
        initialstate <- list(questiongenerated = gamevals$questiongenerated,
                             injurygenerated = gamevals$injurygenerated,
                             randomlist = gamevals$randomlist,
                             progress = gamevals$progress,
                             turncount = gamevals$turncount,
                             pieces = gamevals$pieces)
        #print("####Starting up the game####") #debugging
        startNewGame(vals$playerid, vals$turnstate, initialstate)
      }
    },
    error = function(cond){
    },
    warning = function(cond) {
    },
    finally={}
    )
  })
  
  # Display of Selected Options for Question 4
  # Credits to Jason and Divya
  output$cell51 <- renderImage({
    imgsrc = switch(gamevals$orderchoice[1], gamevals$randomlist$image[1], gamevals$randomlist$image[2], gamevals$randomlist$image[3],
                   gamevals$randomlist$image[4], gamevals$randomlist$image[5], gamevals$randomlist$image[6], gamevals$randomlist$image[7],
                   gamevals$randomlist$image[8], gamevals$randomlist$image[9], gamevals$randomlist$image[10], gamevals$randomlist$image[11], gamevals$randomlist$image[12])
    list(src = imgsrc, style = "position:relative;z-order:999")}, deleteFile = FALSE)
  
  output$cell52 <- renderImage({
    imgsrc = switch(gamevals$orderchoice[2], gamevals$randomlist$image[1], gamevals$randomlist$image[2], gamevals$randomlist$image[3],
                   gamevals$randomlist$image[4], gamevals$randomlist$image[5], gamevals$randomlist$image[6], gamevals$randomlist$image[7],
                   gamevals$randomlist$image[8], gamevals$randomlist$image[9], gamevals$randomlist$image[10], gamevals$randomlist$image[11], gamevals$randomlist$image[12])
    list(src = imgsrc, style = "position:relative;z-order:999")}, deleteFile = FALSE)
  
  output$cell53 <- renderImage({
    imgsrc = switch(gamevals$orderchoice[3], gamevals$randomlist$image[1], gamevals$randomlist$image[2], gamevals$randomlist$image[3],
                   gamevals$randomlist$image[4], gamevals$randomlist$image[5], gamevals$randomlist$image[6], gamevals$randomlist$image[7],
                   gamevals$randomlist$image[8], gamevals$randomlist$image[9], gamevals$randomlist$image[10], gamevals$randomlist$image[11], gamevals$randomlist$image[12])
    list(src = imgsrc, style = "position:relative;z-order:999")}, deleteFile = FALSE)
  
  output$cell54 <- renderImage({
    imgsrc = switch(gamevals$orderchoice[4], gamevals$randomlist$image[1], gamevals$randomlist$image[2], gamevals$randomlist$image[3],
                   gamevals$randomlist$image[4], gamevals$randomlist$image[5], gamevals$randomlist$image[6], gamevals$randomlist$image[7],
                   gamevals$randomlist$image[8], gamevals$randomlist$image[9], gamevals$randomlist$image[10], gamevals$randomlist$image[11], gamevals$randomlist$image[12])
    list(src = imgsrc, style = "position:relative;z-order:999")}, deleteFile =  FALSE)
  
  output$cell61 <- renderImage({
    imgsrc = switch(gamevals$orderchoice[5], gamevals$randomlist$image[1], gamevals$randomlist$image[2], gamevals$randomlist$image[3],
                   gamevals$randomlist$image[4], gamevals$randomlist$image[5], gamevals$randomlist$image[6], gamevals$randomlist$image[7],
                   gamevals$randomlist$image[8], gamevals$randomlist$image[9], gamevals$randomlist$image[10], gamevals$randomlist$image[11] ,gamevals$randomlist$image[12])
    list(src = imgsrc, style = "position:relative;z-order:999")},deleteFile = FALSE)
  
  output$cell62 <- renderImage({
    imgsrc = switch(gamevals$orderchoice[6], gamevals$randomlist$image[1], gamevals$randomlist$image[2], gamevals$randomlist$image[3],
                   gamevals$randomlist$image[4], gamevals$randomlist$image[5], gamevals$randomlist$image[6], gamevals$randomlist$image[7],
                   gamevals$randomlist$image[8], gamevals$randomlist$image[9], gamevals$randomlist$image[10], gamevals$randomlist$image[11], gamevals$randomlist$image[12])
    list(src = imgsrc, style = "position:relative;z-order:999")},deleteFile = FALSE)
  
  output$cell63 <- renderImage({
    imgsrc = switch(gamevals$orderchoice[7], gamevals$randomlist$image[1], gamevals$randomlist$image[2], gamevals$randomlist$image[3],
                   gamevals$randomlist$image[4], gamevals$randomlist$image[5], gamevals$randomlist$image[6], gamevals$randomlist$image[7],
                   gamevals$randomlist$image[8], gamevals$randomlist$image[9], gamevals$randomlist$image[10], gamevals$randomlist$image[11], gamevals$randomlist$image[12])
    list(src = imgsrc, style = "position:relative;z-order:999")}, deleteFile = FALSE)
  
  output$cell64 <- renderImage({
    imgsrc = switch(gamevals$orderchoice[8], gamevals$randomlist$image[1], gamevals$randomlist$image[2], gamevals$randomlist$image[3],
                   gamevals$randomlist$image[4], gamevals$randomlist$image[5], gamevals$randomlist$image[6], gamevals$randomlist$image[7],
                   gamevals$randomlist$image[8], gamevals$randomlist$image[9], gamevals$randomlist$image[10], gamevals$randomlist$image[11], gamevals$randomlist$image[12])
    list(src = imgsrc, style = "position:relative;z-order:999")}, deleteFile = FALSE)
  
  # Display of All Options
  # Credits to Jason and Divya
  renderCell <- function(gridrow, gridcol, sequence){
    renderImage({
      print(sequence) #for debug
      imgsrc=switch(sequence,gamevals$randomlist$image[1], gamevals$randomlist$image[2],  gamevals$randomlist$image[3],
                    gamevals$randomlist$image[4],  gamevals$randomlist$image[5], gamevals$randomlist$image[6], gamevals$randomlist$image[7],
                    gamevals$randomlist$image[8], gamevals$randomlist$image[9], gamevals$randomlist$image[10], gamevals$randomlist$image[11], gamevals$randomlist$image[12])
      if (!is.null(gamevals$selected) && sequence == gamevals$selected){
        imgsrc = image_read(imgsrc)%>% image_charcoal()%>% image_write(tempfile(fileext = 'png'), format = 'png')} 
      list(src = imgsrc, style = "position:relative;z-order:999")
      },
      deleteFile = FALSE)
  }
  
  output$cell11 <- renderCell(1,1,1)
  output$cell12 <- renderCell(1,2,2)
  output$cell13 <- renderCell(1,3,3)
  output$cell14 <- renderCell(1,4,4)
  output$cell21 <- renderCell(2,1,5)
  output$cell22 <- renderCell(2,2,6)
  output$cell23 <- renderCell(2,3,7)
  output$cell24 <- renderCell(2,4,8)
  output$cell31 <- renderCell(3,1,9)
  output$cell32 <- renderCell(3,2,10)
  output$cell33 <- renderCell(3,3,11)
  output$cell34 <- renderCell(3,4,12)
  output$cell41 <- renderCell(4,1,13)
  output$cell42 <- renderCell(4,2,14)
  output$cell43 <- renderCell(4,3,15)
  output$cell44 <- renderCell(4,4,16)
  
  # Record Options Chosen
  # Credits to Jason
  processClickEvent <- function(gridrow, gridcol, sequence){
    # If it is not this player's turn, then ignore the click
    req(vals$playerid)
    # Eecord the vector of sequence chosen at question 4
    if (gamevals$questiongenerated$id == 4 && vals$turnstate==as.integer(vals$playercolor)){
      
      gamevals$pieces[gridrow,gridcol] <- as.integer(vals$playercolor) # as.integer necessary because vals$playercolor is actually a string
      gamevals$turncount <- gamevals$turncount + 1

      # Appending the sequence  pressed to the order choice vector
      gamevals$selected <- sequence
      gamevals$orderchoice <- c(gamevals$orderchoice, sequence)
      
      # print(gamevals$orderchoice) #for debug
      
      gamevals$orderchoice <- as.vector(unlist(gamevals$orderchoice))
      newstate <- list(orderchoice = gamevals$orderchoice,
                       questiongenerated = gamevals$questiongenerated,
                       injurygenerated = gamevals$injurygenerated,
                       selected = gamevals$selected,
                       randomlist = gamevals$randomlist,
                       progress = gamevals$progress,
                       turncount = gamevals$turncount,
                       pieces = gamevals$pieces)
      updateGame(vals$playerid, vals$turnstate, newstate)
    }
    #for questions other than question 4
    else if (vals$turnstate==as.integer(vals$playercolor)){
      #change the state of the game
      gamevals$pieces[gridrow,gridcol] <- as.integer(vals$playercolor) # as.integer necessary because vals$playercolor is actually a string
      gamevals$turncount <- gamevals$turncount + 1
      
      # Record which tile was clicked, by storing the sequence of clicked tile inside selected.
      #for eg if the 2nd row 1st column tile was clicked, it is the 4th sequence tile.
      gamevals$selected <- sequence

      newstate <- list(questiongenerated = gamevals$questiongenerated,
                       injurygenerated = gamevals$injurygenerated,
                       selected = gamevals$selected,
                       randomlist = gamevals$randomlist,
                       progress = gamevals$progress,
                       turncount = gamevals$turncount,
                       pieces = gamevals$pieces)
      updateGame(vals$playerid, vals$turnstate, newstate)
    }
  }
  
  observeEvent(input$click11,{processClickEvent(1,1,1)})
  observeEvent(input$click12,{processClickEvent(1,2,2)})
  observeEvent(input$click13,{processClickEvent(1,3,3)})
  observeEvent(input$click14,{processClickEvent(1,4,4)})
  observeEvent(input$click21,{processClickEvent(2,1,5)})
  observeEvent(input$click22,{processClickEvent(2,2,6)})
  observeEvent(input$click23,{processClickEvent(2,3,7)})
  observeEvent(input$click24,{processClickEvent(2,4,8)})
  observeEvent(input$click31,{processClickEvent(3,1,9)})
  observeEvent(input$click32,{processClickEvent(3,2,10)})
  observeEvent(input$click33,{processClickEvent(3,3,11)})
  observeEvent(input$click34,{processClickEvent(3,4,12)})
  observeEvent(input$click41,{processClickEvent(4,1,13)})
  observeEvent(input$click42,{processClickEvent(4,2,14)})
  observeEvent(input$click43,{processClickEvent(4,3,15)})
  observeEvent(input$click44,{processClickEvent(4,4,16)})
  
  # Hover Function for Hint Modal
  # Credits to Jason and Damien
  processHoverEvent <- function(gridrow, gridcol, sequence){
    req(vals$playerid)
    req(gamevals$questiongenerated$id  %in% c(1,2,3))
    req(vals$turnstate==as.integer(vals$playercolor))
    if (gamevals$questiongenerated$id %in% c(1,2,3) && vals$turnstate==as.integer(vals$playercolor)){
      hinttext <- getHint(gamevals$randomlist$hint[sequence])
      gamevals$hinttext <- hinttext
      newstate <- list(hinttext = gamevals$hinttext,
                       questiongenerated = gamevals$questiongenerated,
                       injurygenerated = gamevals$injurygenerated,
                       randomlist = gamevals$randomlist,
                       progress = gamevals$progress,
                       turncount = gamevals$turncount,
                       pieces = gamevals$pieces)
      
      updateGame(vals$playerid, vals$turnstate, newstate)
    }
  }
  
  observeEvent(input$hover11,{processHoverEvent(1,1,1)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover12,{processHoverEvent(1,2,2)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover13,{processHoverEvent(1,3,3)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover14,{processHoverEvent(1,4,4)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover21,{processHoverEvent(2,1,5)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover22,{processHoverEvent(2,2,6)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover23,{processHoverEvent(2,3,7)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover24,{processHoverEvent(2,4,8)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover31,{processHoverEvent(3,1,9)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover32,{processHoverEvent(3,2,10)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover33,{processHoverEvent(3,3,11)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover34,{processHoverEvent(3,4,12)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover41,{processHoverEvent(4,1,13)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover42,{processHoverEvent(4,2,14)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover43,{processHoverEvent(4,3,15)
    showModal(hintModal(failed = FALSE))})
  observeEvent(input$hover44,{processHoverEvent(4,4,16)
    showModal(hintModal(failed = FALSE))})
  
  # If user clicks next to submit answer
  # Credits to Suzanne and Jason and Divya
  processClickNext <- function(){
    req(vals$playerid)
    if (vals$turnstate==as.integer(vals$playercolor)){
      selectedoption <- gamevals$selected
      questionid <- gamevals$questiongenerated$id
      #print(questionid)#debugging
      if (gamevals$questiongenerated$id == 4){
        # For question 4, there is a vector of options chosen to check against question id.
        # The longest arrangement question has 8 tiles and so  holder has 8 elements. 
        # For each element, it is replaced with the id of the selected option.
        optionid <- c(1,2,3,4,5,6,7,8)
        for (i in optionid) {
          optionid[i] <- gamevals$randomlist$id[gamevals$orderchoice[i]]
        }
        # convert the vector to a string to allow getSelectionChecked which checks string against string.
        # if selection order doesnt fill up all 8 elements of the vector, remove the excess NAs:
        optionid <- toString(optionid, width = NULL)
        optionid <- optionid %>% str_replace_all(' ','')
        optionid <- optionid %>%str_remove_all(',NA')
        
      }else{
        # for questions other than question 4
        optionid <- gamevals$randomlist$id[selectedoption]
      }
      
      #gamevals$progress+1 just equals current questionid.
      check <- getSelectionChecked(gamevals$progress + 1, gamevals$injurygenerated$id, optionid)
      #print(check) #debug

      if (gamevals$turncount>MAXTURNS){
        vals$turnstate <- 0 # signals end of the game
      } else{
        #switch turnstate between player colors. check != 0 means check returned correct.
        if (check != 0)
        {
          print("CORRECT ANS CHOSEN")
          gamevals$progress <- gamevals$progress + 1 
          gamevals$wrongans <- FALSE
          #The next few lines are simulate a new startgame to "clear memory"
          gamevals$turncount <- gamevals$turncount +1
          gamevals$selected <- 0
          #clearing the game board
          gamevals$pieces <- matrix(rep(0,GRIDSIZE2*GRIDSIZE), nrow = GRIDSIZE2, ncol = GRIDSIZE, byrow = TRUE)
          newstate <- list(injurygenerated = gamevals$injurygenerated,
                           questiongenerated = gamevals$questiongenerated,
                           randomlist = gamevals$randomlist,
                           progress = gamevals$progress,
                           turncount = gamevals$turncount,
                           pieces = gamevals$pieces)
          updateGame(vals$playerid, vals$turnstate, newstate)
          if (gamevals$progress < 5){
            gamevals$randomlist <- getRandomizedGameOptionsList(gamevals$progress + 1, gamevals$injurygenerated$type, gamevals$injurygenerated$treatment)
            # generate a new question for the next segment.
            gamevals$questiongenerated <- getNextQuestion(gamevals$progress + 1)
          }
          # check if we are at qn 3 and if so we will switch to the other player.
          if(gamevals$progress == 3 && vals$playercolor == 1) {
            vals$turnstate <- 2
          }
          else if (gamevals$progress ==3 && vals$playercolor == 2){
            vals$turnstate <- 1
          } 
          # If at the last question and answer is correct, timer stops and the time is recorded as score
          else if(gamevals$progress >= 5){
            timer$active <- FALSE
            vals$score <- timer$score
            newtimerstate <- list(timerstate = timer$score, active = timer$active)
            updateTimer(vals$playerid, newtimerstate)
          }
        }
        # +10 seconds to timer if wrong answer, and timer is running
        else if (timer$active) {
          gamevals$wrongans <- TRUE
          gamevals$selected <- 0
          timer$score <- round(timer$score+10, 2)
          newtimerstate <- list(timerstate = timer$score, active = timer$active)
          updateTimer(vals$playerid, newtimerstate)
        }
        
        newstate <- list(injurygenerated = gamevals$injurygenerated,
                         questiongenerated = gamevals$questiongenerated,
                         selected = gamevals$selected,
                         randomlist = gamevals$randomlist,
                         progress = gamevals$progress,
                         turncount = gamevals$turncount,
                         pieces = gamevals$pieces,
                         score = vals$score,
                         wrongans = gamevals$wrongans)                     
        updateGame(vals$playerid, vals$turnstate, newstate)
      }
    }}
  
  # Display Next Button once option has been selected
  # Credits to Divya and Suzanne
  output$clicknext <- renderUI({
    req(gamevals$selected > 0)
    tagList(
      tags$p("Press Next to check your answer!"),
      actionButton(inputId = 'nextbutton', label = 'Next')
    )
  })
  
  # When Next Button is clicked to check the answers
  # Credits to Jason
  observeEvent(input$nextbutton,{
    processClickNext()
    #print("next clicked") #for debug
  })
  
# Tab 3: Leaderboard ##################################################################  
  # Record Timer Score
  # Credits to Suzanne
  output$score <- renderUI(
    {req(vals$score > 0)
      tagList(
        tags$h4("Your Aid Response Time:", vals$score, "seconds"),
        actionButton(inputId = "publishscore", label = "Publish Your Score"),
        actionButton(inputId = "refresh", label = "Refresh")
      )
    }
  )
  
  # Stop timer at game end and display message
  # Credits to Suzanne and Divya
  output$gameend <- renderUI({
    req(!timer$active && gamevals$progress >= 5)
    showModal(modalDialog(
      title = "Congratulations! You've saved your patient!",
      "Please proceed to the Leaderboard to see your score.",
      easyClose = TRUE
    ))
  })
  
  # Publish Score at the End
  # Credits to Suzanne
  observeEvent(input$publishscore,{
    publishScore(vals$playerid, vals$score)
  })
  
  # Display Leaderboard at the End
  # Credits to Suzanne
  output$toptwentyscores <- renderTable({
    numclicks <- input$publishscore + input$leaderboard + input$refresh  #to force a refresh whenever this buttons is clicked
    leaderboard <- getLeaderBoard()
    leaderboard}
  )
  
}

# When the session ends, clear GameState from database to keep things clean. 
# Gamestate is just a temporaryholder of state for each session with rapid updates.
onStop(function() {
  conn <- getAWSConnection()
  tryCatch({
    #DELETE all  records in gamestate
    query <-  "DELETE FROM GameState"
    result <- dbExecute(conn, query)
  },
  error=function(cond){print(paste0("End Session ERROR: ", cond))},
  warning=function(cond){print(paste0("End Session WARNING: ", cond))},
  finally={}
  )
  #Close the connection
  dbDisconnect(conn)
})

# Part 7: Initialize Game
shinyApp(ui, server)