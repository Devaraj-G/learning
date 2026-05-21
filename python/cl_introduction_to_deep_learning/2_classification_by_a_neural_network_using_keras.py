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

# %%
# Import libraries
import tensorflow, sklearn
import seaborn as sns

# %%
# Print versions
print(tensorflow.__version__)
print(sns.__version__)
print(sklearn.__version__)

# %% [markdown]
# # Prepare data

# %%
penguins = sns.load_dataset('penguins')
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
features

# %%
# Split into test/train sets
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(features, target,
                                                  test_size = 0.2,
                                                  random_state = 0,
                                                  shuffle = True,
                                                  stratify = target)


# %% [markdown]
# # 4. Build architecture from scratch

# %%
# Keras for NN
from tensorflow import keras

# %%
# Set random seeds
keras.utils.set_random_seed(621)

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
keras.utils.plot_model(
    model,
    show_shapes=True,
    show_layer_names=True,
    show_layer_activations=True,
    show_trainable=True
)

# %% [markdown]
# # 5. Choose a loss function and optimizer

# %%
model.compile(optimizer='adam', loss=keras.losses.CategoricalCrossentropy())

# %% [markdown]
# # 6. Train model

# %%
history = model.fit(X_train, y_train, epochs=100)

# %%
sns.lineplot(x=history.epoch, y=history.history['loss'])

# %% [markdown]
# # 7. Perform a prediction/classification

# %%
y_pred = model.predict(X_test)
prediction = pd.DataFrame(y_pred, columns=target.columns)
prediction

# %%
predicted_species = prediction.idxmax(axis="columns")
predicted_species

# %% [markdown]
# # 8. Measuring performance

# %%
from sklearn.metrics import confusion_matrix

true_species = y_test.idxmax(axis="columns")

matrix = confusion_matrix(true_species, predicted_species)
print(matrix)

# %%
# Convert to a pandas dataframe
confusion_df = pd.DataFrame(matrix, index=y_test.columns.values, columns=y_test.columns.values)

# Set the names of the x and y axis, this helps with the readability of the heatmap.
confusion_df.index.name = 'True Label'
confusion_df.columns.name = 'Predicted Label'
confusion_df.head()

# %%
sns.heatmap(confusion_df, annot=True, cmap='Blues')

# %% [markdown]
# # 9. Refine model

# %% [markdown]
# # 10. Share model

# %%
model.save('my_first_model.keras')

# %%
pretrained_model = keras.models.load_model('my_first_model.keras')

# %%
# use the pretrained model here
y_pretrained_pred = pretrained_model.predict(X_test)
pretrained_prediction = pd.DataFrame(y_pretrained_pred, columns=target.columns.values)

# idxmax will select the column for each row with the highest value
pretrained_predicted_species = pretrained_prediction.idxmax(axis="columns")
print(pretrained_predicted_species)

# %%
