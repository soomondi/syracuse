#!/usr/bin/env python
# coding: utf-8

# ### PROCESSING AND CLASSIFICATION OF THE KAGGLE MOVIE REVIEW DATA
# 
# 
# **IST 664 FINAL PROJECT**
# 
# **STEPHEN OMONDI**
# 
# **June 15, 2020**
# 
# **Course Instructor: Professor Paloma**
# 
# _____________________________________________________________________________________
# 
# 
# ### INTRODUCTION
# 

# The Kaggle Movie Review Data was taken from the original Pang and Lee movie review corpus based on reviews from the Rotten Tomatoes web site. Socher’s group used crowd-sourcing to manually annotate all the subphrases of sentences with a sentiment label that went into this movie review library.
# 
# **The sentiment labels used were:**
# 
# 0 - negative
# 
# 1 - slightly negative 
# 
# 2 - neutral 
# 
# 3 - slightly positive 
# 
# 4 – positive
# 
# This analysis uses the training data “train.tsv”, and test data “test.tsv”. The training data file has 156,060 phrases, and the early part of the analysis chooses an appropriate subset for processing and training.
# 

# ### Objective

# The goal of this analysis is to predict the sentiments of each review using algorithmic approach and make a comparison of results by tweaking underlying parameters such as the effect on the classification based on different filtering and preprocessing approaches. Finally, a summary comparison of different algorithmic classifiers, such as Naïve Bayes classification, Random Forests, Decision Trees and more from the Sci-Kit Learn ecosystem are compared along common measures of prediction accuracy to determine the winner

# In[1506]:


# necessary imports
import os
import sys
import random
import nltk
import re
from nltk.corpus import stopwords


# ### STEP 1: Fetching data from train.tsv

# First, begin by reading the training tab separated values file. The file has 156,060 phrases. random phrases were selected to avoid overlaps and to display a wider segment of the total phrases some of which are shown below, along with their sentiments.

# In[1507]:


# function to read kaggle training file, train and test a classifier 
def processkaggle(dirPath,limitStr):
  # convert the limit argument from a string to an int
  limit = int(limitStr)
  
  os.chdir(dirPath)
  
  f = open('corpus/train.tsv', 'r')
  # loop over lines in the file and use the first limit of them
  phrasedata = []
  for line in f:
    # ignore the first line starting with Phrase and read all lines
    if (not line.startswith('Phrase')):
      # remove final end of line character
      line = line.strip()
      # each line has 4 items separated by tabs
      # ignore the phrase and sentence ids, and keep the phrase and sentiment
      phrasedata.append(line.split('\t')[2:4])
    
  # pick a random sample of length limit because of phrase overlapping sequences
  random.shuffle(phrasedata)
  phraselist = phrasedata[:limit]

  print('Read', len(phrasedata), 'phrases, using', len(phraselist), 'random phrases')
  
  for phrase in phraselist[:10]:
    return phraselist


# In[1508]:


dirPath = "C:\\Academics\\Natural Language Processing\\Final Project\\FinalProjectData\\FinalProjectData\\kagglemoviereviews"
reviews = processkaggle(dirPath,3000)
reviews[:10]


# ### STEP 2: Deciding on an appropriate Tokenizer

# Three approaches are explored in order to decide on a best tokenization approach and set the stage for forthcoming experiments.

# **- Sklearn Countvectorize tokenizer**
# 
# This tokenizer removes all single character words. For example, the word won’t became won and all abbreviated words were removed, e.g. U.K was omitted altogether. This approach may not be ideal when handling negative sentiments or negative words as they are lost in the tokenization which may lead to a different meaning of the word.

# In[1509]:


from sklearn.feature_extraction.text import CountVectorizer


# In[1511]:


# countvectorize
def countvector_token(phraselist):
    phrasedocs4 = []
    for phrase in phraselist:
        cvtokens = CountVectorizer().build_tokenizer()(phrase[0])
        phrasedocs4.append((cvtokens, int(phrase[1])))
    return phrasedocs4

# displaying only the first 3
countvector_token(reviews[:3])


# **- NLTK Word Tokenizer**
# 
# This approach preserves abbreviated words like U.S.A but splits negative words like *can’t* into two parts, *can* and *‘t*.

# In[1512]:


## word tokenizer
def word_tokenizer(phraselist):
    w_tokens = []
    # add all the phrases
    for phrase in phraselist:
        tokens = nltk.word_tokenize(phrase[0])
        w_tokens.append((tokens, int(phrase[1])))
    return w_tokens

word_tokens = word_tokenizer(reviews)

