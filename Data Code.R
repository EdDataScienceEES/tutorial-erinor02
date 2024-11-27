#Simulating data for Tutorial
#Erin O'Rourke
#Nov 2024

# Set seed for reproducibility
set.seed(123)

# Simulate species abundance data for 3 Habitats and 20 species
samples <- paste0("Habitat", 1:3)
species <- paste0("Species", 1:20)

#Create data frame
biodiversity_data <- as.data.frame(
  matrix(sample(0:20, 60, replace = TRUE), nrow = 3, ncol = 20)
)

#Add Column names and row names of each habitat
colnames(biodiversity_data) <- species
rownames(biodiversity_data) <- c("Rocky shores", "Sandy shores", "Mudflats")

# View the data set
print(biodiversity_data)

#Save data set as csv
write.csv(biodiversity_data, "biodiversity_data.csv", row.names = FALSE)
