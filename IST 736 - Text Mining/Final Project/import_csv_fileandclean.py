# -*- coding: utf-8 -*-
"""
Created on Mon Dec  16 11:58:47 2019

@author: soomondi@syr.edu
"""

##################################################
###Import, clean and vectorize tweets csv file  ###
##################################################


###########import needed libraries#############
import nltk
import pandas as pd
import sklearn
import re
from sklearn.feature_extraction.text import CountVectorizer
from nltk.tokenize import word_tokenize
from nltk.probability import FreqDist
import matplotlib.pyplot as plt
from wordcloud import WordCloud, STOPWORDS, ImageColorGenerator
## For Stemming
from nltk.stem import PorterStemmer
from nltk.tokenize import sent_tokenize, word_tokenize
import os


#from nltk.stem.porter import PorterStemmer
import string
import pprint

## for sentiment
from textblob import TextBlob

### more plotting and listing collections
import itertools
import collections



########### Read the raw/uncleaned file #############
file_1 = r"C:\STEPHEN PERSONAL FILES\Grad School\FALL 2019\TEXT MINING WITH PYTHON\tweets.csv"
f_raw = open(file_1, "r", encoding='utf-8')
# print(f.mode)
# check if file is actually open


############ Clean the raw file, and write back as a new clean_tweets ##############
file_2 = r"C:\STEPHEN PERSONAL FILES\Grad School\FALL 2019\TEXT MINING WITH PYTHON\clean_tweets.csv"
f_clean = open(file_2, "w+")
# add heading row with two columns to file: Lable and Text
#heading_row = "Label, Text\n"
# write heading row into the csv file
#f_clean.write(heading_row)
f_clean.close()

############ Re-open the file with append option to continue writing to it ##############
f_clean_a = open(file_2, "a")

## start a data frame to hold cleaned rows
cleanDF = pd.DataFrame()

## open a file to monitor outputs
file_3 = r"C:\STEPHEN PERSONAL FILES\Grad School\FALL 2019\TEXT MINING WITH PYTHON\outputs.csv"
f_output = open(file_3, "w")
f_output.close()

## re-open with -a
f_output = open(file_3, "a", encoding='utf-8')

############## CLEANING THE SAMPLE RAW FILE #####################
stopwords = set(STOPWORDS)

for row in f_raw:
    Raw_row = "\n\nThe row is " + row + "\n"
    f_output.write(Raw_row)
    row = row.lstrip()          # eliminate space before row
    row = row.rstrip()          # eliminate space after row
    row = row.strip()           # eliminate any other spaces in row
    # tokenize the row
    rawList = row.split(" ")
    #print(rawList)
    
    ############## Begin cleaning the rawList and place cleaned rows into a new list ####
    cleanList = []
    
    for word in rawList:
        addToOutputFile = "\n\nThe word BEFORE is " + word + "\n"
        f_output.write(addToOutputFile)
        word = word.lower()
        word = word.lstrip()
        word = word.replace(",","")
        word = word.replace(" ","")
        word = word.replace("#","")                 ## remove hashtags
        word = word.replace("?","")
        word = word.replace(".","")
        word = word.replace("'","")
        word = word.replace("!","")
        word = word.replace("&amp;","")
        word = re.sub("^https.*"," ",word)          ## remove weblinks
        word = re.sub("^@.*","",word)               ## remove @signs
        word = re.sub(r'[^\x00-\x7F]+','', word)   ## remove non ASCII patterns
        word = re.sub(r'([^0-9A-Za-z \t])|(\w+:\/\/\S+)', '', word)
        word = word.lstrip()
        word = word.rstrip()
        word = word.strip()
        
        
        ## Only keeps words longer than 3 letters, omit digits, omit punctuations and additional 
        if word not in stopwords:
            if len(word) >= 3:
                if not re.search(r'd',word):
                    cleanList.append(word)
                    addToOutputFile = "\n\nThe next word after is: " + word + "\n"
                    f_output.write(addToOutputFile)
    print(cleanList[:5])
    
    ## Is there more cleaning necessary?
    #cleanText = " ".join(cleanList)
    #cleanText = cleanText.replace("!","")
    #if len(cleanText) <= 0:
    #    print("SMALL", cleanText)
    #    cleantText = cleanText.remove(cleanText)
     
    #print(cleanText)
    # create the string you want to write to the new file
    cleanText = " ".join(cleanList)
    print(cleanText)
    f_clean_a.write(cleanText)

f_raw.close()     
f_clean.close()
f_output.close()



####################READ THE CLEAN TEXT AS A DATAFRAME AND VECTORIZE#########
cleanFile = open(r"C:\STEPHEN PERSONAL FILES\Grad School\FALL 2019\TEXT MINING WITH PYTHON\clean_tweets.csv",'r')
df = pd.read_csv(cleanFile)
#print(df.head())


###############COLLECT WORDS, COUNT AND PLOT FREQUENCIES####
# get a collection of all tweets

