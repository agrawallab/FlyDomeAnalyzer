import pandas as pd
from tkinter import filedialog as fd     

# Load the CSV file into a DataFrame
df = pd.read_csv("Analyzed_scores.csv")

# Read the column headers from the text file into a list
desired_order = pd.read_csv(r"C:\Users\Admin\Documents\MATLAB\FlyDomeAnalyzer\headers_text_file.csv", header=None)[0].tolist()

# Add missing fields with NaN values
for col in desired_order:
    if col not in df.columns:
        df[col] = pd.NA  # Use pd.NA for clarity and consistency with pandas

# Rearrange columns based on desired order
df_reordered = df[desired_order]  # No need for extra logic as all columns are present now

# Save the rearranged DataFrame to a new CSV file
df_reordered.to_csv("Analyzed_Scores.csv", index=False)
