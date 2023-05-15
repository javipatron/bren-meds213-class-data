# This code demonstrates how one could create EML metadata in R from scratch for a dataset
# We will be only covering a tiny fraction of the schema (eml-dataset-module)
# We will be using an adapted dataset from a Dryad deposit as an example: https://doi.org/10.5061/dryad.dz08kprw0
# Please refer to the insert-record.csv, methods.md, abstract.md and README-losapio.txt files to complete this exercise.


# Load Packages

# Starting our EML Record
# Describing the Coverage (Temporal and Geographic)

library(tidyverse)
library(EML)
library(emld)
library(here)

setwd(here::here())

# Read the Dataset
insect_records <- read_csv("week6/insect-record.csv")

geographicDescription <- "Loma del Mulhacen, Sierra Nevada, Andalucia, Spain"

coverage <- 
  set_coverage(begin = "2015-07-01", end = "2015-07-31",
               geographicDescription = geographicDescription,
               west = -3.30, east = 3.30, 
               north = 37.05, south = 37.05,
               altitudeMin = 600, altitudeMaximum = 3396,
               altitudeUnits = "meter")

# Methods

methods_file <- "week6/methods.md"
methods <- set_methods(methods_file)


losapio <- eml$creator(
  individualName = eml$individualName(
    givenName = "Gianalberto",
    surName = "Losapio"),
  electronicMailAddress = "losapiog@stanford.edu")
    
publisher <- "Standford University"

pubDate <- "2021"

title <- "Plant-pollinator observations for: An experimental approach to assessing the impact of ecosystem engineers on biodiversity and ecosystem functions"


contact <- list(
  individualName = "losapio$individualName",
  electronicMailAddress = losapio$electronicMailAddress,
  organizationName = "Standford University")

abstract_file <- "./abstract.md"

abstract_set <- set_TextType(abstract_file)

intellectualRights <- "Creative Commons CC0 License"


# Time to create our dataset element!

dataset <- list(
  title = title,
  creator = losapio,
  pubDate = pubDate)

# We should now create our root element for EML which will hang everything else

eml <- list(
  packageId = uuid::UUIDgenerate(),
  system = "uuid", # type of identifier - Universally Unique Identifiers
  dataset = dataset)

# Getting close! Time to write and validate our EML record!


# If you got [1] TRUE that means success!


# Wait! We are missing the attribute metadata at the file-level which is the heart of an EML dataset record!
# We will work on a separate script file (dataTable).
# Make sure to copy it here when ready, and add the dataTable to the elements's list before re-running the code.