def plot_top_words(theWords,numberToDisplay,Title):
    all_words = list(itertools.chain(theWords))
    #create a counter
    count_words = collections.Counter(all_words)
    #display most common words
    count_words.most_common(numberToDisplay)
    
    # create a pandas dataframe of 20 most common words
    all_words_DF = pd.DataFrame(count_words.most_common(numberToDisplay),columns=['words','count'])
    all_words_DF.head()
    
    # plot a horizontal bar graph of the 20 most common words
    fig, ax = plt.subplots(figsize=(8,8))
    all_words_DF.sort_values(by='count').plot.barh(x='words',
                         y='count',
                         ax=ax,
                         color='#86bf91')
    
    ax.set_title(Title)
    plt.show()
#########################################################################




###############using a basic split to tokenize words##################
splits = str(df).split(" ")
print(len(splits))
# plot of texts after cleaning
plot_top_words(splits,20,"Most Common Words Found in the Cleaned Tweets")
###################################################################





####Tokenize##################################################
tokens = nltk.word_tokenize(str(df))
tags = nltk.pos_tag(tokens)
print(len(tokens))
# parts of speach tagging
#print(tags[0][0],tags[0][1])

# plot after tokenization
plot_top_words(tokens,20,"Top 20 Common Words Found in the Cleaned Tweets After Tokenization")
##########################################################################




####Remove Additional Stop Words######
stopwords.update(["","tulsi","tulsi2020", "1169120090901", "184449", "//", '"', "'", "*", ":", ";", "?", "@", "https","``","s","t","[","]"])
def removeStopWords(wordlist, stopwords):
    return [w for w in wordlist if w not in stopwords]
words = removeStopWords(tokens, stopwords)
#print(words)
print(len(words))
# plot after removing additional stop words
plot_top_words(words,20,"Top 20 Common Words After Removing Additional Stopwords")



######################Stemming
ps = PorterStemmer()
stem_words = []
for word in words:
    stem_words.append(ps.stem(word))
    print(ps.stem(word))
len(stem_words) 
## chart   
plot_top_words(stem_words,20,"Top 20 Common Words After Stemming")


######################### Word Cloud ###############################
wordcloud = WordCloud( 
                background_color ='azure', 
                stopwords = stopwords,
                max_words = len(stem_words),
                min_font_size = 10).generate(str(stem_words)) 
# display wordcloud
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis("off")
plt.show()



######################### Vectorize ###################################
dfVect = CountVectorizer(input="content")
vecs = dfVect.fit_transform(stem_words)
columNames = dfVect.get_feature_names()
df_vectorized = pd.DataFrame(vecs.toarray(),columns=columNames)
print(df_vectorized)



###################PRINT RESULTS ########################################
# print header row, then print word polarity and subjectivity
print('{:40} : {:10} : {:10}'.format("Word", "Polarity", "Subjectivity"))
#find word sentiment

sentiment_container = pd.DataFrame(['word'],columns=['values'])
L = []
W = []
for word in stem_words:
    # find sentiment of each vocabulary
    sentiment = TextBlob(word)
    # print individual sentiment
    print('{:40} : {:01.2f} : {:01.2f}'.format(word[:20],sentiment.polarity, sentiment.subjectivity)) 
    L.append(sentiment.polarity)
    W.append(sentiment.words)


# dataframe of polarities   
df = pd.DataFrame(L, columns=['polarity'])
# add vocabularies to the dataframe
df['Words'] = W

# sort polarity values from very negative to very positive (-1.0 to 1.0)
sorted_df = df.sort_values(ascending=True, by = 'polarity')

# print the top 30 most negative sentiments
print(sorted_df.head(30))

# print the top 100 most positive sentiments
print(sorted_df.tail(100))


##################### plot a histogram of polarities #########################
#df.hist(column='polarity', title="Vocabulary Polarity Distribution")
ax = df.hist(column='polarity', bins=25, grid=False, figsize=(12,8), color='#86bf91', zorder=2, rwidth=0.9)
ax = ax[0]
for x in ax:

    # Despine
    x.spines['right'].set_visible(False)
    x.spines['top'].set_visible(False)
    x.spines['left'].set_visible(False)

    # Switch off ticks
    x.tick_params(axis="both", which="both", bottom="off", top="off", labelbottom="on", left="off", right="off", labelleft="on")

    # Draw horizontal axis lines
    vals = x.get_yticks()
    for tick in vals:
        x.axhline(y=tick, linestyle='dashed', alpha=0.4, color='#eeeeee', zorder=1)

    # Remove title
    x.set_title("Vocabulary Polarity Distribution")

    # Set x-axis label
    x.set_xlabel("Polarity", labelpad=20, weight='bold', size=12)

    # Set y-axis label
    x.set_ylabel("Word Count", labelpad=20, weight='bold', size=12)

    # Format y-axis label
    from matplotlib.ticker import StrMethodFormatter
    x.yaxis.set_major_formatter(StrMethodFormatter('{x:,g}'))

