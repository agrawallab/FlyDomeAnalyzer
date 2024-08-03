
from tkinter import *                     
from tkinter import filedialog as fd     
import os     
import shutil
import matlab.engine

#Selecting the folder
def openFile():
    the_file = fd.askdirectory(title = "Select the folder containing all the recordings tracked with FlyTracker to create input folders for Fixtrax")
    return the_file


print("Starting MATLAB")
try:
    eng = matlab.engine.start_matlab()
    print("MATLAB Started") 
except:
    print("Please install MATLAB engine for python")


input_folder = openFile()

for dir in os.listdir(input_folder): 
    dir_path = os.path.join(input_folder, dir)
    if os.path.isdir(dir_path):
        for subdir in os.listdir(dir_path):
            if ".mp4" in subdir:
                moviefilename, moviefileextension = os.path.splitext(subdir)
                moviepath = os.path.join(dir_path, subdir)
        for subdir in os.listdir(dir_path):
            subdir_path = os.path.join(dir_path, subdir)
            if os.path.isdir(subdir_path):
                for folder in os.listdir(subdir_path):
                    folder_path = os.path.join(subdir_path, folder)
                    if os.path.isdir(folder_path):
                        os.chdir(folder_path)
                        print("Working on " + folder_path)
                        eng.cd(folder_path)
                        try:
                            eng.flytrackertoctrax(nargout=0)
                        except:
                            ("Please add flytrakertoctrax MATLAB script to the path in MATLAB")
                        for file in os.listdir(folder_path):
                            file_path = os.path.join(folder_path, file)
                            name, extension = os.path.splitext(file)
                            if "movie" in name:
                                new_path = os.path.join(dir_path, "Fixtrax")
                                try:
                                    os.mkdir(new_path)
                                    print("Fixtrax directory created")
                                except:
                                    print("Fixtrax directory already exists")
                                
                                try:
                                    output_file_path = str(new_path) + "/movie.mp4.ann"
                                    with open(output_file_path, "w") as f:
                                        line = "Ctrax header\nversion:0.5.18\n\nend header"
                                        f.write(line)
                                    print("Empty annotation file created")
                                except:
                                    print("Annotation file already exists")
                                    
                                new_name = os.path.join(dir_path + str("/") + "Fixtrax/" + name + extension)
                                try:
                                    shutil.move(file_path, new_name)
                                    print("movie.mat moved to Fixtrax folder")
                                except:
                                    print("movie.mat already created")
                                
                                #Renaming the video file to movie.mp4
                                try:
                                    new_movie_name = os.path.join(dir_path + str("/") + "Fixtrax/movie" + moviefileextension)
                                    shutil.move(moviepath, new_movie_name)
                                    print("movie file renamed and moved to Fixtrax folder")
                                except:
                                    print("movie not found or already moved")


eng.quit()