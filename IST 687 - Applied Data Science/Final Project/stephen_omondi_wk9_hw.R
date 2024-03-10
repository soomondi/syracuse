# install needed packages
install.packages("kernlab")
library(kernlab)

library(ggplot2)

library(arules)


# download the dataset from r
data("airquality")


# view summary data to detect NA's
summary(airquality)


# another way to get total count of NA's in the dataset
sum(is.na(airquality))


# inspect the structure of airquality dataset
str(airquality)


# create a new airquaility dataset without NA's
df <- na.omit(airquality)
#sum(is.na(df))


# set cutoff point for the df
cut_off <- (nrow(df) * 2/3)
cut_off


# pick random indices of df
random_df <- sample(1:nrow(df))
head(random_df)


# set training dataset
train_df <- df[random_df[1:cut_off],]
View(train_df)


# testing dataframe
test_df <- df[random_df[(cut_off+1):nrow(df)],]
View(test_df)


# create first model
model <- ksvm(Ozone~Solar.R+Wind+Temp, data=train_df)
#model


# use model for prediction with the test data
prediction <- predict(model, test_df)
#prediction


# make a comparizon table as dataframe of exact ozone and its predicted value
comptable <- data.frame(test_df$Ozone, prediction[,1])
#comptable


# give suitable column names
colnames(comptable) <- c("test", "Pred")


# calculate root mean square error
rmse <- sqrt(mean((comptable$test - comptable$Pred)^2))
avg <- mean(comptable$test)


# compute absolute error between test ozone and predicted 
comptable$error = abs(comptable$test - comptable$Pred)


# create a new dataframe from the test data that contains the comptable_error
svmplot <- data.frame(comptable$error, test_df$Temp, test_df$Wind, test_df$Ozone)
colnames(svmplot) <- c("error","Temp","Wind", "Ozone")


# plot svmplot
g <- ggplot(data = test_df, mapping = aes(x = Temp, y = Wind))+
  geom_point(aes(size = error, color = error))

g


# STEP 4: Create a 'goodOzone'variable
# begin with the training data
# 0	if	the	ozone	is	below	the	average	for	all	
# the	data	observations,	and 1	if	it	is	equal	to	or	above	the	average	ozone	observed.
train_df$goodOzone <- 1

# compute mean of ozone
avg_ozone <- mean(df$Ozone)


# set goodOzeon equal zero where ozone is greater than computed mean
train_df$goodOzone[train_df$Ozone > avg_ozone] <- 0



# make the good ozone column a factor
train_df$goodOzone <- as.factor(train_df$goodOzone) 
sum(train_df$goodOzone == 1)


# followed by the test data
test_df$goodOzone <- 1
test_df$goodOzone[test_df$Ozone > avg_ozone] <- 0
test_df$goodOzone <- as.factor(test_df$goodOzone)
class(test_df$goodOzone)
sum(test_df$goodOzone == 1)


#---Step	5:	See	if	we	can	do	a	better	job	predicting	'good'	and	'bad'	days
# trying to predict 'goodOzone

goodOzoneModel <- ksvm(goodOzone~ Temp+Wind+Solar.R, train_df)

predGoodOzone <- predict(goodOzoneModel, test_df)

compGoodOzone <- data.frame(test_df$goodOzone, predGoodOzone)

colnames(compGoodOzone) <- c("Test", "Pred")

# tabulate results - confusion matrix
table(compGoodOzone)


# plot the results
compGoodOzone$correct <- ifelse(compGoodOzone$Test == compGoodOzone$Pred, "Correct", "Wrong")
head(compGoodOzone)


# create a new dataframe with the plot
goodOzoneData <- data.frame(goodozoneplot, test_df$Temp, test_df$Wind, test_df$goodOzone, compGoodOzone$Pred)
goodOzoneData


# update colnames
colnames(goodOzoneData) <- c("correct","Temp","Wind","goodOzone","Predict")


# plot
g <- ggplot(data = goodOzoneData, mapping = aes(x = Wind, y = Temp))+
  geom_point(aes(size=correct,color=goodOzone,shape = Predict))

g
