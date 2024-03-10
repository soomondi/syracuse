# install packages to handle HTTP/FTP type requests
install.packages("RCurl")


# install bitops package required for RCurl above
install.packages("bitops")


# load installed packages into current R session
library(bitops)
library(RCurl)


# install and load tydiverse package for data munging
install.packages("tidyverse")
library(tidyverse)




#########################################################
## Step 1: Create a function (named readStates) to read #
## a CSV file into R                                    #
#########################################################

# Define a function to fetch a webfile
readStates <- function(full_path){
  
  # download the file
  get_file <- getURL(full_path, followlocation=TRUE)   
  
  # read the file - csv in this case
  read.csv(text = get_file)
}


# preset the csv location to be fetched
csvlocation <- paste0("http://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv")

# the function call below failed to work
# on multiple attempts
# dfStates <- readStates(csvlocation)


# therefore, I opted for a direct call
# using read.csv function as below
dfStates <- read.csv(csvlocation)





#################################
## Step 2: Clean the dataframe ##
#################################


#  Numberize function to convert vectors into numerics
Numberize <- function(inputVector) { 
  
  # Get rid of commas 
  inputVector <- gsub(",","", inputVector) 
  
  # Get rid of spaces 
  inputVector <- gsub(" ","", inputVector) 
  
  return(as.numeric(inputVector)) 
}


#  Remove bad columns, convert last 4 columns into numerics
#  transmute() is used to keep only the selected columns
#  Numberize() is called to turn factors into numerics
#  columns are named appropriately
dfStates <- transmute(dfStates,
                         stateName = dfStates$table.with.row.headers.in.column.A.and.column.headers.in.rows.3.through.4...leading.dots.indicate.sub.parts.,
                         base2010 = Numberize(dfStates$X),
                         base2011 = Numberize(dfStates$X.1),
                         Jul2010 = Numberize(dfStates$X.2),
                         Jul2011 = Numberize(dfStates$X.3)
                        )


#   view the top rows in the new dataset
#   note rows that are unnecessary
#   shows that rows 1 - 8 are not necessary for this analysis
head(dfStates)


#   view the tail of the dataset
#   tail of the dataset shows that rows 62 - 66 are not necessary 
#   for this analysis
tail(dfStates)


#   Remove unwanted Rows identified above
#   only show rows  9 - 61
dfStates <- dfStates[9:61,]


# Remove rows with missing values
# Remove row 52 since it is empty through and through
dfStates <- dfStates[-52,]




##########################################
## Step 3: Store and Explore the dataset #
##########################################

# how many rows do we have
# we should have 52 rows
# 1 row per state and the District of Columbia
count(dfStates)

# inspect the stracture of the new dataset
# to verify data types
str(dfStates)


# calculating the mean for July2011
July2011_mean <- mean(dfStates$Jul2011)

# format the mean above for neat output
# add commas
format(July2011_mean, big.mark = ",")




#######################################################
## Step 4: Find the state with the Highest Population #
#######################################################


# what is the highest Jul2011 population? 
state_pop <- max(state_pop$Jul2011)

# show the state with the highest population from above
# with the filter() function
filter(dfStates, dfStates$Jul2011 == state_pop)

# without the filter() function
dfStates[dfStates$Jul2011 == state_pop,]
  

# sort based on Jul2011 population numbers
# sorted in ascending/increasing order
dfStates[order(dfStates$Jul2011),]



###################################################
## Step 5: Explore the distribution of the states #
###################################################

## Write a function that takes two parameters.
## The first is a vector and the second is a
## number.return the percentage of the elements within the vector that is less
## than the same (i.e. the cumulative distribution below the value provided).

myFunction <- function(vec, num){
  vec_length <- length(vec)            # length of the vec
  lessnums <- vec[vec < num]           # values in vec that are below the num
  lessnums <- length(lessnums)         # length of values below the num
  lessnums <- ((lessnums/vec_length))  # proportion of values below the num
  return(lessnums)
}

# testing the function with July2011 population vectors
# relative to the mean i.e July2011_mean calculated earlier
myFunction(c(dfStates$Jul2011), July2011_mean)



