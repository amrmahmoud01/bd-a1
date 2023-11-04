FROM ubuntu

RUN apt-get update && apt-get install -y python3.6 python3-distutils python3-pip python3-apt

RUN pip3 install pandas && pip3 install numpy && pip3 install seaborn && pip3 install matplotlib && pip3 install scikit-learn && pip3 install scipy

RUN mkdir -p /home/doc-bd-a1/

RUN mkdir /app

RUN echo 'import pandas as pd' \
    'def p():' \
    '    path = input("Please Enter the Path of the dataset: ")' \
    '    data = pd.read_csv(path)' \
    '    return data' > /app/load.py

RUN echo 'import pandas as pd' \
         'import load' \
         'df = load.p()' \
         'from sklearn.preprocessing import StandardScaler, LabelEncoder' \
         '' \
         '### Cleaning' \
         '' \
         'df['Age'].fillna(df['Age'].mean(), inplace=True)' \
         '' \
         'df.dropna(subset=['Embarked'], inplace=True)' \
         '' \
         'df.drop('Cabin', axis=1, inplace=True)' \
         '' \
         '### Discretization' \
         '' \
         'age_bins = [0, 15, 30, 50, 80]' \
         'age_labels = ['Child', 'Young Adult', 'Middle-Aged', 'Senior']' \
         'fare_bins = [-0.001, 10, 50, 100, 600]' \
         'fare_labels = ['Low', 'Moderate', 'High', 'Very High']' \
         'df['Age_Bins'] = pd.cut(df['Age'], bins=age_bins, labels=age_labels)' \
         'df['Fare_Bins'] = pd.cut(df['Fare'], bins=fare_bins, labels=fare_labels)' \
         '' \
         'numerical_columns = ['Age', 'Fare']' \
         'scaler = StandardScaler()' \
         'df[numerical_columns] = scaler.fit_transform(df[numerical_columns])' \
         '' \
         'label_encoder = LabelEncoder()' \
         'df['Sex'] = label_encoder.fit_transform(df['Sex'])' \
         '' \
         '### Reduction' \
         '' \
         'df.drop('Name', axis=1, inplace=True)' \
         'df.drop('Fare', axis=1, inplace=True)' \
         '' \
         'df.to_csv('res_dpre.csv')' > /app/DPRE.py

COPY train_titanic.csv /home/doc-bd-a1/

COPY load.py /home/doc-bd-a1/

COPY dpre.py /home/doc-bd-a1/




CMD "/bin/bash"
