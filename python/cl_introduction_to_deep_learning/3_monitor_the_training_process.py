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
# # 1. Formulate / Outline the problem: weather prediction

# %% [markdown]
# # 2. Identify inputs and outputs

# %%
import pandas as pd
data = pd.read_csv('./data/weather_prediction_dataset_light.csv')
data.head()

# %%
data.columns

# %%
data.shape

# %% [markdown]
# # 3. Prepare data

# %%
nr_rows = 365*3 # 3 years
# data
X_data = data.loc[:nr_rows] # Select first 3 years
X_data = X_data.drop(columns=['DATE', 'MONTH']) # Drop date and month column

# labels (sunshine hours the next day)
y_data = data.loc[1:(nr_rows + 1)]["BASEL_sunshine"]

# %% [markdown]
# ## Split data and labels into training/validation/test

# %%
from sklearn.model_selection import train_test_split

X_train, X_holdout, y_train, y_holdout = train_test_split(X_data, y_data, test_size=0.3, random_state=0)

# %%
X_val, X_test, y_val, y_test = train_test_split(X_holdout, y_holdout, test_size=0.5, random_state=0)

# %% [markdown]
# # 4. Choose a pretrained model or start building architecture from scratch

# %%
from tensorflow import keras
keras.utils.set_random_seed(2)

def create_nn(input_shape):
    # Input layer
    inputs = keras.Input(shape=input_shape, name='input')

    # Dense layers
    layers_dense = keras.layers.Dense(100, 'relu')(inputs)
    layers_dense = keras.layers.Dense(50, 'relu')(layers_dense)

    # Output layer
    outputs = keras.layers.Dense(1)(layers_dense)

    return keras.Model(inputs=inputs, outputs=outputs, name="weather_prediction_model")

model = create_nn(input_shape=(X_data.shape[1],))

# %%
model.summary()

# %% [markdown]
# # 5. Choose a loss function and optimizer

# %%
model.compile(loss='mse')

# %%
model.compile(optimizer='adam',
              loss='mse')

# %%
model.compile(optimizer='adam',
              loss='mse',
              metrics=[keras.metrics.RootMeanSquaredError(), keras.metrics.MeanAbsoluteError])


# %%
def compile_model(model):
    model.compile(optimizer='adam',
                  loss='mse',
                  metrics=[keras.metrics.RootMeanSquaredError(), keras.metrics.MeanAbsoluteError, keras.metrics.MeanSquaredError] )
compile_model(model)

# %% [markdown]
# # 6. Train the model

# %%
history = model.fit(X_train, y_train,
                    batch_size=32,
                    epochs=200,
                    verbose=2)

# %%
import seaborn as sns
import matplotlib.pyplot as plt

def plot_history(history, metrics):
    """
    Plot the training history

    Args:
        history (keras History object that is returned by model.fit())
        metrics (str, list): Metric or a list of metrics to plot
    """
    plt.style.use('ggplot')  # optional, that's only to define a visual style
    history_df = pd.DataFrame.from_dict(history.history)
    sns.lineplot(data=history_df[metrics])
    plt.xlabel("epochs")

plot_history(history, 'root_mean_squared_error')

# %%
plot_history(history, 'mean_absolute_error')

# %%
plot_history(history, 'mean_squared_error')

# %% [markdown]
# # 7. Perform a Prediction/Classification

# %%
y_train_predicted = model.predict(X_train)
y_test_predicted = model.predict(X_test)

# %%
print(X_train.shape)
print(X_test.shape)


# %% [markdown]
# # 8. Measure performance

# %%
# We define a function that we will reuse in this lesson
def plot_predictions(y_pred, y_true, title):
    plt.style.use('ggplot')  # optional, that's only to define a visual style
    plt.scatter(y_pred, y_true, s=10, alpha=0.5)
    plt.axline((0,0),slope = 1, color = "black") # plot diagonal reference line
    plt.xlabel("predicted sunshine hours")
    plt.ylabel("true sunshine hours")
    plt.title(title)

plot_predictions(y_train_predicted, y_train, title='Predictions on the training set')

# %%
plot_predictions(y_test_predicted, y_test, title='Predictions on the test set')

# %%
train_metrics = model.evaluate(X_train, y_train, return_dict=True)
test_metrics = model.evaluate(X_test, y_test, return_dict=True)
print('Train RMSE: {:.2f}, Test RMSE: {:.2f}'.format(train_metrics['root_mean_squared_error'], test_metrics['root_mean_squared_error']))

# %% [markdown]
# ## Baseline

# %%
y_baseline_prediction = X_test['BASEL_sunshine']
plot_predictions(y_baseline_prediction, y_test, title='Baseline predictions on the test set')

# %%
import sklearn
print(sklearn.__version__)

# %%
from sklearn.metrics import mean_squared_error
rmse_baseline = mean_squared_error(y_test, y_baseline_prediction, squared = False)
print('Baseline:', rmse_baseline)
print('Neural network: ', test_metrics['root_mean_squared_error'])

