# install the text mining (tm) package
install.packages("tm")

# call installed library
library(tm)


# install the wordcloud package
install.packages("wordcloud")


# call the wordcloud library
library(wordcloud)


# text source file (location)
sbafile <- "http://www.historyplace.com/speeches/anthony.htm"


# read text source file line by line
sba <- readLines(sbafile)


# view the structure of the text source file
str(sba)


# text source as a vector
words_vec <- VectorSource(sba)

# body of text (words)
words_corpus <- Corpus(words_vec)
words_corpus

#1. transform the body of text to lowercase
words_corpus <- tm_map(words_corpus, content_transformer(tolower))

#2. remove punctuation
words_corpus <- tm_map(words_corpus, removePunctuation)

#3. remove numbers
words_corpus <- tm_map(words_corpus, removeNumbers)

#4. remove words
words_corpus <- tm_map(words_corpus, removeWords, stopwords("English"))

# create a term document matrix
tdm <- TermDocumentMatrix(words_corpus)
tdm

# convert to a real matrix
m <- as.matrix(tdm)

# get the total word count rows
wordCounts <- rowSums(m)

#sort the wordcounts, decreasing
wordCounts <- sort(wordCounts, decreasing = TRUE)

#view head
head(wordCounts)

# create the cloud frame
cloudFrame <- data.frame(word=names(wordCounts), freq=wordCounts)


wordcloud(cloudFrame$word, cloudFrame$freq)

wordcloud(names(wordCounts), wordCounts, min.freq=2, max.words = 50, rot.per=0.35, colors=brewer.pal(8, "Dark2"))


# find associations between words
findAssocs(tdm, "govern", 0.6)


## =====================================================

# obtain a list of positive words
positive <- read.csv("./positivewords.txt")
positive <- as.character(positive)
head(positive, 50)





# now refer back to the total counts of words
totalwords <- sum(wordCounts)
totalwords


# have a vector that has all the words
words <- names(wordCounts)
head(words,10)

matched <- match(words, positive, nomatch = 1)
matched


##====================PREPARE AFFIN DATA=============================
# source file for AFFIN word list
affin <- "./AFINN111_2.txt"


# reading the AFFIN word list
af <- readLines(affin)


# split af into words, and scores
split_af <- strsplit(af, split = "\t") # splitting at "\t"
head(split_af)


# unlisting af
split_af <- unlist(split_af)


# list as a data frame
split_af <- as.data.frame(split_af)
head(split_af,10)


# change the header of the data frame
colnames(split_af) <- c("Word")


# get the row indices
rows <- as.numeric(rownames(split_af))
head(rows)
##===============================================================




##====================COMPUTING THE SCORES=======================
# get a corresponding indices of for scores
score <- which(rows %% 2 == 0)
head(score)
# get the actual score values using indices above
the_scores <- split_af[score,]
# convert scores to character values
the_scores <- as.character(the_scores)
# inspect
head(the_scores,50)
##===============================================================




##======================COMPUTING THE WORDS=====================
# get a corresponding indices for words
w <- which(rows %% 2 != 0)
head(w)
# get the actual score values using indices above
the_words <- split_af[w,]
# convert words to character values
the_words <- as.character(the_words)
head(the_words,50)
##==============================================================




##==================TABLE OF WORDS AND SCORES======================
# finally, create a new dataframe of words and corresponding scores
df <- data.frame(the_words, the_scores)
head(df)
# give the dataframe proper column headers/names
colnames(df) <- c("Word", "Score")
View(df)
##==================================================================


##=====================GET THE WORDS AND ASSIGN AFFINITY ===========
# which words in the cloudframe are found in the AFFIN words reference
similar_words <- which(cloudFrame$word %in% df$Word)
similar_words <- df[similar_words,]
similar_words

# total similar words
total_similar <- nrow(similar_words)

# convert similar words to characters
similar_words$Word <- as.character(similar_words$Word)
similar_words$Score <-as.character((similar_words$Score))


## how many words have a positive affinity score
good <- similar_words[as.numeric(similar_words$Score) > 0,]
good
nrow(good)


## how many words have a negative affinity score
bad <- similar_words[as.numeric(similar_words$Score) < 0, ]
bad
nrow(bad)

## percentage good
(nrow(good)/total_similar)

# dataframe of good and bad words from the cloudframe
(nrow(bad)/total_similar)

