# Data frame Manipulation with dplyr

# 6 verbs/commands with dplyr()
# manipulate data frames

# load library
library(dplyr)

# import data
gapminder <- read.csv('../data/gapminder_data.csv')

# summary
mean(gapminder[gapminder$continent == 'Africa', 'gdpPercap'])
mean(gapminder[gapminder$continent == 'Americas', 'gdpPercap'])

# dplyr
# pipe %>%

# SELECT
year_country_gdp <- select(gapminder, year, country, gdpPercap)
names(year_country_gdp)
str(year_country_gdp)

# using dplyr
# select to keep
year_country_gdp <- gapminder %>% select(year, country, gdpPercap)
# select to remove
temp <- gapminder %>% select(-year, -country, -gdpPercap)

# FILTER
year_country_gdp_euro <- gapminder %>%
  filter(continent == 'Europe')
str(year_country_gdp_euro)

year_country_gdp_euro <- gapminder %>%
  filter(continent == 'Europe') %>%
  select(year, country, gdpPercap)
str(year_country_gdp_euro)

# GROUP_BY() # use the criteria in filter
# SUMMARIZE() # get some statistics
gapminder %>% group_by(continent) %>% str()
unique(gapminder$continent)

gdp_bycontinents <- gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))
class(gdp_bycontinents)
str(gdp_bycontinents)

# add more groups
# only continent
gdp_pop_bycontinents_byyear <- gapminder %>%
  group_by(continent) 
str(gdp_pop_bycontinents_byyear)

# only year
gdp_pop_bycontinents_byyear <- gapminder %>%
  group_by(year) 
str(gdp_pop_bycontinents_byyear)

# year and continent
gdp_pop_bycontinents_byyear <- gapminder %>%
  group_by(continent,year) 
str(gdp_pop_bycontinents_byyear)

gdp_pop_bycontinents_byyear <- gapminder %>%
  group_by(continent,year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop))

gdp_pop_bycontinents_byyear <- gapminder %>%
  group_by(year,continent) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop))
  
# COUNT() 
# N()

gapminder %>% filter(year == 2002) %>%
  count(continent, sort = TRUE)
  
gapminder %>% group_by(continent) %>%
  summarize(se_le = sd(lifeExp)/sqrt(n()))
  
# MUTATE
# similar to cbind

gdp_pop_bycontinents_byyear <- gapminder %>%
  mutate(gdp_billion = gdpPercap*pop/10^9) 
str(gdp_pop_bycontinents_byyear)

gdp_pop_bycontinents_byyear <- gapminder %>%
  mutate(gdp_billion = gdpPercap*pop/10^9) %>%
  group_by(continent,year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop),
            mean_gdp_billion = mean(gdp_billion),
            sd_gdp_billion = sd(gdp_billion))
  
  
# 
  
  
  

