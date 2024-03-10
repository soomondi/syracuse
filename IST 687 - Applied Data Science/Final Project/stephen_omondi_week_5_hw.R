### 
# Author: Obongo Omondi
# Date:   Feb 9, 2018
# Email:  soomondi@syr.edu
###

## STEP 0 REQUIRED INSTALLS
# install SQLite
install.packages("RSQLite")
library(RSQLite)

# install and load SQLDF to implement SQL in R
install.packages("sqldf")
library(sqldf)

# install and load RJSONIO package for JSON processing
install.packages("RJSONIO")
library(RJSONIO)


# install and load RCurl package for URL processing
install.packages("RCurl")
library(RCurl)


####################################
## STEP 1: Making JSON connection  #
#  and retrieve dataframe          #
####################################

# set target URL
accidentURL <- "http://data.maryland.gov/api/views/pdvh-tf2u/rows.json?accessType=DOWNLOAD"


# retrieve the URL
apiResult <- getURL(accidentURL)
str(apiResult)


# read json data
results <- fromJSON(apiResult, simplify = FALSE, nullValue = NA)
str(results)


# how many rows?
numRows <- length(results[[2]])
numRows



# convert the json data into a data frame
#df <- as.data.frame(results)

df <- data.frame(matrix(unlist(results[[2]]), 
                        nrow=numRows, byrow=T), 
                 stringsAsFactors = FALSE)

str(df)
head(df)

######################################
#   Step	2:	Clean	the	data         #
# 	remove	the	first	8	columns,     #
#   and	then,	to	                   #
#   make	it	easier	to	work	with #
######################################


# remove first 8 columns
df <- df[-c(1:8)]

# view top 10 records to verify columns
View(head(df, 10))


# set new column names vector
namesOfColumns <-c("CASE_NUMBER","BARRACK","ACC_DATE","ACC_TIME","ACC_TIME_CODE","DAY_OF_WEEK","ROAD","INTERSECT_ROAD","DIST_FROM_INTERSECT","DIST_DIRECTION",
                "CITY_NAME","COUNTY_CODE","COUNTY_NAME","VEHICLE_COUNT","PROP_DEST","INJURY","COLLISION_WITH_1","COLLISION_WITH_2")

# rename all columns
names(df) <- namesOfColumns



# view top 10 records to verify column name changes
View(head(df, 10))


# remove NAs from the data frame
df <- na.omit(df)

# view top 10 records to verify
View(head(df, 10))

#########################################
#  Step	3:	Understand	the	data	using #
#  SQL	(via	SQLDF)                    #
#########################################

# How	many	accidents	happen	on	SUNDAY
sundayAccidents <- sqldf("SELECT * FROM df WHERE DAY_OF_WEEK = 'SUNDAY   '")

# ----2061 accidents---- verified below ##
str(sundayAccidents)


# How	many	accidents	had	injuries
injuryAccidents <- sqldf("SELECT * FROM df WHERE INJURY = 'YES'")

# ----5639 accidents---- verified below ##
str(injuryAccidents)

# List	the	injuries	by	day
byDayInjuries <- sqldf("SELECT DAY_OF_WEEK as DAY, COUNT(INJURY) as TOTAL_INJURIES 
                       FROM df
                       WHERE INJURY = 'YES'
                       GROUP BY DAY
                       ORDER BY TOTAL_INJURIES DESC")
                       
# View(dailyInjuries)
byDayInjuries






#########################################
#  Step	4:	Understand	the	data	using #
#  tapply                  #
#########################################

# How	many	accidents happen on SUNDAY
t_sundayAccidents <- tapply(df$DAY_OF_WEEK == 'SUNDAY   ', df$DAY_OF_WEEK, sum)
str(t_sundayAccidents)
barplot(t_sundayAccidents) #bar plot of Sunday only accidents


# How	many	accidents	had	injuries
t_injuryAccidents <- tapply(df$INJURY == 'YES', df$DAY_OF_WEEK, sum)
str(t_injuryAccidents)
barplot(t_injuryAccidents, xlab = "Days of the Week", ylab = "No. Accidents") #bar plot of by day accidents


# List	the	injuries	by	day
t_byDayInjuries <- tapply(df$INJURY == 'YES', df$DAY_OF_WEEK, sum)
str(t_byDayInjuries)
t_byDayInjuries