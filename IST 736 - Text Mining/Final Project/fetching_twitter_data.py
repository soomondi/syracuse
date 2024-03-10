# -*- coding: utf-8 -*-
"""
Created on Wed Oct  21 10:56:27 2019

@author: soomondi@syr.edu
"""

# import needed libs
import os
import tweepy as tw
import pandas as pd



# Twitter credentials for the app
consumer_key = 'wSwpL5RQcPjSUuiTTpV0C1vLp'
consumer_secret = 'Xp1N6m0qOJFmLmcvDFfYjTtAv61QUTpK3PezoZAmYUF5Ae8W8p'
access_key= '4086711688-QU1GXoYbRVFaKk2enoHg8r1d1oCpkSw1DBukqfP'
access_secret = 'emobMy849UMmhbxTna9526AlbjPg4UFGt4aoDNBjujsQV'


# pass twitter credentials to tweepy
auth = tw.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_key, access_secret)
api = tw.API(auth, wait_on_rate_limit=True)


# Search twitter for tweets
# Begin by defining the search term and the date_since for start date
search_words = "#tulsigabbard" + "-filter:retweets"  # I don't want retweets
date_since = "2019-10-16"

# collect tweets
tweets = tw.Cursor(api.search,
                   q=search_words,
                   lang="en",
                   since=date_since).items(1000)     # collects 1000 tweets since date_since



# breaking down the user tweets into columns
user_tweets = [[tweet.user.screen_name,
             tweet.user.location,
             tweet.user.created_at,
             tweet.text]
    for tweet in tweets]

print(user_tweets[:5])


# place user tweets into a pandas data frame
tweet_df = pd.DataFrame(user_tweets,
                        columns=['Username', 'Location', 'Date Created', 'Tweet'])

# export data frame to csv
export_df_csv = tweet_df.to_csv(r"C:\STEPHEN PERSONAL FILES\Grad School\FALL 2019\TEXT MINING WITH PYTHON\tweets.csv", header=True)
