---
layout: tutorial
title: Community Ecology - Calculating Biodiversity Matrices
subtitle: Tidying data, calculating various Biodiversity Matrices using vegan and creating visualisations of these patterns 
date: Nov 2024
author: Erin O'Rourke

---

<center><img src="{{ site.baseurl }}/coding club logo.png" alt="Img"></center>
this tutorial is aimed at those with aa basic understanding of R and would like to futher their skills specifficaly related to coomunity ecology data. 
In this tutorial, we will learn about various biodiversity matrices and how to calculate these using the `vegan` package. The key matrices we will cover are Shannons Diversity Index, Simpsons Index, Species 
richness and Species evenness. We will then cover ways to visualise community data through simple boxplots, heatmaps to show abundance, rank abundance curves and species accumulation curves. then we will move on to introduce the slightly more complex ordination techniques through NMDs (Non-Metric Multidimensional Scaling). Finally you can have a go with another data set to consolidate your learning. 

### Tutorial Aims

#### <a href="#section1"> 1. Introduction to biodiversity matrices and ways to Visualise Community data</a>

#### <a href="#section2"> 2. Using `vegan` package to calculate biodiversity indicies</a>

#### <a href="#section3"> 3. Visualising Community data </a>
#### <a href="#section3.1"> 3.1. Boxplots: Abundance and Diversity </a>
#### <a href="#section3.2"> 3.2. Heatmaps: Abundance </a>
#### <a href="#section3.3"> 3.3. Rank Abundance Curves</a>
#### <a href="#section3.4"> 3.4. Species accumulation Curves </a>

#### <a href="#section4"> 4. Visualisation of relationships through ordination (NMDs)</a>

#### <a href="#section5"> 5. Excersise: !!insert name of dataset!!</a>

#### <a href="#section7"> 6. The End</a>
---------------------------

<a name="section1"></a>

## 1. Introduction to biodiversity matrices and ways to Visualise Community data

Measuring Biodiversity is an important aspect of Community Ecology as it helps to understand ecosystem health and stability however it is a complex term which defines and includes: 
 - the number of species present in the community, ecosystem or globally
 - the evolutionary diversity represented by these species
 - the diverse communities and ecosystems these species build
 
As biological diversity is a complex term it can be measured in many different ways, one area often focused on is species diversity. The main methods used to assess species diversity are: 

1 - Species Richness measures
2 - General indices of species diversity 
3 - Species Evenness measures 

### 1 - Species Richness Measures
 
Species richness is the number of different species in a defined area and it is merely a numerical characteristic of a community. It doesn't incorporate the abundance of individual species found within the defined area or how evenly they are distributed. It is a simple measure that can useful to give an indication of the complexity of the ecosystem and it can be used to compare different communities. It is often expressed as S. 

### 2 - General indecies of species diversity 

There are several different species diversity indices that can be used. These indices are more complex and account for variation in both the number of species and the way that individuals within the community are distributed among species. These indices of diversity incorporate richness, commonness and rarity (evenness). 

Simpsons Index of Diversity - F

Shannon Weiner Diversity Index










<a name="section2"></a>

## 2. Using `vegan` package to calculate biodiversity indicies

To begin we are going to Open `RStudio` and first create a **new script** by clicking on `File/New File/R Script`. Then we will fist download the packages that are required for this tutorial. 

```r
# Make sure to set the working directory
setwd("your_filepath")

# Install the following packages
install.packages("vegan")
install.packages("ggplot2")
install.packages("dplyr")

#Load the following packages 
library(vegan)
library(ggplot2)
library(dplyr)

```
{% capture callout %}
Many real community data sets are very complex and large containing many species, habitats and observations which can often make them harder to analyse so for the purpose of this tutorial I have created a more simple data set that can be downloaded from github. It was created in r and the code used to create the data can be found in the git hub data folder. 
{% endcapture %}
{% include callout.html content=callout colour="important" %}

Then we will download the data set into r and check the column headings to ensure it has been correctly imported. 

```r
#Load the data
biodiversity_data<-read.csv("tutorial data.csv")

#Check the column headings of the data
head(biodiversity_data)

#To explore the data
str(biodiversity_data)

```
As this is a simple data set it is already tidy and ready to analyses. **Often there is an extra step here where you are required to organise and clean the data so it is able to be analysed.**

