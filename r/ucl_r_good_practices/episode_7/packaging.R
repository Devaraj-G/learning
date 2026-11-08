# R packages have:
# R code in R/
# tests in tests/
# data in data/
# vignettes in vignettes/
# test in tests/
# keep eyes open for usethis and devtools

# can create package using Rstudio new menu
# can create via usethis inside the folder where you want the package folder to be
usethis::create_package('sleep')
# error if inside a project, delet ethe .gitignore file
remotes::install_github('stellaprins/obscurepackage') # already there from before

# namesapce
here::here() # works ok, bu
lubridate::here() # gives not exported message

var <- function(x) -5
var('1111')
stats::var(1:5) # to show var inside sd is unaffected

# within sleep folder
usethis::use_r('load_sleep_data') # and then overwrite the file with data folder file
# now instead of using usethis::use_r('summarise_data'), copy the file directly from the data folder
usethis::use_r('summarise_data')
usethis::use_r('plot_summary')

# use devtools
devtools::load_all() # load package functions
data <- load_sleep_data()
summary_data <- summarise_data(data)
print(summary_data)
plot_summary(summary_data)
plot_summary(summary_data, fill = 'darkorange', title = 'Extra sleep by drug')
# So we have loaded the R scripts/functions and they work like a loaded package
# Let's see help
?summarise_data # nothing as documentation was not generated

# generate documentation
devtools::document()
?summarise_data # works now

devtools::load_all()
?load_sleep_data

# declaring dependencies
usethis::use_package('datasets')
usethis::use_package('dplyr', min_version = '1.1.0')
usethis::use_package('ggplot2', min_version = '3.0.0')
usethis::use_package('R', type = 'Depends', min_version = '4.1.0')

devtools::load_all()

# let's expose the functions in te namesapce by adding @export at the end of the documentation
devtools::load_all()
# but need document regeneration
devtools::document()

# if adding analysis scripts not part of the package, then put hem in a folder and ignore
usethis::use_build_ignore('scripts') # .Rbuildignore gets this added in

# load it properly
devtools::install() # load_all for development, install() copies it as in install.packages()
# check in packages pane

source('./scripts/sleep_analysis.R') # runs but no figure
source("./scripts/sleep_analysis.R", echo=TRUE) # get sthe figure in the pane

# check package
devtools::check()

# update files for solving bindng warnings
# add dependency rlang
usethis::use_package('rlang', min_version = '1.0.0')

usethis::use_mit_license()
usethis::use_readme_md()
