from tkinter import *                     
from tkinter import filedialog as fd     
import os     

def openFile():
    the_file = fd.askdirectory(title = "Select the parent folder from which you want to extract the paths of all the Fixtrax folders")
    return the_file


input_folder = openFile()

output_file_path = str(input_folder) + "/Fixtrax_paths.csv"
with open(output_file_path, "w") as f:

    #Comment one of the following out according to your use case:

    #For 1 Day's experiments
    for subdir in os.listdir(input_folder):
        subdir_path = os.path.join(input_folder, subdir) 
        if os.path.isdir(subdir_path):
            for folder in os.listdir(subdir_path):
                folder_path = os.path.join(subdir_path, folder)
                if os.path.isdir(folder_path):
                    if "Fixtrax" in folder:
                        line = folder_path + ", test, FF0000\n"
                        f.write(line)

    # #For Combined of multiple day's experiments
    # for dir in os.listdir(input_folder):
    #     dir_path = os.path.join(input_folder, dir)
    #     if os.path.isdir(dir_path):
    #         for subdir in os.listdir(dir_path):
    #             subdir_path = os.path.join(dir_path, subdir) 
    #             if os.path.isdir(subdir_path):
    #                 for folder in os.listdir(subdir_path):
    #                     folder_path = os.path.join(subdir_path, folder)
    #                     if os.path.isdir(folder_path):
    #                         if "Fixtrax" in folder:
    #                             line = folder_path + ", test, FF0000\n"
    #                             f.write(line)

print("A text file containing all the paths to the JAABA folders in the given directory has been made")