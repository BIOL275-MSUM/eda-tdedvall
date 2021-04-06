# load packages -----------------------------

library(tidyverse)

vignette("BIEN_tutorial")

library(BIEN)

library(ape) #Package for working with phylogenies in R

library(maps) #Useful for making quick maps of occurrences

library(sp) # A package for spatial data


# read data ---------------------------------

Solidago_altissima <- BIEN_occurrence_species(species = "Solidago altissima")

str(Solidago_altissima)

head(Solidago_altissima)

Solidago_altissima_full <- BIEN_occurrence_species(species = "Solidago altissima",cultivated = T,only.new.world = F,all.taxonomy = T,native.status = T,observation.type = T,political.boundaries = T)

str(Solidago_altissima_full)


# Make a quick map to plot our points on --------------------------------


map('world', fill = T, col= "grey", bg = "light blue") 


#Plot the points from the full query in red -----------------------------------


points(cbind(Solidago_altissima$longitude,Solidago_altissima$latitude),col = "red",pch = 20,cex = 1) 


# Plot the points from the default query in blue-------------------


points(cbind(Solidago_altissima$longitude,Solidago_altissima$latitude),col = "blue",pch = 20,cex = 1) 


# Map of specimens based on country occurrence ----------


Solidago_altissima_range <- BIEN_ranges_load_species(species = "Solidago altissima")


# First, let's add a base map so that our range has some context:

map('world',fill = T , col= "grey", bg = "light blue",xlim = c(-180,-20),ylim = c(-60,80))


# Now, we can add the range map:

plot(Solidago_altissima_range,col = "green",add = T)

# Separate frequency by country

T1 <- select(Solidago_altissima_full,country)

T1

summarize(T1, country)

arrange(T1,country)

T2 <- filter(Solidago_altissima_full, country == "United States")
T2

T3 <- filter(Solidago_altissima_full, country == "Canada")
T3

count(Solidago_altissima_full, country)

count(T2)

count(T3)


#GG plot

ggplot(data = Solidago_altissima_full) +
  geom_bar(mapping = aes(x = fct_infreq(country)), fill = "#C5351B") +
  labs(x = "Country", y = "Frequency (number of Solidago altissima)") +
  scale_y_continuous(limits = c(0, 1200), expand = expansion(mult = 0)) +
  theme_classic(base_size = 12) +
  theme(
    axis.title = element_text(face = "bold"),
    axis.text = element_text(color = "black", size = rel(1)),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.ticks.x = element_blank()
  )





#Citations

BIEN_metadata_database_version()

temp_dir <- file.path(tempdir(), "BIEN_temp") #Set a temporary working directory

citation()
citation("BIEN")
citation("dplyr")
citation("ggplot2")

citation_info <- BIEN_metadata_citation

getRversion()



