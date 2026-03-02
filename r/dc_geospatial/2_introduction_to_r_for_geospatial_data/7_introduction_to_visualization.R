# Introduction to visualization

# load library
library("ggplot2")

# import data
gapminder <- read.csv('../data/gapminder_data.csv')

# histogram
ggplot(data = gapminder,
       aes(x = lifeExp)) +
  geom_histogram()

ggplot(data = gapminder,
       aes(x = gdpPercap)) +
  geom_histogram()

# filter for Americas for year 2007
gapminder_small <- gapminder %>%
  filter(year == 2007, continent == 'Americas')

ggplot(data = gapminder_small,
       aes(x = country, y = gdpPercap)) +
  geom_col()

ggplot(data = gapminder_small,
       aes(x = country, y = gdpPercap)) +
  geom_col() +
  coord_flip()

# filter for years between 1952 and 2007
gapminder_small_2 <- gapminder %>%
  filter(continent == 'Americas', year %in% c(1952,2007))
gapminder_small_2 <- gapminder %>%
  filter(continent == 'Americas', year >=1952, year<=2007) # doesn't work
ggplot(data = gapminder_small_2,
       aes(x = country, y = gdpPercap)) +
  geom_col() +
  coord_flip()





