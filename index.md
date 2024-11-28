# Community Ecology - Biodiversity indices and Visualisation

By Erin O'Rourke

Nov 2024

## An introduction to calculating various Biodiversity indices using `vegan` and creating visualisations of these patterns

<center> <img src="{{ site.baseurl }}/figures/coding club logo.png" alt="Img" style="width: 200px;"/> </center>


<span style="background-color: lightblue; color: black;">
This tutorial is aimed at those with a basic understanding of R and would like to further their skills specifically related to community ecology data. </span>

In this tutorial, we will learn about various biodiversity matrices and how to calculate these using the `vegan` package. The key matrices we will cover are Shannons Diversity Index, Simpsons Index, Species richness and Species evenness. We will then cover ways to visualise community data through simple boxplots,rank abundance curves followed by slightly more complex heat maps. Finally you can have a go with another data set to consolidate your learning. 


## Tutorial Aims

#### <a href="#section1"> 1. Introduction to biodiversity indices and how to calculate them using `vegan`                             package </a>
####      <a href="#section1.1">   1.1. Species Richness </a>
####      <a href="#section1.2">   1.2. Shannon's Diversity Index </a>
####      <a href="#section1.3">   1.3. Simpson's Index of Diversity  </a>
####      <a href="#section1.4">   1.4. Species Evenness </a>

#### <a href="#section2"> 2. Simple ways of Visualising Community data </a>
####      <a href="#section2.1">   2.1. Barplots </a>

#### <a href="#section3"> 3. More complex ways of visualising Community data</a>
####      <a href="#section3.1">   3.1. Stacked bar graphs </a>
####      <a href="#section3.2">   3.2. Rank Abundance Curves </a>
####      <a href="#section3.3">   3.3. Heatmaps </a>

#### <a href="#section4"> 4. Exercise: Fish data</a>

#### <a href="#section5"> 5. The End</a>


---------------------------


<a name="section1"></a>

## 1. Introduction to biodiversity indices and how to calculate them using `vegan` package

Measuring Biodiversity is an important aspect of Community Ecology as it helps to understand ecosystem health and stability however it is a complex term which defines and includes: 

 - the number of species present in the community, ecosystem or globally
 - the evolutionary diversity represented by these species
 - the diverse communities and ecosystems these species build
 
As biological diversity is a complex term it can be measured in many different ways, one area often focused on is species diversity. The main methods we will use to assess species diversity are: 

1 - Species Richness measures

2 - General indices of species diversity: Shannon's Diversity Index, Simpsons Index of Diversity

3 - Species Evenness measures 


To begin we are going to Open `RStudio` and first create a **new script** by clicking on `File/New File/R Script`. Then we will fist download the packages that are required for this tutorial. 

```r
# Make sure to set the working directory
setwd("your_filepath")

#Load the following packages 
library(vegan)
library(ggplot2)
library(dplyr)
library(ggpubr)
library(tidyr)
library(viridis)

#If you don't have these pacakges installed use the code below by removing the #
#install.packages("vegan")
#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("ggpubr")
#install.packages("tidyr")
#install.packages("viridis")

```
<span style="background-color: orange; color: black;">
Many real community data sets are very complex and large containing many species, habitats and observations which can often make them harder to analyse so for the purpose of this tutorial I have created a more simple data set that can be downloaded from github. It was created in r and the code used to create the data can be found in the git hub data folder. </span>

