# copying mtcars into a new variable: myCars
myCars <- mtcars

# Highest horse power - hp
maxhp <- max(myCars$hp)

# print maxhp
maxhp

# Car with highest hp
myCars[myCars$hp == maxhp,]


# print maxhpCar
maxhpCar

# Highest mpg
maxmpg <- max(myCars$mpg)

# Print highest mpg
maxmpg

# Car with highest mpg
maxmpgCar <- myCars[myCars$mpg == maxmpg,]

# Print car with highest mpg
maxmpgCar

# sorted dataframe based on mpg
mpgSort <- data.frame(myCars, stringsAsFactors = FALSE)
mpgSort[order(-mpgSort$mpg),] # decreasing order defined


# Best combination of mpg and hp
#calculate the mean of mpg and hp
mpghpAvg <- function (a,b) {
  (a + b)/2
}

# add a mean column to the dataframe as newCol
AVGmpghp <- mpghpAvg(myCars$mpg, myCars$hp)

# bind the new column to the myCars data frame
bindMeanCol <- cbind(myCars, AVGmpghp)
 
# sort the new dataframe using the new average column: bestMpgHp
bestMpgHp <- bindMeanCol[order(-bindMeanCol$AVGmpghp),]

# print the newly sorted data to ordered by best mpg hp average
bestMpgHp