# displaying only the first 3
word_tokens[:3]


# **WordPunct Tokenizer**
# 
# This tokenizer treats punctuations as words on their own. For example, words like *‘U.S.A.’* becomes six words- *‘U’,’.’,’S’,’.’,’A’,’.’* and *‘ca n’t’* becomes four words- *‘ca’,’n’, ’’’ ,’t’*.

# In[1513]:


## word_punct tokenizer
def word_puncktokens(phraselist):
    wp_tokens = []
    for phrase in phraselist:
        wptokens = nltk.wordpunct_tokenize(phrase[0])
        wp_tokens.append((wptokens, int(phrase[1])))
    return wp_tokens

# displaying only the first 3
word_puncktokens(reviews[:3])


# **From the foregoing analyses, *NLTK Wordtokenizer is the preferred method and is used in the subsequent sections.***

# ### STEP 3 - Processing the Reviews/Text

# **- Lowercase**
# 
# Convert all reviews to lowercase. This is important because NLTK algorithm is case sensitive

# In[1514]:


# convert all characters to lower case
def to_lower(phrases):
    sents_to_lower= []
    for phrase in phrases:
        lower_tokens = phrase[0].lower()
        sents_to_lower.append((lower_tokens, phrase[1]))
    return sents_to_lower

all_reviews = to_lower(reviews)

# displaying only the first 10
all_reviews[:10]


# **- Clean the reviews to include negative / contraction words**
# 
# Expand the stop words list by removing contraction words like *can't* to *can not*. Thus, this proces extends the stop words with apostrophes. This is important as it helps the word_tokenizer perform better. 

# In[1515]:


def cleanextend(phrases):
    phrases_without_contractions = []
    for review in phrases:
        extended_rev = re.sub(r"it \'s", "it is", review[0])
        extended_rev = re.sub(r"that 's", "that is", extended_rev)
        extended_rev = re.sub(r"\'s", "\'s", extended_rev)
        extended_rev = re.sub(r"\'ve", "have", extended_rev)
        extended_rev = re.sub(r"wo n't", "will not", extended_rev)
        extended_rev = re.sub(r"do n't", "do not", extended_rev)
        extended_rev = re.sub(r"ca n't", "can not", extended_rev)
        extended_rev = re.sub(r"sha n't", "shall not", extended_rev)
        extended_rev = re.sub(r"n\'t", "not", extended_rev)
        extended_rev = re.sub(r"\'re", "are", extended_rev)
        extended_rev = re.sub(r"\'d", "would", extended_rev)
        extended_rev = re.sub(r"\'ll", "will", extended_rev)
        phrases_without_contractions.append((extended_rev, review[1]))
    return phrases_without_contractions

all_reviews = cleanextend(all_reviews)

# displaying only the first 10
all_reviews[:10]


# **Removing punctuations, along with numbers**
# 
# This is necessary since punctuations and numbers will not be necessary for sentiment analysis.

# In[1516]:


def remove_punctuations(phrases):
    phrases_without_punctuations = []
    for text in phrases:
        punctuation = re.compile(r'[-_.?!/\%@,":;\'{}<>~`\()|0-9]')
        word = punctuation.sub("", text[0])
        phrases_without_punctuations.append((word, text[1]))
    return phrases_without_punctuations

all_reviews = remove_punctuations(all_reviews)

# displaying only the first 10
all_reviews[:10]


# **Updating the stopwords to include certain negative words**
# 
# These additional words will be useful in sentiment analysis but do not already exist in the provided stopwords

# In[1517]:


# updating the stopwords to include certain negative words which will be useful in sentiment analysis
STOPWORDS = nltk.corpus.stopwords.words('english')
updatestopwords = [word for word in STOPWORDS if word not in ['not', 'no', 'can','has','have','had','must','shan','do', 'should','was','were','won','are','cannot','does','ain', 'could', 'did', 'is', 'might', 'need', 'would']]
clean_reviews = [w for w in all_reviews if not w in updatestopwords]


# Clean phrases without punctuations and without stopwords:

# In[1518]:


# displaying only the first 10
clean_reviews[:10]


# **Applying NLT Word tokenizer to the cleaned reviews**
# 
# Since we have a clean corpus, NLT Word tokenizer - chosen from earlier analysis - is applied as below to give us clean tokens

# In[1519]:


clean_tokens = word_tokenizer(clean_reviews)

# display 3 sentence tokens
clean_tokens[:3]


# **Stemming and Lemmatization**