**You can find all the data that you require for completing this tutorial on this [GitHub repository](https://github.com/EdDataScienceEES/tutorial-erinor02/tree/master/data).** Lets start by loading in the data and then check the column headings to ensure it has been correctly imported. 

```r
#Load the data
data<-read.csv("/data/biodiversity_data.csv")

#Check the column headings of the data
head(data)

#To explore the data
str(data)

```
<center> <img src="{{ site.baseurl }}/figures/data.png" alt="Img" style="width: 800px;"/> </center>

From this we can see that the species columns are integers this may cause some issues down the line so we will convert them to numeric. 

```r

# Convert species columns to numeric
data <- data %>%
         mutate_at(c(2:21),as.numeric)

# Now check the data again to see if they have been converted to numeric
str(data)

```
<center> <img src="{{ site.baseurl }}/figures/data_clean.png" alt="Img" style="width: 800px;"/> </center>





<a name="section1.1"></a>

### 1.1 Species Richness

Species richness is the number of different species in a defined area and it is merely a numerical characteristic of a community. It doesn't incorporate the abundance of individual species found within the defined area or how evenly they are distributed. It is a simple measure that can useful to give an indication of the complexity of the ecosystem and it can be used to compare different communities. It is often expressed as S. 

Species richness is the number of different species in a defined area and is calculated using `specnumber` in the `vegan` package. 

```r
#function used to calculate species richness
species_richness <- specnumber(data)

#print the result of Species Richness
print(species_richness)

```
<center> <img src="{{ site.baseurl }}/figures/species_richness.png" alt="Img" style="width: 800px;"/> </center>

From the results of this we can see that species richness is relatively similar across all habitats with Sandy Shores having the lowest. 




<a name="section1.2"></a>

### 1.2 Shannon's Diversity Index

There are several different species diversity indices that can be used. These indices are more complex and account for variation in both the number of species and the way that individuals within the community are distributed among species. These indices of diversity incorporate richness, commonness and rarity (evenness). 

Shannon's Diversity Index accounts for richness and evenness and is caculated using the `diversity()` function. 

```r

#To use the `diversity()` function can only be calculated with numeric values so we will have to remove the first column that contains that habitat names
index_data <- data[, -1]

#Function used to calculate shannons diversity index
shannon_index <- diversity(index_data, index = "shannon")

#print the results of shannons diversity index
print(shannon_index)
```
<center> <img src="{{ site.baseurl }}/figures/shannon_index.png" alt="Img" style="width: 800px;"/> </center>

Shannons diversity index is interpreted as higher values indicate a greater diversity therefore we can see that the Rocky Shores habitat has the greatest diversity. 




<a name="section1.3"></a>

### 1.3 Simpson's Index of Diversity 

Simpson's Index of Diversity focuses on the domanince or evenness and is also calculated with the `diversity()` function as follows. 

```r

#Calculate simpsons diversity 
simpson_index <- diversity(index_data, index = "simpson")

#print the results of Simpsons Index of Diversity
print(simpson_index)
```
<center> <img src="{{ site.baseurl }}/figures/simpson_index.png" alt="Img" style="width: 800px;"/> </center>

Based on the output we can see that values closer to 1 indicate a higher evenness showing that all of the habitats display a high evenness 




<a name="section1.4"></a>

###  1.4 Species Evenness

Species Evenness quantifys how evenly individuals are distributed among species and is calculated using shannons diversity index and specis richness. 

```r

#Calculate Species Evenness
evenness <- shannon_index / log(species_richness)

#print the results of Species Evenness
print(evenness)
```

<center> <img src="{{ site.baseurl }}/figures/evenness.png" alt="Img" style="width: 800px;"/> </center>

from this we can see...


We can now compile all of these diversity matrices in to one data frame to eaisly compare the results across habitats. 

```r

#compile the Diversity indicies into one data frame

results <- data.frame(
  Habitat=c("Rocky shores", "Sandy shores", "Mudflats"),
  Shannon = shannon_index,
  Simpson = simpson_index,
  Richness = species_richness,
  Evenness = evenness)
  
#show the all of the results together
View(results)

```
<center> <img src="{{ site.baseurl }}/figures/results.png" alt="Img" style="width: 800px;"/> </center>




### TOP TIP: When to use what?

As Shannons and Simpsons diversity indexs are calculating someting simlar you wouldn't use them bothe on one dataset. To decide which one to use depnds on what you are wanting too look at in your data and also how big your sample size is. Simpsons diversity index is best used for studies placing most importance on changes in the number and relative abundance of abundant (I.e common) species and it requires decent sample size. Shannon's Diversity on the other hand is best used for studies placing most importance on changes in the number and relative abundance of rare species and is less sensitive to sample size.Therefore as we have a small sample size shannons diversity index is best suited for our data **The most important thing is to be consistant and use the same index through out your study.**




<a name="section2"></a>

## 2. Simple ways of Visualising Community data

viualistation is an important aspect of



<a name="section2.1"></a>

### 2.1. Barplots 


First lets create a simple graph to display Shannons diversity Index. We will use base r to create a simple bar plot.

```r
simple_plot <- barplot(shannon_index, names.arg = c("Rocky shores", "Sandy shores", "Mudflats"),
        xlab = "Habitats", ylab = "Shannon's Index")
```
<center> <img src="{{ site.baseurl }}/figures/simple_plot.png" alt="Img" style="width: 800px;"/> </center>

However this a very dull and unapealing graph to make it more more visuallly appealing we will use `ggplot2` as it eneables more freedom to create prettier graphs.

```r
(shannon_plot <- ggplot(results, aes(x=Habitat,y=Shannon,fill=Habitat)) + #Using the results data and indicating that we are using shannons index and that each habitat will be a different colour
       geom_col() + 
       labs(x = "Habitats", y = "Shannon's Index") + #Naming the x and y axis
      scale_fill_brewer(palette = "Set2") +  # Use a color palette from RColorBrewer which is contained within `ggplot2`
       theme_classic() +  #Set the theme of the graph to classic whcih makes it simple and easy to understand
       theme(legend.position="none") + #Remove the legend as the names are under the bars
         scale_y_continuous(limits = c(0, 3),                # Set the y-axis limits 
                            breaks = seq(0, 3, by = 0.5)))     # Create breaks in the axis every 0.5
```
<center> <img src="{{ site.baseurl }}/figures/shannon_plot.png" alt="Img" style="width: 800px;"/> </center>

Now that looks a much nicer graph! You can customise this in any way you want and also use it to display the other results such as richness. 

```r
(richness_plot <- ggplot(results, aes(x=Habitat,y=Richness,fill=Habitat)) + #Using the results data and indicating that we are using Richness and that each habitat will be a different colour
       geom_col() + 
       labs(x = "Habitats", y = "Richness") + #Naming the x and y axis
      scale_fill_brewer(palette = "Set1") +  # Use a color palette from RColorBrewer which is contained within `ggplot2`
       theme_classic() +  #Set the theme of the graph to classic whcih makes it simple and easy to understand
       theme(legend.position="none")) #Remove the legend as the names are under the bars
```
<center> <img src="{{ site.baseurl }}/figures/richness_plot.png" alt="Img" style="width: 800px;"/> </center>

We can then arrange the plots so they sit nicely beside each other with the `ggarrange` function from the `ggpubr` package. 

```r
(combinded_plot <- ggarrange(shannon_plot, richness_plot,
                          nrow=1,  
                          ncol=2))

```
<center> <img src="{{ site.baseurl }}/figures/combined_plot.png" alt="Img" style="width: 800px;"/> </center>





<a name="section3"></a>

## 3. More complex ways of visualising Community data

next we are going to look at some other ways to display community data. The next graphs all require some initial manipulation of the data to ensure it is in the correct format. 



<a name="section3.1"></a>
### 3.1. Stacked bar graphs

Another way to look at the data is though a stacked bar plot of the abundance of each species in each habitat. This is especially useful to highlight the spread in abundances of species across the different habitats  to. First do this we will first have to convert our data to long format this is fairly straightforward with the `dplyr` package. 

```r
data_long <-data %>%
  pivot_longer(cols = starts_with("Species"),    # Converting the data into long form, columns which start with Species are pivoted into two columns
               names_to = "Species",      # Species containing the column names
               values_to = "Abundance") %>%   # Abundance containing the values
      rename(Habitat=X)   #renaming the X column to Habitat

# View the reshaped data
View(data_long)

```
<center> <img src="{{ site.baseurl }}/figures/data_long.png" alt="Img" style="width: 800px;"/> </center>

Now you can see that the data is in long format with 3 columns, 1 for Habitat, 1 for Species and finally one for Abundance.

and then create the graph

```r
stacked_plot <- ggplot(data_long, aes(x = Habitat, y = Abundance, fill = Species)) +
  geom_bar(stat = "identity") +  # Use bars to represent abundance
  labs(x = "Habitats",
       y = "Abundance") +
  scale_fill_viridis(discrete = TRUE,option="plasma") +  # Use the viridis color palette
  theme_minimal() +
  theme(legend.title = element_blank())

```
<center> <img src="{{ site.baseurl }}/figures/stacked_plot.png" alt="Img" style="width: 800px;"/> </center>




<a name="section3.2"></a>

### 3.2. Rank Abundance Curves

Another way to display the data is through rank abundance curves

```r

# Create Rank Abundance Curve
biodiversity_long <- biodiversity_long %>%
  group_by(Habitat) %>%
  arrange(Habitat, desc(Abundance), .by_group = TRUE) %>%
  mutate(Rank = row_number())  # Rank species by abundance
```

Then we can plot the graph


```r
# Plot Rank Abundance Curve
abundance_curve <- ggplot(biodiversity_long, aes(x = Rank, y = Abundance, color = Habitat, group = Habitat)) +
  geom_line() +  # Line for each habitat
  geom_point() +  # Points for each species
  labs(title = "Rank Abundance Curve for Species Across Habitats",
       x = "Rank of Species",
       y = "Abundance") +
  theme_minimal() +
  theme(legend.title = element_blank())  # Remove legend title

```
<center> <img src="{{ site.baseurl }}/figures/abundance_curve.png" alt="Img" style="width: 800px;"/> </center>



<a name="section3.3"></a>


### 3.3. Heatmaps


First lets create a heat map
```r
simple_heatmap <- heatmap(as.matrix(index_data))
```
<center> <img src="{{ site.baseurl }}/figures/simple_heatmap.png" alt="Img" style="width: 800px;"/> </center>

This is very basic and not very informative to improve this we will add various things to it 

```r
heatmap_plot <- heatmap(as.matrix(index_data), Colv=NA, Rowv=NA, scale="row",col=cm.colors(150))
```
<center> <img src="{{ site.baseurl }}/figures/heatmap_plot.png" alt="Img" style="width: 800px;"/> </center>



<a name="section4"></a>

## 4. Exercise: Fish Data

<span style="background-color: orange; color: black;">
This section is completely optional it is just if you want to practice and consolidate your skills on a real world data set! </span>


First we will load in the data,

```r
fish_data<-load.csv("/data/fish_data.csv")
```

This data is part of MCR LTER Coral Reef Long-term Population and Community Dynamics Fishes and taken from the bioTIME website. The data was gathered of the coast of the island of Mo'orea, located within the French Polynesia. It includes diver observations of  all mobile taxa of fishes observed on a five by fifty meter transect which extends from the bottom to the surface of the water column. Tn this data set there are 3 plots which will be the different habitats to be compared. 

The data will first require some initial tidying before it can be analysed. Then have a go at calculating the some of the  biodiversity indices that you have just learnt. Finally create a graph to visualise the data like the what we have just created. 



<a name="section5"></a>

## 5. The End

###Learning Outcomes:

 - Effectively use the `vegan` package to calculate various biodiversity indices
 - Use `ggplot2` to create simple barplots to display the results of the biodiversity indices
 - Create more complex graphs (stacked bar graph, rank abundance curve, heatmaps) which first require some manipulation of the data 
 
 
<span style="background-color: lightblue; color: black;">
Well done for completing the tutorial! I hope you gained some skills to improve your data manipulation and can apply them to your own data problems.</span>



<hr>
<hr>

#### Check out our <a href="https://ourcodingclub.github.io/links/" target="_blank">Useful links</a> page where you can find loads of guides and cheatsheets.

#### If you have any questions about completing this tutorial, please contact us on ourcodingclub@gmail.com

#### <a href="INSERT_SURVEY_LINK" target="_blank">We would love to hear your feedback on the tutorial, whether you did it in the classroom or online!</a>

<ul class="social-icons">
	<li>
		<h3>
			<a href="https://twitter.com/our_codingclub" target="_blank">&nbsp;Follow our coding adventures on Twitter! <i class="fa fa-twitter"></i></a>
		</h3>
	</li>
</ul>

### &nbsp;&nbsp;Subscribe to our mailing list:
<div class="container">
	<div class="block">
        <!-- subscribe form start -->
		<div class="form-group">
			<form action="https://getsimpleform.com/messages?form_api_token=de1ba2f2f947822946fb6e835437ec78" method="post">
			<div class="form-group">
				<input type='text' class="form-control" name='Email' placeholder="Email" required/>
			</div>
			<div>
                        	<button class="btn btn-default" type='submit'>Subscribe</button>
                    	</div>
                	</form>
		</div>
	</div>
</div>




