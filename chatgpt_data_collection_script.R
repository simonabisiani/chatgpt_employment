# install.packages("tidyverse")
# devtools::install_github("cjbarrie/academictwitteR", build_vignettes = TRUE)
library(tidyverse)
library(academictwitteR)

# QUERY ##############################################################

and <- "chatgpt"
or <- c("employment",
        "employability",
        "employer",
#        "employees", # post collection insertion
        "employee",         
        "unemployment",
        "unemployed",
        "job", 
#        "jobs", # post collection insertion
        "work",
        "skill",
#        "skills", # post collection insertion
        "taking over",
        "replace human",
        "performance",
        "concern",
#        "concerns", # post collection insertion
        "insecurity",
        "fear",
        "threat",
#        "threats", # post collection insertion
        "opportunities",
        "training",
        "creation", # captures job creation (the keyword job should already capture this)
        "displacement", # captures job displacement (the keyword job should already this)
        "occupation", # captures occupations
#        "occupations", # post collection insertion
        "earning", # captures earnings
#        "earnings", # post collection insertion
        "future demand",
        "education",
        "labour",
        "labor", # NEW SUGGESTION US spelling
        "task", # captures tasks
#        "tasks", # post collection insertion
        "industry",
        "workforce",
        "shortage", # captures shortages
        "collaboration", # captures collaborations
#       "collaborations", # post collection insertion
        "collaborate", 
        "human ai team",
        "team", # NEW SUGGESTION (would also capture the above)
#        "teams", # post collection insertion
        "economic", # captures also economic growth
        "economy")

queries <- paste(and, or)

# TESTING QUERIES ####################################################

query_counts <- data.frame()
for (i in queries) {
  iteration_i <- count_all_tweets(i,
                                  "2022-11-30T00:00:00Z",
                                  "2023-02-24T00:00:00Z",
                                  bearer_token,
                                  n = 500)
  iteration_i$query <- i  # Create a new column "query" and assign it the value of i
  query_counts <- bind_rows(query_counts, iteration_i)}


library(RColorBrewer)

# JOB VS JOBS
query_counts %>% 
  filter(str_detect(query, "job")) %>% 
ggplot(aes(x = as.Date(start), y = tweet_count, fill = query)) +
  geom_bar(stat = "identity", alpha = 0.8, position = "dodge") +
  scale_fill_brewer(palette = "Set1", name = "Query")+
  theme_minimal()+
  xlab("")+
  ylab("tweet count") +
  ggtitle("")+
  labs(subtitle = "")

# SKILL VS SKILLS
query_counts %>% 
  filter(str_detect(query, "skill")) %>% 
  ggplot(aes(x = as.Date(start), y = tweet_count, fill = query)) +
  geom_bar(stat = "identity", alpha = 0.8, position = "dodge") +
  scale_fill_brewer(palette = "Set1", name = "Query")+
  theme_minimal()+
  xlab("")+
  ylab("tweet count") +
  ggtitle("")+
  labs(subtitle = "")

# THREAT VS THREATS
query_counts %>% 
  filter(str_detect(query, "threat")) %>% 
  ggplot(aes(x = as.Date(start), y = tweet_count, fill = query)) +
  geom_bar(stat = "identity", alpha = 0.8, position = "dodge") +
  scale_fill_brewer(palette = "Set1", name = "Query")+
  theme_minimal()+
  xlab("")+
  ylab("tweet count") +
  ggtitle("")+
  labs(subtitle = "")

# TASK VS TASKS
query_counts %>% 
  filter(str_detect(query, "task")) %>% 
  ggplot(aes(x = as.Date(start), y = tweet_count, fill = query)) +
  geom_bar(stat = "identity", alpha = 0.8, position = "dodge") +
  scale_fill_brewer(palette = "Set1", name = "Query")+
  theme_minimal()+
  xlab("")+
  ylab("tweet count") +
  ggtitle("")+
  labs(subtitle = "")

# EMPLOYEE VS EMPLOYEES
query_counts %>% 
  filter(str_detect(query, "employee")) %>% 
  ggplot(aes(x = as.Date(start), y = tweet_count, fill = query)) +
  geom_bar(stat = "identity", alpha = 0.8, position = "dodge") +
  scale_fill_brewer(palette = "Set1", name = "Query")+
  theme_minimal()+
  xlab("")+
  ylab("tweet count") +
  ggtitle("")+
  labs(subtitle = "")

# TEAM VS TEAMS
query_counts %>% 
  filter(str_detect(query, "team")) %>% 
  ggplot(aes(x = as.Date(start), y = tweet_count, fill = query)) +
  geom_bar(stat = "identity", alpha = 0.8, position = "dodge") +
  scale_fill_brewer(palette = "Set1", name = "Query")+
  theme_minimal()+
  xlab("")+
  ylab("tweet count") +
  ggtitle("")+
  labs(subtitle = "")

# FULL DATA COLLECTION ###############################################

bearer_token <- "MY_TOKEN"

chatgpt_full_collection <- data.frame()
for (i in queries) {
  iteration_i <- get_all_tweets(
    query = i,
    start_tweets = "2022-11-30T00:00:00Z",
    end_tweets = "2023-02-24T00:00:00Z",
    n = Inf,
    bearer_token = bearer_token,
    data_path = "chatgpt_full_collection/")
  iteration_i$query <- i  # Create a new column "query" and assign it the value of i
  chatgpt_full_collection <- bind_rows(chatgpt_full_collection, iteration_i)}

saveRDS(chatgpt_full_collection, "chatgpt_full_collection.RDS")
data <- readRDS("chatgpt_full_collection.RDS")

tweets <- data %>% select(text, query, created_at, author_id)

#library(jsonlite)
file <- toJSON(tweets)
write(file, "full_dataset_chatgpt.json")


# SECOND DATA COLLECTION #############################################

and <- "chatgpt"
or <- c("employees", # post collection insertion
        "jobs", # post collection insertion
        "skills", # post collection insertion
        "concerns", # post collection insertion
        "threats", # post collection insertion
        "occupations", # post collection insertion
        "earnings", # post collection insertion
        "tasks", # post collection insertion
        "collaborations") # post collection insertion

queries <- paste(and, or)

chatgpt_second_collection <- data.frame()
for (i in queries) {
  iteration_i <- get_all_tweets(
    query = i,
    start_tweets = "2022-11-30T00:00:00Z",
    end_tweets = "2023-02-24T00:00:00Z",
    n = Inf,
    bearer_token = bearer_token,
    data_path = "chatgpt_second_collection/")
  iteration_i$query <- i  # Create a new column "query" and assign it the value of i
  chatgpt_second_collection <- bind_rows(chatgpt_second_collection, iteration_i)}

saveRDS(chatgpt_second_collection, "chatgpt_second_collection.RDS")

#library(jsonlite)
file <- toJSON(tweets)
write(file, "second_dataset_chatgpt.json")


