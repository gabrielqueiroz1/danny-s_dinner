#%%
import os
import pandas as pd
import sqlalchemy

engine = sqlalchemy.create_engine("sqlite:///dannys_data.db")

files = [i for i in os.listdir("./data") if i.endswith(".csv")]

for file in files:
    df = pd.read_csv(f"./data/{file}", sep=";")
    df.to_sql(file.split(".")[0], engine, if_exists="replace", index=False)
