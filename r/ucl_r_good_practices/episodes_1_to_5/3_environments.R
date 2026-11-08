# environment - project
# environment - renv

# Run/source script from friend
source('./data/sleep_analysis.R')

# get obscurepackage
# need library: remotes

remotes::install_github('stellaprins/obscurepackage') # see @HEAD

source('./data/sleep_analysis.R')

# install environment/dependency management library: renv
install.packages("renv")
?renv
??renv

# let's use renv
renv::init()
renv::install('ggplot2')
??renv::install
renv::install('stellaprins/obscurepackage')
renv::install('stellaprins/obscurepackage@v0.1.0')

source('./data/sleep_analysis.R') # box plots fine now

# renv.lock is not automatically updated
renv::status()
# update renv.lock
renv::snapshot()
# check discrepancy
renv::status()
# restore lock
renv::restore()

# Now friend give a DESCRIPTION.txt and new sleep_analysis_final.R file
# remove renv infrastructure i.e. renv folder and renv.lock file
renv::deactivate(clean=TRUE)
# initialise bare environment (renv folder only has renv, no dependency detection, so no lock file)
renv::init(bare = TRUE)
# let's detect dependencies
renv::dependencies('./data/') # reads from even .gitignored folder i.e. repos
# DESCRIPTION.txt (esp. if .txt is added while using download button on github) is not detected, rename it to DESCRIPTION i.e. no extensions, then works fine

# use remotes to install dependencies
install.packages('remotes')
remotes::install_deps('./data/') # default is current folder, or folder containing DESCRIPTION file
# the above steps add all the required libraries in project library but only from the DESCRIPTION file

# Now that packages are installed, let's run analysis scripts
source('./data/sleep_analysis.R') # no obscurepackage
source('./data/sleep_analysis_final.R') # runs

# Still no lock file, as no snapshot taken
?renv:snapshot # and use explicit to point to DESCRIPTION
# check if setting is explicit
renv::settings$snapshot.type()
renv::settings$snapshot.type('explicit') # if implicit, change to explicit, and re-check

# take snapshot
renv::snapshot() # does not go inside the data folder
renv::snapshot(description = './data/DESCRIPTION') # still doesn't update lock file
renv::snapshot(description = './data/DESCRIPTION', lockfile = './renv.lock') # still doesn't update lock file
# put DESCRIPTION in current folder
renv::snapshot()

# explicit and implicit give same list esp. if obscurepackage is installed then it becomes the additional member in implicit.
# accidenally remove a package
renv::remove('broom') # and check if scrpt fails
source('./data/sleep_analysis_final.R') # run fails
# so use restore
renv::status() # broom says n
renv::restore()

# to forcibly add a library,use record
renv::record("devtools") # but dependencies do not get recorded automatically, but  get picked up with next snapshot