# Lemmatizing using **- WordNetLemmatizer**
# 
# The function below takes in the cleaned tokens from the previous section and applies NLTK WordNetLemmatizer() method.

# In[1520]:


def lemmatizer(doc):
    new_words = []
    wnl = nltk.WordNetLemmatizer()
    for word in doc:
        for t in word[0]:
            lemma = wnl.lemmatize(t)
            new_words.append(lemma)
    return new_words

# show the first 3 sentence tokens
lm = lemmatizer(clean_tokens[:3])
for item in lm:
    print(item)


# Stemming using **-PorterStemmer**
# 
# The function below takes in the cleaned tokens from the previous section and applies NLTK PorterStemmer() method.
# 
# It is notewrothy that this stemmer automatically converts every token to lowercase before further processing.

# In[1521]:


def stemmer(doc):
    stem = []
    porter = nltk.PorterStemmer()
    for t in doc:
        for item in t[0]:
            new_word = porter.stem(item)
            stem.append(new_word)
        
    return stem

# show the first 3 sentence tokens
stm = stemmer(clean_tokens[:3])
for item in stm:
    print(item)


# **Filtering**
# 
# Remove single word reviews since these will not embelish the sentiment detection process

# In[1522]:


def remove_char(doc):
    word_list=[]
    for word in doc:
        if (len(word[0]) > 1):
            word_list.append((word[0],word[1]))
    return word_list

cleaner_reviews = remove_char(clean_reviews)
cleaner_reviews[:10]


# ### Examining Tokens
# 
# **Tokens before preprocessing**
# 
# Applying the NLTK Word Tokenizer method discussed earlier before processing the reviews

# In[1523]:


# tokens before processing
b4t = []
before_t = word_tokenizer(reviews)
for (word,sentiment) in before_t:
    b4t.extend(word)

print(b4t[:70])

# length of tokens

print("\nTotal Tokens before processing: :", len(b4t))


# **Tokens after preprocessing**
# 
# The tokens before and after processing are shown below - with corresponding sizes. Only first 70 tokens are shown and will be used in subsequent analyses to better manage existing memory.

# In[1524]:


# tokens after processing
afterT = []
after_t = word_tokenizer(cleaner_reviews)
for (word,sentiment) in after_t:
    afterT.extend(word)
    
# only showing the first 70 tokens 
print(afterT[:70])

# length of tokens
print("\nTotal Tokens after processing :", len(afterT))


# ### STEP 3: FEATURE SELECTION ###

# **Create a Bag of Words Feature**
# 
# This function creates a bag of words and returns a specified number of most frequent words to be word features.
# 
# This will be reusable in future experiments

# In[1525]:


from nltk import FreqDist
def bag_of_words(corpus,wordcount):
    wordlist = nltk.FreqDist(corpus)
    word_features = [w for (w, c) in wordlist.most_common(wordcount)]
    return word_features


# **- Top 10 Unprocessed tokens word features:**

# In[1526]:


#  showing 10 Unprocessed token word features:
bag_of_words(b4t,10)


# **- Top 10 Pre-Processed tokens word features:**

# In[1527]:


#  showing 10 Unprocessed token word features:
bag_of_words(afterT,10)


# **Bag of words for Bigrams**
# 
# This function collects all the words in the corpus and select some number (depending on bigramcount passed as argument) of most frequent bigrams. 
# 
# chi-squared measure is used to get bigrams that are informative features.
# 
# Freq_filter removes words that only occurred with a frequency less than 3. 
# 
# Ngram_filter filters out bigrams in which the first word’s length is less than 2

# In[1528]:


from nltk.collocations import *
def bag_of_words_biagram(wordlist,bigramcount):
    bigram_measures = nltk.collocations.BigramAssocMeasures()
    finder = BigramCollocationFinder.from_words(wordlist,window_size=3)
    finder.apply_ngram_filter(lambda w1, w2: len(w1) < 2)
    finder.apply_freq_filter(3)
    bigram_features = finder.nbest(bigram_measures.chi_sq, 3000)
    return bigram_features[:bigramcount]


# **- Top 10 Unprocessed tokens word features(BIGRAMS)**

# In[1529]:


bag_of_words_biagram(b4t,10)


# **- Top 10 Pre-processed tokens word features(BIGRAMS)**

# In[1530]:


bag_of_words_biagram(afterT,10)


# Since the bigram finder must work with words in order, only the uprocessed tokens are used in this experiment

# **Unigram feature (Baseline feature for comparison):**

