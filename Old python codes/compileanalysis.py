import pandas as pd
from tkinter import *                     
from tkinter import filedialog as fd     
import os    

def openFile():
    the_file = fd.askopenfilenames(title = "Select compiled Fixtrax paths file for multiple replicates (Multiple can be selected)")
    return the_file


input_files= openFile()

for input_file in input_files:

    print(input_file)

    # Read the list of CSV file paths from the text file into a Python list.
    with open(input_file, "r") as f:
        csv_file_paths = f.readlines()

    # Create an empty list to store the DataFrames.
    dataframes = []

    # Iterate over the list of CSV file paths and read each CSV file into a DataFrame.
    for csv_file_path in csv_file_paths:
        dataframe = pd.read_csv(csv_file_path.rstrip('\n')+'\Analyzed_scores.csv')
        dataframes.append(dataframe)

    # Concatenate the DataFrames using the Pandas `concat()` function.
    combined_dataframe = pd.concat(dataframes)

    output_file = input_file.removesuffix(".csv") + "_Compiled.csv"

    # Save the combined DataFrame to a new CSV file.
    combined_dataframe.to_csv(output_file, index=False)