# %% [markdown]
# # 9. Refine the model

# %%
model = create_nn(input_shape=(X_data.shape[1],))
compile_model(model)

# %%
history = model.fit(X_train, y_train,
                    batch_size=32,
                    epochs=200,
                    validation_data=(X_val, y_val))

# %%
plot_history(history, ['root_mean_squared_error', 'val_root_mean_squared_error'])


# %% [markdown]
# ## Counterct overfitting

# %%
def create_nn(input_shape, nodes1=100, nodes2=50):
   # Input layer
   inputs = keras.layers.Input(shape=input_shape, name='input')
   # Dense layers
   layers_dense = keras.layers.Dense(nodes1, 'relu')(inputs)
   layers_dense = keras.layers.Dense(nodes2, 'relu')(layers_dense)
   # Output layer
   outputs = keras.layers.Dense(1)(layers_dense)
   return keras.Model(inputs=inputs, outputs=outputs, name="model_small")


# %%
model = create_nn(input_shape=(X_data.shape[1],), nodes1=10, nodes2=5)
model.summary()

# %%
compile_model(model)
history = model.fit(X_train, y_train,
                   batch_size = 32,
                   epochs = 200,
                   validation_data=(X_val, y_val))

# %%
plot_history(history, ['root_mean_squared_error', 'val_root_mean_squared_error'])

# %%
train_metrics = model.evaluate(X_train, y_train, return_dict=True)
test_metrics = model.evaluate(X_test, y_test, return_dict=True)
print('Train RMSE: {:.2f}, Test RMSE: {:.2f}'.format(train_metrics['root_mean_squared_error'], test_metrics['root_mean_squared_error']))

# %% [markdown]
# ## Early stopping

# %%
model = create_nn(input_shape=(X_data.shape[1],))
compile_model(model)

# %%
from tensorflow.keras.callbacks import EarlyStopping



history = model.fit(X_train, y_train,
                    batch_size = 32,
                    epochs = 200,earlystopper = EarlyStopping(
    monitor='val_loss',
    patience=10
    )
                    validation_data=(X_val, y_val),
                    callbacks=[earlystopper])

# %%
plot_history(history, ['root_mean_squared_error', 'val_root_mean_squared_error'])


# %% [markdown]
# ## Batch norm scaling
# ### https://towardsdatascience.com/batch-norm-explained-visually-how-it-works-and-why-neural-networks-need-it-b18919692739/

# %%
def create_nn(input_shape):
    # Input layer
    inputs = keras.layers.Input(shape=input_shape, name='input')

    # Dense layers
    layers_dense = keras.layers.BatchNormalization()(inputs) # This is new!
    layers_dense = keras.layers.Dense(100, 'relu')(layers_dense)
    layers_dense = keras.layers.Dense(50, 'relu')(layers_dense)

    # Output layer
    outputs = keras.layers.Dense(1)(layers_dense)

    # Defining the model and compiling it
    return keras.Model(inputs=inputs, outputs=outputs, name="model_batchnorm")

model = create_nn(input_shape=(X_data.shape[1],))
compile_model(model)
model.summary()

# %%
earlystopper = EarlyStopping(
    monitor='val_loss',
    patience=10
    )
history = model.fit(X_train, y_train,
                    batch_size = 32,
                    epochs = 1000,
                    validation_data=(X_val, y_val),
                    callbacks=[earlystopper],
                   verbose = 0)

# %%
plot_history(history, ['root_mean_squared_error', 'val_root_mean_squared_error'])

# %% [markdown]
# ## Run on test set and compare to naive baseline

# %%
y_test_predicted = model.predict(X_test)
plot_predictions(y_test_predicted, y_test, title='Predictions on the test set')

# %%
train_metrics = model.evaluate(X_train, y_train, return_dict=True)
test_metrics = model.evaluate(X_test, y_test, return_dict=True)
print('Train RMSE: {:.2f}, Test RMSE: {:.2f}'.format(train_metrics['root_mean_squared_error'], test_metrics['root_mean_squared_error']))

# %%
rmse_baseline = mean_squared_error(y_test, y_baseline_prediction, squared = False)
print('Baseline:', rmse_baseline)
print('Neural network: ', test_metrics['root_mean_squared_error'])

# %% [markdown]
# ## Tensorboard

# %%
from tensorflow.keras.callbacks import TensorBoard
import datetime
log_dir = "logs/fit/" + datetime.datetime.now().strftime("%Y%m%d-%H%M%S") # You can adjust this to add a more meaningful model name
tensorboard_callback = TensorBoard(log_dir=log_dir, histogram_freq=1)
history = model.fit(X_train, y_train,
                   batch_size = 32,
                   epochs = 200,
                   validation_data=(X_val, y_val),
                   callbacks=[tensorboard_callback],
                   verbose = 2)

# %%

# %%