# This function returns a dictionary who’s each element is a word (obtained from bag of words function defined earlier) with a Boolean value indicating whether that word occurred in document or not. The feature label will be ‘has(keyword)’ for each keyword (i.e word) in the bag of words set

# In[1531]:


def unigram_features(doc, word_features):
    doc_words = set(doc)
    features = {}
    for word in word_features:
        features['has(%s)'%word] = (word in doc_words)
    return features


# An Example, looking at the top 20 most common word features from the unprocessed tokens

# In[1532]:


# word features from unprocessed tokens
wf = bag_of_words(b4t,20)


# apply
unigram_features(b4t,wf)
#uword_features

# **Bigram feature:**
# 
# This function takes the list of words in a document as an argument and returns a feature dictionary. It depends on the variables word_features and bigram_features

# In[1533]:


def bigram_features(doc,word_features,bigram_features):
    document_words = set(doc)
    document_bigrams = nltk.bigrams(doc)
    features = {}
    for word in word_features:
        features['has(%s)' % word] = (word in document_words)
    for bigram in bigram_features:
        features['bigram(%s %s)' % bigram] = (bigram in document_bigrams)
    return features


# Example Bigramsets_without_preprocessing

# In[1534]:


wf_b = bag_of_words_biagram(b4t,10)

bigram_feats = bigram_features(b4t,wf,wf_b)
bigram_feats


# **Building Feature set**
# 
# Below is the construction of **Unigramsets WITHOUT preprocessing**

# In[1535]:


unigramsets_without_preprocessing = [(unigram_features(d, wf), s) for (d, s) in reviews]


# In[1536]:


print("Unigramsets_without_preprocessing -")
print(unigramsets_without_preprocessing[0])


# Below is the construction of **Unigramsets WITH preprocessing**

# In[1537]:


unigramsets_with_preprocessing = [(unigram_features(d, wf), s) for (d, s) in cleaner_reviews]
print("Unigramsets_with_preprocessing -")
print(unigramsets_with_preprocessing[0])


# Below is the construction of **Bigramsets WITHOUT preprocessing**

# In[1538]:


bigramsets_without_preprocessing = [(bigram_features(d, wf,wf_b), s) for (d, s) in reviews]
print("Bigramsets_without_preprocessing -")
print(bigramsets_without_preprocessing[0])


# Below is the construction of **Bigramsets WITH preprocessing**

# In[1539]:


print("Bigramsets_with_preprocessing -")
bigramsets_with_preprocessing = [(bigram_features(d, wf,wf_b), s) for (d, s) in cleaner_reviews]
print(bigramsets_with_preprocessing[0])


# ### Negative Features###

# This section includes externally sourced negative word dictionary and also the processed version negative words from from prior cleaning. Also included is the processing for whitespaces in some negative words from the initial corpus such as "can't".

# In[1540]:


negative_words = ['abysmal','adverse','alarming','angry','annoy','anxious','apathy','appalling','atrocious','awful',
'bad','banal','barbed','belligerent','bemoan','beneath','boring','broken',
'callous','ca n\'t','clumsy','coarse','cold','cold-hearted','collapse','confused','contradictory','contrary','corrosive','corrupt','crazy','creepy','criminal','cruel','cry','cutting','dead','decaying','damage','damaging','dastardly','deplorable','depressed','deprived','deformed''deny','despicable','detrimental','dirty','disease','disgusting','disheveled','dishonest','dishonorable','dismal','distress','do n\'t','dreadful','dreary', 'enraged','eroding','evil','fail','faulty','fear','feeble','fight','filthy','foul','frighten','frightful',
'gawky','ghastly','grave','greed','grim','grimace','gross','grotesque','gruesome','guilty',
'haggard','hard','hard-hearted','harmful','hate','hideous','horrendous','horrible','hostile','hurt','hurtful',
'icky','ignore','ignorant','ill','immature','imperfect','impossible','inane','inelegant','infernal','injure','injurious','insane','insidious','insipid',
'jealous','junky','lose','lousy','lumpy','malicious','mean','menacing','messy','misshapen','missing','misunderstood','moan','moldy','monstrous',
'naive','nasty','naughty','negate','negative','never','no','nobody','nondescript','nonsense','noxious',
'objectionable','odious','offensive','old','oppressive',
'pain','perturb','pessimistic','petty','plain','poisonous','poor','prejudice','questionable','quirky','quit',
'reject','renege','repellant','reptilian','repulsive','repugnant','revenge','revolting','rocky','rotten','rude','ruthless',
'sad','savage','scare','scary','scream','severe','shoddy','shocking','sick',
'sickening','sinister','slimy','smelly','sobbing','sorry','spiteful','sticky','stinky','stormy','stressful','stuck','stupid','substandard','suspect','suspicious',
'tense','terrible','terrifying','threatening',
'ugly','undermine','unfair','unfavorable','unhappy','unhealthy','unjust','unlucky','unpleasant','upset','unsatisfactory',
'unsightly','untoward','unwanted','unwelcome','unwholesome','unwieldy','unwise','upset','vice','vicious','vile','villainous','vindictive',
'wary','weary','wicked','woeful','worthless','wound','yell','yucky',
'are n\'t','cannot','ca n\'t','could n\'t','did n\'t','does n\'t','do n\'t','had n\'t','has n\'t','have n\'t','is n\'t','must n\'t','sha n\'t','should n\'t','was n\'t','were n\'t','would n\'t',
'no', 'not', 'never', 'none', 'nowhere', 'nothing', 'noone', 'rather', 'hardly', 'scarcely', 'rarely', 'seldom', 'neither', 'nor']


