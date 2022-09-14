# Set-up your script ------------------------------------------------------

# install.packages(c("tidyverse", "gapminder", "pacman")) # uncomment if already installed
pacman::p_load(tidyverse, gapminder)

# Load your Data into R ---------------------------------------------------

data(gapminder)
head(gapminder)

# Clean your Data ---------------------------------------------------------

gapminder_clean <- gapminder %>% 
  rename(life_exp = lifeExp, gdp_per_cap = gdpPercap) %>% 
  mutate(gdp = pop * gdp_per_cap)


# Subsetting --------------------------------------------------------------
# Next, and using the tidyverse, subset our cleaned df to include only countries
# in the Americas.

gapminder_clean |> 
  dplyr::distinct(continent) # check the continents

gapminder_clean_americas <-  gapminder_clean |> 
  dplyr::filter(continent == "Americas")


# Categorical -------------------------------------------------------------
# Finally, also add a new categorical variable using mutate() that qualifies 
# whether a country is rich or poor! 
# (Hint use the variable gdp_per_cap and ìf_else())

gapminder_clean |> 
  ggplot(aes(x = gdp_per_cap)) +
  geom_histogram()

gapminder_clean |> 
  dplyr::summarise(
    mean(gdp_per_cap, na.rm = TRUE)
  )

# From World Bank: https://data.worldbank.org/indicator/NY.GDP.PCAP.CD  
# High income	2021	47,886.8	
# Low & middle income	2021	5,530.4	
# Low income	2021	749.8	
# Lower middle income	2021	2,581.9	
# Middle income	2021	6,102.0	
# Upper middle income	2021	10,835.5

gapminder_clean_category <- gapminder_clean |> 
  mutate(
    category = if_else(gdp_per_cap <= 6000, "poor", "rich"),
    category = as_factor(category)
  )

