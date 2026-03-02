# Exploring data frames

# Import data
gapminder <- read.csv('../data/gapminder_data.csv')

str(gapminder)
head(gapminder)

class(gapminder)
names(gapminder)
class(gapminder$country)
class(gapminder$year)

str(gapminder$country)

length(gapminder)
nrow(gapminder)
ncol(gapminder)

colnames(gapminder) # sames as names()
rownames(gapminder) # just row number here

# create new column/row
below_average <- gapminder$lifeExp < 70.5 # avg. life exp. # is logical
cbind(gapminder, below_average) # same nrows as gapminder or completely divides it
below_average <- c(TRUE, FALSE, TRUE)
head(cbind(gapminder, below_average)) # copies itself

below_average <- gapminder$lifeExp < 70.5
gapminder <- cbind(gapminder, below_average)
head(gapminder)

new_row <- list('Norway', 2016, 5000000, 'Nordic', 80.3, 49400.0, FALSE)
gapminder_norway <- rbind(gapminder, new_row)
tail(gapminder_norway)

# factors
gapminder$continent <- factor(gapminder$continent)
gapminder$country <- factor(gapminder$country)

str(gapminder)
levels(gapminder$continent)
class(gapminder$continent)

new_row <- list('Norway', 2016, 5000000, 'Nordic', 80.3, 49400.0, FALSE)
gapminder_norway <- rbind(gapminder, new_row)

tail(gapminder_norway) # Nordic has been changed to NA

levels(gapminder$continent) <- c(levels(gapminder$continent), 'Nordic')
gapminder_norway <- rbind(gapminder, new_row)
tail(gapminder_norway)

# or revert factors to character
gapminder$continent <- as.character(gapminder$continent)
str(gapminder)