# This function will pre-process above mentioned negative words dictionary:

# In[1541]:


def negativewordproc(negativewords):
    nwords = []
    nwords = cleanextend(negativewords)
    nwords = lemmatizer(nwords)
    nwords = stemmer(nwords)
    return nwords

processnwords = negativewordproc(negative_words)
negative_words = negative_words + processnwords


# I look for negation words and negate the word following the negation word. I will go through the document words in order adding the word features, but if the word follows a negation words, change the feature to negated word.

# In[1542]:


def negative_features(doc, word_features, negationwords):
    features = {}
    for word in word_features:
        features['has({})'.format(word)] = False
        features['has(NOT{})'.format(word)] = False
    # go through document words in order
    for i in range(0, len(doc)):
        word = doc[i]
        if ((i + 1) < len(doc)) and (word in negationwords):
            i += 1
            features['has(NOT{})'.format(doc[i])] = (doc[i] in word_features)
        else:
            if ((i + 3) < len(doc)) and (word.endswith('n') and doc[i+1] == "'" and doc[i+2] == 't'):
                i += 3
                features['has(NOT{})'.format(doc[i])] = (doc[i] in word_features)
            else:
                features['has({})'.format(word)] = (word in word_features)
    return features


# **Negativesets without preprocessing -**

# In[1543]:


# showing negative features without preprocessing
negative_features(b4t[:5],wf,negative_words)


# ###  STEP 4: EXPERIMENTS
# 
# ### 1. POS Tags

# The function below runs the default POS tagger (Stanford tagger) on a given document and counts 4 types of pos tags to use as features

# In[1544]:


def POS_features(doc, word_features):
    document_words = set(doc)
    tagged_words = nltk.pos_tag(doc)
    features = {}
    for word in word_features:
        features['contains({})'.format(word)] = (word in document_words)
    numNoun = 0
    numVerb = 0
    numAdj = 0
    numAdverb = 0
    for (word, tag) in tagged_words:
        if tag.startswith('N'): numNoun += 1
        if tag.startswith('V'): numVerb += 1
        if tag.startswith('J'): numAdj += 1
        if tag.startswith('R'): numAdverb += 1
    features['nouns'] = numNoun
    features['verbs'] = numVerb
    features['adjectives'] = numAdj
    features['adverbs'] = numAdverb
    return features


# **- POS Sets without preprocessing**
# Calling the function on tokens before processing:

# In[1545]:


# word features from unprocessed tokens
# wf = bag_of_words(b4t,20)
# where b4t = word tokens before processing

# wf is the wordfeatures built earlier before tokenization
# showing only first 20 tokens


POS_features(b4t, wf)


# **- POS Sets with preprocessing:**

# In[1546]:


# word features after processing
wf_after = bag_of_words(afterT,20)

#apply
POS_features(afterT, wf_after)


# ### 2. Sentiment Lexicon(Subjectivity) feature:###
# 
# In order to use this function, we will define one additional function that reads subjectivity words from the subjectivity lexicon file and returns dictionary, where each word is mapped to a list containing the strength and polarity.

# This function is not imported from sentiment_read_Subjectivity.py as this function is not similar to sentiment_read_Subjectivity.py. This function is modified to include pre-processed version of all words in SL for our pre-processed tokens.
# 
# In order to pre-process individual words in SL dictionary, I have defined another function. This function takes word and returns stemmed and lemmatized version of it.

# In[1547]:


def wordproc(word):
    wnl = nltk.WordNetLemmatizer()
    porter = nltk.PorterStemmer()
    nwords = wnl.lemmatize(word)
    nwords = porter.stem(nwords)
    return nwords


