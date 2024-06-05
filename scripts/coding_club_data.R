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
write.csv(data, here("data", "task1.csv"), row.names = F)




#Example Question#

#How many people were surveyed?
peoplenumber<-nrow(data)

paste("There were",peoplenumber,"people surveyed")



#Task questions#

#1#How many people ate less than 50 ice creams?


#2#How many people chose a puffin as their favorite seabird?


#3#How many people chose a Kittiwake as their favorite seabird and ate over 7000 ice creams?


#4#How many people had first names starting with P?


#5#How many people had second names starting with A?


#6#How many people had double barreled surnames (contains a -)?


#7#What was the name of the person who ate the most ice creams of those who liked the Sandwich tern?


#8#Ordered alphabetically, by first surname, who comes 89,576th


