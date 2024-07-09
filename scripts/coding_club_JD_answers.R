#Required packages for generation of data:
#here
#randomNames

#go to the root directory
here::i_am("scripts/coding_club_data.R")


#load libraries
library(here)
library(randomNames)

#show the working directory
here()

#set the seed
#this makes the outputs the same on the first run
set.seed(4736)

#Set the length of the data. The practice data set 
datalength<-2500000

#Set the length of the data. Here it is set to 10000 to make a smaller dataset
#datalength<-40000

#Generate a list of names using the randomNames package
name<-c(randomNames(datalength, gender=c(1:2), ethnicity=c(1:5)))


#assign random numbers for the number of ice creams produced
#generated using a normal distribution
icecreams_consumed<-as.numeric(round(rnorm(datalength, mean=7000, sd=1000),0))


#create a list of good seabirds
seabirds<-c("Mediterranean gull", "Sooty shearwater", "Storm Petrel", "Roseate tern", "Arctic tern", "Common tern",
            "Sandwich tern", "Little tern", "Kittiwake", "Great black-backed gull", "Black-headed gull", "Razorbill",
            "Guillemot", "Shag", "Puffin", "Manx shearwater", "Fulmar", "Red-throated diver", "Great northern diver")


#create a biased sample of favorite seabird
favorite_seabird<-sample(seabirds, datalength, replace=T, prob = c(runif(19)))

#create a data frame
data <- data.frame(name=name,
                   icecreams_consumed=icecreams_consumed,
                   favorite_seabird=favorite_seabird)

#write the dataset to the data folder (this takes a little while)
#write.csv(data, here("data", "task1.csv"), row.names = F)
#write.csv(data, here("data", "task1_small.csv"), row.names = F)



#Example Question#

#How many people were surveyed?
peoplenumber<-nrow(data)

paste("There were",peoplenumber,"people surveyed")





#Task questions#
#
#1#How many people ate less than 50 ice creams?
#
no_ice_eaters<-length(which(data$icecreams_consumed<50))

paste("There were",no_ice_eaters,"people who ate less than 50 icecreams.")

#"There were 0 people who ate less than 50 icecreams."


#
#2#How many people chose a puffin as their favorite seabird?
#
puffin_lovers<-length(which(data$favorite_seabird=="Puffin"))

paste("There were",puffin_lovers,"people who chose a puffin as their favorite seabird.")

#"There were 129600 people who chose a puffin as their favorite seabird."


#
#3#How many people chose a Kittiwake as their favorite seabird and ate over 7000 ice creams?
#
Kittiwake_and_icecream<-length(which(data$favorite_seabird=="Kittiwake"&data$icecreams_consumed>50))

paste("There were",Kittiwake_and_icecream,"people who chose a kittiwake as their favorite seabird and ate over 7,000 icecreams.")

#"There were 88053 people who chose a kittiwake as their favorite seabird and ate over 7,000 icecreams."


#
#4#How many people had first names starting with P?
#
firstnames<-sapply(strsplit(as.character(data$name), ", "), "[[", 2) #get a list of just first names. where we extract names after the comma and space.

first_name_letter<-substr(firstnames,0,1)

How_many_P<-length(which(first_name_letter=="P"))

paste("There were",How_many_P,"people who had a first name starting with P.")

#"There were 42273 people who had a first name starting with P."


#
#5#How many people had second names starting with A?
#
second_name_letter<-substr(firstnames,0,1)

How_many_A<-length(which(second_name_letter=="A"))

paste("There were",How_many_A,"people who had a second name starting with A.")

#"There were 303389 people who had a second name starting with A."


#
#6#How many people had double barreled surnames (contains a -)?
#
secondnames<-sapply(strsplit(as.character(data$name), ", "), "[[", 1) #get a list of just first names. where we extract names after the comma and space.

double_barrel<- length(which(grepl("-", secondnames, fixed = TRUE)))

paste("There were",double_barrel,"people who had a double barreled surname.")

#"There were 70941 people who had a double barreled surname."


#
#7#What was the name of the person who ate the most ice creams of those who liked the Sandwich tern?
#
icecream_tern_fan<-data$name[data$favorite_seabird=="Sandwich tern"][
  which.max(data$icecreams_consumed[data$favorite_seabird=="Sandwich tern"])]


paste0("The person who ate the most ice creams who likes sandwich terns was ",icecream_tern_fan,".")

#"The person who ate the most ice creams who likes sandwich terns was Blackwater, Patrick."


#
#8#Ordered alphabetically, by first name, who comes 89,576th?
#
whichindividual<-89576

reversename<-paste0(sapply(strsplit(as.character(data$name), ", "), "[[", 2),", ", sapply(strsplit(as.character(data$name), ", "), "[[", 1))

name_ordered<-reversename[order(reversename)][whichindividual]

paste0("The individual at position ",whichindividual, " when ordered alphabetically is ",name_ordered,".")


#"The individual at position 89576 when ordered alphabetically is Alexia, Nguyen."


#
#9#How many names contained the exact sting of letters "ame" at some point in their names (continuous string with no breaks)?
#
ame_name<- length(which(grepl("ame", data$name, fixed = TRUE)))


cat(paste(ame_name, "people had the letters \"ame\" in their name."))#note the cat function is concatenate and print. We use this to remove the \ escape character.

#24882 people had the letters "ame" in their name.



#
#10#Of those people with "ame" in their name, how many chose the Red-throated diver and ate greater than 8000 ice creams?
#
subset <- data[which(grepl("ame", data$name, fixed = TRUE)),]

how_many_ice_dive <- nrow(subset[subset$favorite_seabird=="Red-throated diver"&subset$icecreams_consumed>8000,])

cat(paste(how_many_ice_dive, "people had the letters \"ame\" in their name, liked RTDs and ate over 8000 icecreams."))#note the cat function is concatenate and print. We use this to remove the \ escape character.

#40 people had the letters "ame" in their name, liked RTDs and ate over 8000 icecreams..