# This feature function will calculate word counts of subjectivity words. Negative feature will have number of weakly negative words + 2 * number of strongly negative words. Same way it will count for positive features. It will not count neutral words

# In[1548]:


the_SL_path = "C:/Academics/Natural Language Processing/Final Project/FinalProjectData/FinalProjectData/kagglemoviereviews/SentimentLexicons/subjclueslen1-HLTEMNLP05.tff"
    
def SL_features(doc, word_features, path):
    # this is the path where the subjectivity doc is located.
    # the following lines connects to the file and reads the subjectivity 
    flexicon = open(path, 'r')
    sldict = { }
    for line in flexicon:
        fields = line.split() # split on whitespace
        # split each field on the '=' and keep the second part as the value
        strength = fields[0].split("=")[1]
        word = fields[2].split("=")[1]
        posTag = fields[3].split("=")[1]
        stemmed = fields[4].split("=")[1]
        polarity = fields[5].split("=")[1]
        if (stemmed == 'y'):
            isStemmed = True
        else:
            isStemmed = False
        # put a dictionary entry with the word as the keyword
        # and a list of the other values
        procword = wordproc(word)
        sldict[procword] = [strength, posTag, isStemmed, polarity]
        sldict[word] = [strength, posTag, isStemmed, polarity]

#def SL_features(doc, word_features):   
    # the following lines processes and counts positive and negative words
    document_words = set(doc)
    features = {}
    for word in word_features:
        features['contains({})'.format(word)] = (word in document_words)
        # count variables for the 4 classes of subjectivity
        weakPos = 0
        strongPos = 0
        weakNeg = 0
        strongNeg = 0
    for word in document_words:
        if word in sldict:
            strength, posTag, isStemmed, polarity = sldict[word]
        if strength == 'weaksubj' and polarity == 'positive':
            weakPos += 1
        if strength == 'strongsubj' and polarity == 'positive':
            strongPos += 1
        if strength == 'weaksubj' and polarity == 'negative':
            weakNeg += 1
        if strength == 'strongsubj' and polarity == 'negative':
            strongNeg += 1
        features['positivecount'] = weakPos + (2 * strongPos)
        features['negativecount'] = weakNeg + (2 * strongNeg)
    
    if 'positivecount' not in features:
        features['positivecount']=0
    if 'negativecount' not in features:
        features['negativecount']=0
    return features


# **Subjectivitysets without preprocessing -**

# In[1549]:


SL_features(b4t, wf, the_SL_path)


# **Subjectivitysets with preprocessing -**

# In[1550]:


SL_features(afterT, wf, the_SL_path)


# Note- Based on a study, more past tense verbs mean negative sentiment and more superlative adverb, means positive sentiment so counting POS will also help in sentiment analysis

# **LIWC Features**

# I have added pre-processed version of positive words and negative words to their respective dictionary that I got by reading LIWC sentiment lexicon file. For this I have reused function defined for pre-processing of negative words dictionary.

# In[1551]:


import sentiment_read_LIWC_pos_neg_words
poslist,neglist = sentiment_read_LIWC_pos_neg_words.read_words()
poslist = poslist+negativewordproc(poslist)
neglist = neglist+negativewordproc(neglist)


# I have defined another function that will calculate word counts of positive and negative words just like we did subjectivity count earlier.

# In[1552]:


def liwc_features(doc, word_features,poslist,neglist):
    doc_words = set(doc)
    features = {}
    for word in word_features:
        features['contains({})'.format(word)] = (word in doc_words)
    pos = 0
    neg = 0
    for word in doc_words:
        if sentiment_read_LIWC_pos_neg_words.isPresent(word,poslist):
            pos += 1
        if sentiment_read_LIWC_pos_neg_words.isPresent(word,neglist):
            neg += 1
        features['positivecount'] = pos
        features['negativecount'] = neg
        if 'positivecount' not in features:
            features['positivecount']=0
        if 'negativecount' not in features:
            features['negativecount']=0
    return features


# **Liwcsets without preprocessing -**

# In[1553]:


liwc_features(b4t, wf,poslist,neglist)


# **Liwcsets with preprocessing -**

# In[1554]:


liwc_features(afterT, wf,poslist,neglist)


# ### STEP 5: CLASSIFICATION

# ### Training and Employing a Naïve Bayes classifier
# 
# Next,the feature extractor is used to process the names data, and divide the resulting list of feature sets into a training set and a test set.
# 
# Naïve Bayes classifier is used to train and test data with 25% as test set initially.
# 
# The training set is used to train a new "naive Bayes" classifier.

