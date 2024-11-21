#Simulating data for Tutorial
#Erin O'Rourke
#Nov 2024

# Set seed for reproducibility
set.seed(123)

# Simulate species abundance data for 10 samples and 15 species
samples <- paste0("Site", 1:15)
species <- paste0("Species", 1:20)

biodiversity_data <- as.data.frame(
  matrix(sample(0:20, 150, replace = TRUE), nrow = 15, ncol = 20)
)
colnames(biodiversity_data) <- species
rownames(biodiversity_data) <- samples

# Add habitat information (optional)
biodiversity_data$Habitat <- c("Forest", "Grassland", "Wetland", "Forest",
                               "Grassland", "Wetland", "Forest", "Grassland",
                               "Wetland", "Forest","Grassland", "Wetland", "Forest",
                               "Grassland", "Wetland")

# View the dataset
print(biodiversity_data)

#Save data set as csv

write.csv(biodiversity_data, "tutorial data.csv", row.names = FALSE)
