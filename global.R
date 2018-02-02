library(shiny)
library(twitteR)
library(wordcloud2)
library(tidyverse)
library(stringr)
library(tm)
library(qdap)
library(ggmap)
library(leaflet)
library(shinythemes)
#library(DT)

key <- "3eMXFqy2BuLASVbOgCF4DZnFj"
secret <- "Hg7GIC7eWlpTWXzpWNPAQWZgTFksE3VbWAji1SYnWGwEpaENqr"
token <- "142256976-srCgqBoT0oMm2Oj9qwAmLVmBlNgKz1f1mD4mpdw1"
accesstoken <- "Ov7wPnQXoak4kD35VJJfnjVrSk9QK3DwKfgVlzsOM0EBd"

setup_twitter_oauth(key, secret, token, accesstoken)