### 2.1 Species Richness

Species richness is the number of different species in a defined area and is calculated using `specnumber` in the `vegan` package. 

```r
#function used to calculate species richness
species_richness <- specnumber(biodiversity_data)

#print the result of Species Richness
print(species_richness)
```

From the results of this we can see that there is a high species richness with a total of in each habitat. 

### 2.2 Shannon's Diversity Index

Shannon's Diversity Index accounts for richness and evenness and is caculated using the `diversity()` function. 

```r

#function used to calculate shannons diversity index
shannon_index <- diversity(biodiversity_data, index = "shannon")

#print the results of shannons diversity index
print(shannon_index)
```

Shannons diversity index is interpreted as higher values indicate a greater diversity therefore we can see that the &&& habitat has the greatest diversity. 

### 2.3 Simpson's Index of Diversity 

Simpson's Index of Diversity focuses on the domanince or evenness and is also calculated with the `diversity()` function as follows. 

```r

#Calculate simpsons diversity 
simpson_index <- diversity(biodiversity_data, index = "simpson")

#print the results of Simpsons Index of Diversity
print(simpson_index)

```
based on the output we can see that values closer to 1 indicate a higher evenness. 


###  2.4 Species Evenness

Species Evenness quantifys how evenly individuals are distributed among species and is calculated using shannons diversity index and specis richness. 

```r

#Calculate Species Evenness
evenness <- shannon_index / log(species_richness)

#print the results of Species Evenness
print(evenness)
```
from this we can see...


We can now compile all of these diversity matrices in to one data frame to eaisly compare the results across habitats. 

```r
#compile the Diversity metrices into one data frame
results <- data.frame(
  Shannon = shannon_index,
  Simpson = simpson_index,
  Richness = species_richness,
  Evenness = evenness)
#show the all of the results together
print(results)
```
{% capture callout %}
###TOP TIP: When to use what?
As Shannons and Simpsons diversity indexs are calulateing someting simlar you wouldn't use them bothe on one dataset. To decide which one to use depnds on what you are wanting too look at in your data and also how big your sample size is. Simpsons diversity index is best used for studies placing most importance on changes in the number and relative abundance of abundant (I.e common) species and it requires decent sample size. Shannon's Diversity on the other hand is best used for studies placing most importance on changes in the number and relative abundance of rare species and is less sensitive to sample size. **The most important thing is to be consistant and use the same index through out your study.**
{% endcapture %}
{% include callout.html content=callout colour="alert" %}

<a name="section3"></a>

## 3. Visualising Community data

viualistation is an important aspect of


<a name="section3.1"></a>

### 3.1. Boxplots: Abundance and Diversity
```r
boxplot(specnumber(biodiversity_data) ~ rownames(biodiversity_data),
        main = "Species Richness by Habitat", xlab = "Habitat", ylab = "Richness")
```


```r
results$Habitat <- rownames(biodiversity_data)
results_long <- reshape2::melt(results, id.vars = "Habitat")

ggplot(results_long, aes(x = Habitat, y = value, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Biodiversity Indices by Habitat", y = "Value") +
  theme_minimal()
```


<a name="section3.2"></a>

### 3.2. Heatmaps: Abundance

```r
heatmap(as.matrix(biodiversity_data), scale = "column", col = terrain.colors(10),
        main = "Species Abundance Heatmap", xlab = "Species", ylab = "Habitats")
```


<a name="section3.3"></a>

### 3.3. Rank Abundance Curves

```r
# Rank-abundance plot for a single habitat (Forest)
forest_abundance <- sort(biodiversity_data["Forest", ], decreasing = TRUE)
plot(forest_abundance, type = "b", pch = 16, col = "blue",
     main = "Rank-Abundance Curve (Forest)", xlab = "Rank", ylab = "Abundance")
```


<a name="section3.4"></a>

### 3.4. Species accumulation Curves

```r
spec_accum_curve <- specaccum(biodiversity_data)
plot(spec_accum_curve, main = "Species Accumulation Curve", xlab = "Samples", ylab = "Richness")
```


<a name="section4"></a>

## 4. Visualisation of relationships through ordination (NMDs)





<a name="section5"></a>

## 5. Excersise: !!insert name of dataset!!




<a name="section6"></a>

## 6. The End