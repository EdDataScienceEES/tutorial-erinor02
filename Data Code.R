#Simulating data for Tutorial
#Erin O'Rourke
#Nov 2024

library(dplyr)

# Set seed for reproducibility
set.seed(123)

# Simulate species abundance data for 3 Habitats and 20 species
samples <- paste0("Habitat", 1:3)
species <- paste0("Species", 1:20)

#Create data frame
biodiversity_data <- matrix(0, nrow = 3, ncol = 20)

# Habitat 1: species 1-5 (unique to habitat 1)
biodiversity_data[1, 1:5] <- sample(1:20, 5, replace = TRUE)

# Habitat 2: species 5-15 (overlap with habitat 1 for species 5-10)
biodiversity_data[2, 6:17] <- sample(1:20, 12, replace = TRUE)

# Habitat 3: species 10-20 (overlap with habitat 2 for species 10-15)
biodiversity_data[3, 6:20] <- sample(1:20, 15, replace = TRUE)

# Convert to data frame
biodiversity_data <- as.data.frame(biodiversity_data)

#Add Column names and row names of each habitat
colnames(biodiversity_data) <- species
rownames(biodiversity_data) <- c("Rocky shores", "Sandy shores", "Mudflats")


# View the data set
print(biodiversity_data)

#Save data set as csv
write.csv(biodiversity_data, "biodiversity_data.csv", row.names = TRUE)
