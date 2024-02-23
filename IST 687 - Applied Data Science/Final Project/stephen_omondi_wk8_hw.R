## set working directory
setwd("C:\\Users\\obong\\OneDrive\\Desktop\\DATA SCIENCE\\Learning R\\School Projects\\Week 8")

##  install ggplot2 for visualization
    library(ggplot2)

##  install readxl package
    install.packages("readxl")


##  load libary to current session
    library(readxl)


##  read the excel document
    df <- read_excel("mlr01.xls")
    

##  convert to a dataframe and verify using class function
    df <- as.data.frame(df)
    class(df)


##  view structure of df
    str(df)

    
##  view the file
    View(df)

        
##  apply new columnames
    newcolnames <- c("fawns", "pop_adult", "precip", "winter_con")
    colnames(df) <- newcolnames

    
##  plot bivariate plot of baby fawns vs adult antelope populations
    gg <- ggplot(data = df, mapping = aes(x = df$pop_adult, y = df$fawns))+
      geom_point()+
      labs(title = "Adult Antelope Population VS Offsprings",
           x = "Adult Population",
           y = "Number of Offspring") +
      theme_classic()
        
    gg


##  predict	the	number	of	fawns	from	the	severity	of	the	winter
    p_1 <- lm(df$fawns ~ df$winter_con)
    summary(p_1)
    
    
##  predict	the	number	of	fawns from	2	variables
    p_2 <- lm(df$fawns ~ df$winter_con + df$precip)
    summary(p_2)
    

    ##  predict	the	number	of	fawns from	3(all)	variables
    p_3 <- lm(df$fawns ~ df$winter_con + df$precip + df$pop_adult)
    summary(p_3)

   