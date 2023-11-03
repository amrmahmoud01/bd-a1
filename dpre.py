import pandas as pd
from sklearn.preprocessing import StandardScaler, LabelEncoder



df = pd.read_csv("train_titanic.csv")

df.fillna(df.mean(),inplace = True)

df.dropna(subset=['Embarked'], inplace=True)
df["Age"].fillna(df["Age"].mean(),inplace = True)
df["Embarked"].isnull().sum()

df.isnull().sum()

df["Cabin"].mode()

df.drop("Cabin", axis = 1)



##################################################

numerical_columns = ['Age', 'Fare'] 

categorical_column = 'Sex' 

scaler = StandardScaler()
df[numerical_columns] = scaler.fit_transform(df[numerical_columns])

label_encoder = LabelEncoder()
df[categorical_column] = label_encoder.fit_transform(df[categorical_column])

########################################################



df['Age_Bins'] = pd.cut(df['Age'], bins=[0, 18, 40, 60, 100], labels=['Child', 'Young Adult', 'Middle-Aged', 'Senior'])
fare_bins = [0, 10, 50, 100, 600] 
fare_labels = ['Low', 'Moderate', 'High', 'Very High']
df['Fare_Bins'] = pd.cut(df['Fare'], bins=fare_bins, labels=fare_labels)

df.drop("Cabin", axis = 1)
df.drop('Name',axis=1,inplace = True)
from sklearn.decomposition import PCA
data = df._data
pca = PCA(n_components = 2)
reduced = pca.fit_transform(data)

