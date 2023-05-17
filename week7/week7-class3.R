library(tidyverse)
library(DBI) #Core data base for connecting cursors
library(RSQLite)
library(dbplyr)

setwd("~/Documents/MEDS/Courses/eds213/bren-meds213-class-data/week7")
conn <- DBI::dbConnect(RSQLite::SQLite(), "database.db")
species <- tbl(conn, "Species")


# At this point, can use like any dataframe
# Add show_query() to see what SQL it is sending

species |> filter(Relevance == "Study species") |> 
  select(Scientific_name) |> 
  arrange(Scientific_name) |> 
  head(3) |> show_query()


# These "tables" are not true datagframes

species <- tbl(conn, "Species")
str(species)
dim(species)


local_copy <- species |> collect()
str(local_copy)
str(local_copy)

# Can do pretty much anything with these quasi-tables
test <- species |> 
  group_by(Relevance) |> 
  summarise(num_species = n())

test |> show_query()


species |> 
  mutate(Code = paste( "X", Code)) |> 
           show_query()