# Finally, the classifier is examined to determine which features it found most effective for distinguishing the reviews along with a confusion matrix, and summary scores (Accuracy, Recall, F-measure)

# In[1555]:


import collections
import nltk.metrics
from nltk.classify import NaiveBayesClassifier
from nltk.metrics import ConfusionMatrix
from nltk.metrics import scores


# In[1556]:


def nltk_naive_bayes(featuresets,percent):
    
    # get training and test ratios
    training_size = int(percent*len(featuresets))
    train_set, test_set = featuresets[training_size:], featuresets[:training_size]
    
    # train classifer on training set
    classifier = nltk.NaiveBayesClassifier.train(train_set)
    refsets = collections.defaultdict(set)
    testsets = collections.defaultdict(set)
    
    # builds for confusion matrix
    reflist = []
    testlist = []
    for (features, label) in test_set:
        reflist.append(label)
        testlist.append(classifier.classify(features))
    
    for i, (feats, label) in enumerate(test_set):
        refsets[label].add(i)
        observed = classifier.classify(feats)
        testsets[observed].add(i)
    cm = ConfusionMatrix(reflist, testlist)
    
    print("Naive Bayes Classifier ")
    
    ############INFORMATIVE FEATURES#################33
    print("Showing most informative features:")
    print(classifier.show_most_informative_features(10))
    
    ############CONFUSION MATRIX#################33
    print("Confusion matrix:")
    #print(cm)
    print(cm.pretty_format(sort_by_count=True, show_percents=True))
    
    #############ACURACY######################3
    print("Accuracy : ",nltk.classify.accuracy(classifier, test_set))

    
    # sets needed for subsequent measures
    reference_set = set(refsets)
    test_set = set(testlist)
   
    ############PRECISION####################
    print("Precision:", nltk.scores.precision(reference_set, test_set))
    
    ###########RECALL##################
    print("Recall:", nltk.scores.recall(reference_set, test_set))
    
    ###############F-MEASURE###################
    print("F-measure:", nltk.scores.f_measure(reference_set, test_set))
    
    


# **Classification of UNIGRAM sets WITHOUT preprocessing: 
# Accuracy, Most Informative Features, Confusion Matrix**

# In[1557]:


nltk_naive_bayes(unigramsets_without_preprocessing, 0.25)


# From the results, the classifier has 0.5 accuracy while a review that has the word "but" has equal likelihood to be either positive or slightly negative

# **Classification of UNIGRAM sets WITH preprocessing: 
# Accuracy, Most Informative Features and Confusion Matrix**

# In[1558]:


nltk_naive_bayes(unigramsets_with_preprocessing, 0.25)


# From the results, the classifier has 0.5 accuracy while a review that has the word "but" has equal likelihood to be either positive or slightly negative

# ### Using different classifiers within the Sci-Kit Learn ecosystem to compare with baseline NLTK Naive Bayes Classifiers
# 
# Below, I call different classifiers within the Sklearn cluster then print their performance scores

# In[1559]:


from nltk.classify.scikitlearn import SklearnClassifier
from sklearn.naive_bayes import MultinomialNB, BernoulliNB
from sklearn.linear_model import LogisticRegression, SGDClassifier
from sklearn.svm import SVC, LinearSVC, NuSVC
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier


