# ---
# jupyter:
#   jupytext:
#     formats: ipynb,py:percent
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.19.2
#   kernelspec:
#     display_name: dl_workshop
#     language: python
#     name: python3
# ---

# %% [markdown]
# # 1. Problem: Predict penguins' species using dataset

# %% [markdown]
# # 2. What are the inputs/outputs?

# %%
import seaborn as sns

# %%
# Load data
penguins = sns.load_dataset('penguins')

# %%
# Inspect data
penguins.head()

# %%
penguins.shape

# %%
# Visulaization
sns.pairplot(penguins, hue = 'species')

# %%
sns.pairplot(penguins, hue = 'sex')

# %% [markdown]
# # Prepare data

# %%
# Drop categorical columns
penguins_filtered = penguins.drop(columns = ['island', 'sex'])
penguins_filtered.head()

# %%
penguins_filtered.shape

# %%
# Clean missing values
penguins_filtered = penguins_filtered.dropna()
penguins_filtered.head()

# %%
penguins_filtered.shape

# %%
# Remove the output variable
features = penguins_filtered.drop(columns = ['species'])
features.head()

# %%
features.shape

# %%
# Prepare target for trainig
import pandas as pd
target = pd.get_dummies(penguins_filtered['species'])
target.head()

# %%
target[200:210]

# %%
# Split into test/train sets
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(features, target,
                                                  test_size = 0.2,
                                                  random_state = 0,
                                                  shuffle = True)
temp = X_test
temp['species'] = penguins_filtered['species']
sns.pairplot(temp, hue = 'species')

# %%
# Split into test/train sets
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(features, target,
                                                  test_size = 0.2,
                                                  random_state = 0,
                                                  shuffle = True,
                                                  stratify = target)

# %%
temp = X_test
temp['species'] = penguins_filtered['species']
sns.pairplot(temp, hue = 'species')

# %% [markdown]
# # 4. Build architecture from scratch

# %%
# Keras for NN
from tensorflow import keras

# %%
# Set random seeds
keras.utils.set_random_seed(2)

# %%
X_train.shape

# %%
inputs = keras.Input(shape = (X_train.shape[1],)) # 4 features
print(inputs)

# %%
hidden_layer = keras.layers.Dense(10,activation = 'relu')(inputs)
print(hidden_layer)

# %%
output_layer = keras.layers.Dense(3, activation = 'softmax')(hidden_layer)
print(output_layer)

# %%
model = keras.Model(inputs = inputs, outputs = output_layer)
print(model)

# %%
model.summary()

# %% [markdown]
# keras.utils.plot_model(
#     model,
#     show_shapes=True,
#     show_layer_names=True,
#     show_layer_activations=True,
#     show_trainable=True
# )

# %%
model.dtype

# %%
