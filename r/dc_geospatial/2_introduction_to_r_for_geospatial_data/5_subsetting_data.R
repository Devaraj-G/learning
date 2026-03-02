# Subsetting data

# Import data
gapminder <- read.csv('../data/gapminder_data.csv')

str(gapminder)
head(gapminder[3])

# difference between [] [[]]
head(gapminder['pop'])
head(gapminder[['pop']])
typeof(head(gapminder['pop'])) # list
typeof(head(gapminder[['pop']])) # double

gapminder[1:3,]