def sklearn(featuresets,percent):
    training_size = int(percent*len(featuresets))
    train_set, test_set = featuresets[training_size:], featuresets[:training_size]
     
    classifier1 = SklearnClassifier(MultinomialNB())
    classifier1.train(train_set)
    print("ScikitLearn Classifier-MultinomialNB")
    print("Accuracy : ",nltk.classify.accuracy(classifier1, test_set))
    print(" ")
    
    classifier2 = SklearnClassifier(BernoulliNB())
    classifier2.train(train_set)
    print("ScikitLearn Classifier-BernoulliNB")
    print("Accuracy : ",nltk.classify.accuracy(classifier2, test_set))
    print(" ")
    classifier3 = SklearnClassifier(DecisionTreeClassifier())
    classifier3.train(train_set)
    print("ScikitLearn Classifier-Decision Tree")
    print("Accuracy : ",nltk.classify.accuracy(classifier3, test_set))
    print(" ")
    classifier4 = SklearnClassifier(LogisticRegression())
    classifier4.train(train_set)
    print("ScikitLearn Classifier-LogisticRegression")
    print("Accuracy : ",nltk.classify.accuracy(classifier4, test_set))
    print(" ")
    classifier5 = SklearnClassifier(SGDClassifier())
    classifier5.train(train_set)
    print("ScikitLearn Classifier-SGDCClassifier")
    print("Accuracy : ",nltk.classify.accuracy(classifier5, test_set))
    print(" ")
    classifier6 = SklearnClassifier(SVC())
    classifier6.train(train_set)
    print("ScikitLearn Classifier-SVC")
    print("Accuracy : ",nltk.classify.accuracy(classifier6, test_set))
    print(" ")
    classifier7 = SklearnClassifier(LinearSVC()) 
    classifier7.train(train_set)
    print("ScikitLearn Classifier-LinearSVC")
    print("Accuracy : ",nltk.classify.accuracy(classifier7, test_set))
    print(" ")
    classifier8 = SklearnClassifier(NuSVC(nu=0.09))
    classifier8.train(train_set)
    print("ScikitLearn Classifier-NuSVC")
    print("Accuracy : ",nltk.classify.accuracy(classifier8, test_set))
    print(" ")
    classifier9 = SklearnClassifier(RandomForestClassifier())
    classifier9.train(train_set)
    print("ScikitLearn Classifier-RandomForest")
    print("Accuracy : ",nltk.classify.accuracy(classifier9, test_set))
    print(" ")


# **Scores from different classifiers - WITHOUT PREPROCESSING:**

# In[1560]:


sklearn(unigramsets_with_preprocessing,0.25)


# **Scores from different classifiers - WITH PREPROCESSING:**

# In[1561]:


sklearn(unigramsets_with_preprocessing,0.25)


# ### CROSS-VALIDATION###

# **Tri-fold Fold Performances of Naive Bayes classifier against feature sets -**
# 
# Below, I undertake cross validation using three fold method.

# **Starting with unigrams Features**

# First, I create a method that evaluates performance measures, which I then call in the subsequent classification method.

# In[1562]:


def eval_measures(reflist, testlist, label_list):
    #initialize sets
    # for each label in the label list, make a set of the indexes of the ref and test items
    # store them in sets for each label, stored in dictionaries
    # first create dictionaries
    ref_sets = {}
    test_sets = {}
    # create empty sets for each label
    for lab in label_list:
        ref_sets[lab] = set()
        test_sets[lab] = set()
   
    # get gold labels
    for j, label in enumerate(reflist):
        ref_sets[label].add(j)
    
    # get predicted labels
    for k, label in enumerate(testlist):
        test_sets[label].add(k)
    
    # lists to return precision and recall for all labels
    precision_list = []
    recall_list = []
    
    #compute precision and recall for all labels using the NLTK functions
    for lab in label_list:
        precision_list.append ( precision(ref_sets[lab], test_sets[lab]))
        recall_list.append ( recall(ref_sets[lab], test_sets[lab]))
    return (precision_list, recall_list)


def naive_bayes(num_folds, featuresets, label_list):
    subset_size = int(len(featuresets)/num_folds)
    # overall gold labels for each instance (reference) and predicted labels (test)
    reflist = []
    testlist = []
    accuracy_list = []
    print("Naive Bayes Classifier")
    # iterate over the folds
    for i in range(num_folds):
        print('Start Fold', i)
        test_this_round = featuresets[i*subset_size:][:subset_size]
        train_this_round = featuresets[:i*subset_size]+featuresets[(i+1)*subset_size:]
        # train using train_this_round
        classifier = nltk.NaiveBayesClassifier.train(train_this_round)
        # evaluate against test_this_round and save accuracy
        accuracy_this_round = nltk.classify.accuracy(classifier, test_this_round)
        print(i, accuracy_this_round)
        accuracy_list.append(accuracy_this_round)
    # add the gold labels and predicted labels for this round to the overall lists
    for (features, label) in test_this_round:
        reflist.append(label)
        testlist.append(classifier.classify(features))
    print('Done with cross-validation')
    # call the evaluation measures function
    print('mean accuracy-', sum(accuracy_list) / num_folds)
    #(precision_list, recall_list) = eval_measures(reflist, testlist, label_list)
    #print_evaluation (precision_list, recall_list, label_list)
    print(" ")


# Crossvalidation of unigram sets with preprocessing, with 10 iterations

# In[1563]:


naive_bayes(10, unigramsets_with_preprocessing, ['0','1','2','3','4'])


# Crossvalidation of unigram sets without preprocessing

# In[1564]:


naive_bayes(10, unigramsets_without_preprocessing, ['0','1','2','3','4'])

