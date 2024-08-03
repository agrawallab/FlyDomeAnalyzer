import pandas as pd
import pandas as pd
from tkinter import *                     
from tkinter import filedialog as fd     
import os    

def g(df1, df2):
    """Calculates the z scores for two dataframes and returns two new dataframes with the z scores.

    Args:
        df1: The first dataframe.
        df2: The second dataframe.

    Returns:
        A tuple of two dataframes, where the first dataframe contains the z scores for the first dataframe and the second dataframe contains the z scores for the second dataframe.
    """

    df = pd.concat([df1, df2], ignore_index=True)
    df_zscore = df.apply(lambda x: (x - x.mean()) / x.std(), axis=0)
    df_zscore1 = df_zscore.iloc[:len(df1), :]
    df_zscore2 = df_zscore.iloc[len(df1):, :]
    return df_zscore1, df_zscore2

def openFile():
    the_file = fd.askopenfilenames(title = "Select compiled score files of Test and Control")
    return the_file


input_files = openFile()
print(input_files)
# Sample dataset
df1 = pd.read_csv(input_files[0], header = 0).iloc[:, 1:]
df2 = pd.read_csv(input_files[1], header = 0).iloc[:, 1:]

# Calculate the z scores
df_zscore1, df_zscore2 = g(df1, df2)

# Print the z scores
df_zscore1.to_csv(input_files[0].replace(".csv", "") + "_zscores.csv", index=False, header=df1.columns)
df_zscore2.to_csv(input_files[1].replace(".csv", "") + "_zscore.csv", index=False, header=df2.columns)