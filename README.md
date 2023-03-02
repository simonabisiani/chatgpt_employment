# Analysing tweets about ChatGPT and employment
This is a repo for a project at University of Surrey on the discourse around ChatGPT and work (employability, redundancies, threats, opportunities) that has evolved on Twitter since end on November 2022.

The main file is a [Jupyter notebook](https://github.com/simonabisiani/chatgpt_employment/blob/main/ChatGPT_employment_project.ipynb). The code should run without issues, but it does not repeat the data collection. It loads the data from the repo and proceeds on the afterwards steps (data processing and analysis).

I found out that quering the API for the singular form of a word (e.g., job) does not necessarily return tweets with the plural form (e.g., jobs). Thus today I ran a second data collection for those words we might wanted to have in plural (teams, tasks, threats, jobs, skills, ...). 

In the repository, the file [full_dataset_chatgpt.json](https://github.com/simonabisiani/chatgpt_employment/blob/main/full_dataset_chatgpt.json) is the first data collection, while [second_dataset_chatgpt.json](https://github.com/simonabisiani/chatgpt_employment/blob/main/second_dataset_chatgpt.json) is the second data collection. 
