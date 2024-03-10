# install moments package to handle skewness, kurtosis etc
install.packages("moments")
library(moments)


####################################################
## STEP 1: Write	a	summarizing	function	to      ##
## understand the	distribution	of	a	vector      ##
## function to explore samples                    ##
#################################################### 

printVecInfo <- function(x){
  result <- cat("Mean:", mean(x, na.rm = TRUE))
  result <- cat(result,"\nMedian:", median(x, na.rm = TRUE))
  result <- cat(result,"\nStandard Deviation:", sd(x, na.rm = TRUE))
  result <- cat(result,"\nMin:", min(x, na.rm = TRUE, na.rm = TRUE))
  result <- cat(result,"\nmax:", max(x, na.rm = TRUE))
  result <- cat(result,"\nsd:", sd(x, na.rm = TRUE))
  result <- cat(result,"\nQuantiles:", quantile(x, probs = c(0.05, 0.95), na.rm = TRUE))
  result <- cat(result,"\nSkewness:", skewness(x, na.rm = TRUE))
  result <- cat(result,"\nKurtosis:", kurtosis(x, na.rm = TRUE))
                 
  # return(cat(result, sep = " ", fill = FALSE)) #cat function is used to enforce line breaks
  return((result))
  }



# test the function with a vector that has 1,2,3,4,5,6,7,8,9,10,50
test_vector <- c(1:10,50)
printVecInfo(test_vector)

# -----------------------------------------------------------------------------------
############################################
## Step	2:	Create	a	variable	'jar'      #
## that	has	50	red	and	50	blue	marbles  #
############################################


blue <- rep("Blue", 50)  # blue marbles
red <- rep("Red", 50)    # red marbles

jar <- c(blue, red)     # vector with all marbles in a jar
jar

# confirm there are 50 red marbles in the jar
sum(jar == "Red")


# Sample	10	'marbles'	(really	strings)	from	the	jar.
sample_jar <- sample(jar, size = 10, replace = TRUE) 
sample_jar

# How	many	are	red?	
red_sample <- sum(sample_jar == 'Red')
red_sample

# What	was	the	percentage	of	red	marbles?
percent_red_sample <- (red_sample / length(sample_jar))
percent_red_sample


# wrap it into a function
get_marbles <- function(the_sample, sample_size){
  red <- sample(the_sample, size = sample_size, replace = TRUE)
  red_percent <- sum(the_sample == "Red") / length(the_sample)
  return(red_percent)
}

# test the function
get_marbles(sample_jar, 10)
get_marbles(sample_jar, 100)
get_marbles(sample_jar, 1000)
get_marbles(sample_jar, 10000000)

# do the sampling 20 times
sample_1 <- replicate(20, get_marbles(sample_jar, 10))
mean(sample_1)
median(sample_1)
histogram(sample_1)

# sample replicated 100 times
sample_2 <- replicate(10, get_marbles(sample_jar, 10))
mean(sample_2)
median(sample_2)
hist(sample_2)

#---------------------------------------------------------------------------------
#############################################
# Step	3:	Explore	the	airquality	dataset #
#############################################

df <- airquality

# view head and tail of df
head(df)
tail(df)

# investigate structur of df
str(df)

# Explore	Ozone,	Wind	and	Temp	by	doing	a	'printVecInfo'
printVecInfo(df$Ozone)
hist(df$Ozone)

printVecInfo(df$Wind)
hist(df$Wind)

printVecInfo(df$Temp)
hist(df$Temp)

