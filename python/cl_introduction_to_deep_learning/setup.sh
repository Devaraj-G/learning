## Setup instructions

# Create directories
mkdir -p cl_introduction_to_deep_learning
mkdir -p cl_introduction_to_deep_learning/data 
mkdir -p cl_introduction_to_deep_learning/documents
mkdir -p cl_introduction_to_deep_learning/outputs 
mkdir -p cl_introduction_to_deep_learning/repos

# Create files
touch cl_introduction_to_deep_learning/README.md

# Download repos
git clone https://github.com/carpentries-lab/deep-learning-intro.git cl_introduction_to_deep_learning/repos/carpentries-lab/deep-learning-intro
git clone https://github.com/mxochicale/intro-to-deep-learning-carpentries-lab.git cl_introduction_to_deep_learning/repos/intro-to-deep-learning-carpentries-lab
git clone https://github.com/UCSBCarpentry/ml-deeplearning-notebooks.git cl_introduction_to_deep_learning/repos/ml-deeplearning-notebooks

# Download data
curl -L -o cl_introduction_to_deep_learning/data/weather_prediction_dataset_light.csv https://zenodo.org/records/5071376/files/weather_prediction_dataset_light.csv
curl -L -o cl_introduction_to_deep_learning/data/10970014.zip https://zenodo.org/api/records/10970014/files-archive && unzip cl_introduction_to_deep_learning/data/10970014.zip -d cl_introduction_to_deep_learning/data/10970014/


# Create and activate a virtual environment called `dl_workshop`
python3 -m venv cl_introduction_to_deep_learning/dl_workshop
source cl_introduction_to_deep_learning/dl_workshop/bin/activate

# Install the required packages in the environment
python3 -m pip install jupyter seaborn scikit-learn pandas tensorflow pydot

# (Optional) Install `graphviz`
sudo apt install graphviz




