import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split

# Unpickle data
data = pd.read_pickle('data')

# Separate target and features
target = 'diagnosis'
y = data[target]
X = data.drop(columns=[target])
features_list = ['texture_mean', 'area_worst', 'smoothness_worst', 'concavity_mean']
X = X[features_list]

# Encode the target
y = data[target]
le = LabelEncoder()
y = le.fit_transform(y)
data["result"] = y

# Split the dataset into train and test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=100)

# create df train file
df_train = X_train.copy()
df_train["diagnosis"] = y_train
df_train.to_csv("./df_train_4features.csv")

df_test = X_test.copy()
df_test["diagnosis"] = y_test
df_test.to_csv("./df_test_4features.csv")