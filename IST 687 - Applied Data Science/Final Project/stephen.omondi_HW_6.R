#   install required packages/libraries
    install.packages("ggplot2")
    library(ggplot2)


#############################################
## STEP 1: download USArrests data set     ##
## as a dataframe                          ##
#############################################

    df_arrests <- as.data.frame(USArrests) 


#   examine the structure of the dataframe
    str(df_arrests)


#   add state names from the states row names
    states_vector <-  c(row.names(df_arrests))
    df_arrests$State_names <- states_vector


#   was the new column added?
    str(df_arrests)


#   how many records were added?
    length(df_arrests$State_names)


#   display records from the added column
    df_arrests$State_names


#   are there any NA records in this column?
    sum(is.na(df_arrests$State_names))


#############################################
## STEP 2: Explore the Data -Understanding ##
##  distributions                          ##
#############################################


#   histogram using ggplot : urban population
    gghist_uburnPop <- ggplot(data = df_arrests, mapping = aes(x = UrbanPop)) +
                  
                          # set histogram with bin width, color and fill
                          geom_histogram(binwidth = 2, color = "black", fill = "white") +
                          
                          # add title
                          ggtitle("USA Arrests: Urban Population Histogram") +
                          
                          # add x label
                          xlab("Urban Population") +
                          
                          # add y label
                          ylab("Count")
                  
    gghist_uburnPop
    

#   histogram using ggplot : murder rate
    gghist_murder_rate <- ggplot(data = df_arrests, mapping = aes(x = Murder)) +
                  
                            # set histogram with bin width, color and fill
                            geom_histogram(binwidth = 2, color = "black", fill = "tan") +
                            
                            # add title to histogram
                            ggtitle("USA Arrests: Murder Rate Histogram") +
                            
                            # add x label
                            xlab("Murder Rate") +
                            
                            # add y label
                            ylab("Count")
    gghist_murder_rate
    
    
#   boxplot using ggplot : urban population
    ggbxplt_urban_pop <- ggplot(data = df_arrests, mapping = aes(y = UrbanPop)) +
                            
                            # add boxplot with blue color and white fill
                            geom_boxplot(color = "blue", fill = "white")
                        
    ggbxplt_urban_pop
    
    
    
#   boxplot using ggplot : urban population
    ggbxplt_murder_rate <- ggplot(data = df_arrests, mapping = aes(y = Murder)) +
      
                            # add boxplot with blue color and white fill
                            geom_boxplot(color = "red", fill = "white")
    
    ggbxplt_murder_rate
    
    
    
    
    #############################################
    ## STEP 3: Which State had the most murders##
    ##  Bar Charts                             ##
    #############################################
    
    
    ggbarplt <- ggplot(data = df_arrests, mapping = aes(x = State_names, y = Murder)) +
                
                  # add bar chat with height of bars equal to murder count  
                  geom_col() +
      
                  # rotate state names on the x-axis for readability
                  theme(axis.text.x = element_text(angle = 90, hjust = 1))
    ggbarplt
    
    
  
    #   plot sorted by Urban Population
    ggbarplt1 <- ggplot(data = df_arrests, mapping = aes(x = reorder(State_names, -Murder), y = Murder, color = Assault)) +
      
                  # add bar chat with height of bars equal to murder count, steelblue fill  
                  geom_col(width = 0.5, fill = "steelblue") +
      
                  scale_x_discrete() +
                  
                  # minimal theme applied
                  theme_minimal() +                 
                  
                  # rotate state names on the x-axis for readability
                  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0))
                  
                  # flip co-ordinates for better display of state names
                  # coord_flip()
    ggbarplt1
    
    

    #############################################
    ## STEP 4: Explore Murders. Scatter Chart  ##
    ##                                         ##
    #############################################
    
    gg_scatter <- ggplot(data = df_arrests, mapping = aes(x = Assault, y = UrbanPop, color = Murder, size = Murder)) +
                  # add scatter plot
                  geom_point()
      
    gg_scatter
    