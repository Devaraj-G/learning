# Data structures

# import data
nordic <- read.csv('../data/nordic-data.csv')

# explore data
names(nordic) # see the columns
nordic$country # see a column country
nordic$lifeExp # see column lifeExp

nordic$lifeExp * 12 # in months

nordic$lifeExp + nordic$country

class(nordic) # R class
typeof(nordic) # R data type

class(nordic$lifeExp)
typeof(nordic$lifeExp)

typeof(1)
typeof(1L)
typeof(TRUE)
typeof(1+1i)
typeof('banana')
typeof(factor('banana'))
class(factor('banana'))

# vectors or list
my_vector <- vector(length=3)
another_vector <- vector(mode = 'character', length = 3)

str(nordic)
str(nordic$lifeExp)
str(nordic$country)

combine_vector <- c(2,6,3)

quiz_vector <- c(2,6,'3') # all are type coerced into a character

coercion_vector <- c('a',TRUE)
# logical -> integer -> integer -> complex -> character

character_vector <- c('0','2','4')
coerced_vector <- as.numeric(character_vector)

combine_vector <- c(coercion_vector,'c')

my_series <- 1:10

another_series <- seq(1,10,by = 3)
exploded_vector <- seq(1,10,by = 0.5)

head(my_series, n = 2)
tail(my_series, n = 2)
length(my_series)
typeof(my_series)
class(my_series)

names(another_series)
names(another_series) <- c('a', 'b', 'c', 'd' )
names(another_series)

# Factors
nordic_countries <- c('Norway', 'Finland', 'Denmark', 'Iceland', 'Sweden')
str(nordic_countries)
categories <- factor(nordic_countries)
class(categories)
str(categories)

mydata <- c('case','control','control','case')
factor_ordering_example <- factor(mydata)
str(factor_ordering_example)
factor_ordering_example <- factor(mydata, levels = c('control', 'case'))
str(factor_ordering_example)







