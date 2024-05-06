Installation for FlyDomeAnalyzer

The FlyDomeAnalyzer contains custom code written to analyse the FlyDome or FlyBowl videos from end-end
The code is written to be compatible with the tracking of flytracker(Janelia - Included in this package from the original GitHub repository)
The code also makes use of FixTrax (From Galit’s lab - also provided as part of this folder)

This installation guide provides a step by step installation process explaining the process with a sample data that can be downloaded from “INSERT LINK TO TEST FOLDER AND CLASSIFIERS”

Download and install MATLAB (Developed on 2023a)
Select the following products while installing:
Computer vision toolbox
Image processing toolbox
MATLAB Coder
MATLAB Compiler
Parallel computing toolbox
Statistics and Machine learning toolbox

Download Python 3.10 or above (Was developed on 3.10)

Download the Zip folder for FlyDomeAnalyzer
Extract it to Documents/MATLAB
Open MATLAB add the whole folder along with subfolders to MATLAB

Run the following commands in the terminal
cd FlyDomeAnalyzer (Location of the extracted folder)
pip install matlabengine==9.14.7
pip install ./requirements.txt

Download the Test folder and Classifiers
Contains Videos tracked with Flytracker in the format required for the FlyDomeAnalyzer pipeline to work
Test the installation with these files

Run generate_fixtrax_input.py (preferably using VS Code)
Select the Test folder that was downloaded
This should generate the fixtrax folders successfully in each video folder

Run FixTrax
In MATLAB, run “FixTrackingFiles” to open FixTrax GUI
Select all the FixTrax folders created in the previous step in individual folders in the Test folder (individually and add them and click done)
Finish the FixTrax for all the videos as promoted by the GUI
The fixing will start and might take some time to create all the perframe data for all the videos

Run Fixtrax_folder_path_extractor
This creates a csv file containing the paths of FIxTrax folders that are the input for the next step

Classification with JAABAPlot
In MATLAB, Run “JAABAPlot”
In experiments, click on Batch and select the “Fixtrax_paths.csv” file generated in the previous step within the Test folder
In the classifiers section add the classifiers downloaded from the Classifiers folder (Might take time to add)
Then click on classify. This will take time. 

Installing R and igraph package
Install R (Windows 4.3.2 was used)
Add R to path in system environment variables
In CMD, run the following commands to install the igraph package 
Run commands:
R (Opens the R shell)
install.packages(“igraph”)

Editing paths in different parts of code
In the “network_parameters.m” file in the FlyDomeAnalyzer folder, edit the paths 
rscriptPath - Path to the Rscript file
rCodePath - path to the file network_parameters.R in the FlyDomeAnalyzer

In “domeanalyzer.m” edit path of “rearrange_Analyzed_scores.py” in the pyrunfile command

In the python file “rearrange_Analyzed_scores.py” change the path of the text file input accordingly

Run domeanalyzer 
In MATLAB run the command “domeanalyzer” and select the Test folder as input
This will create the analysed csv (with rearranged data according to the csv file in the FLyDomeAnalyzer folder) files containing details from perframe features and classified scores

Create a csv file containing all the paths of the Analyzed_scores.csv files that need to be compiled one below the other in the first column

Run compileanalysis.py and select the csv file created above
This created a compiled csv file 

Run z-scores.py
The inputs are two compiled csv files of different genotypes/condition that are to be compared. This gives two csv files as output containing the z-scores for each of the genotypes/conditions


Brief Pipeline for FlyDome Analysis after installation

1. Run FlyTracker in MATLAB - Tracking
2. Run generate_fixtrax_input pyton code - Prep for Fixtrax
3. Run Fixtrax in MATLAB - Tracks correction and generate perframe 
4. Run Fixtrax_folder_path_extractor - Extract all the paths of the Fixtrax folders to be classified for JAABAPlot
5. Run JAABAPlot - Classification of behaviors
6. Run Domeanalyzer in MATLAB - Extraction of behaviour data, perframe features and network parameters
7. Run compileanalysis in Python - Compiling data from Domeanalyzer of multiple replicates of the same conditions
8. Run z-scores in Python - Given the compiled data of two conditions calculates the z-scores (relative)
9. Plot the z scores in Prism

Codes within Dome Analyzer​

anglesub_pair_custom: Modified version of the code from JAABA (Kabra et al. 2013) anglesub_pair to predict when the other is in the field of view (hardcoded to pi) of the focal fly ​

anglesub_pair_all: Custom code that calculates these values for all the pairs and stores them in a mat file in the Fixtrax folder ​

dnosetoell_pair_custom: Modified version of the code  from JAABA (Kabra et al. 2013) dnosetoell_pair to calculate the distance between the nose of the focus fly and the closest point on the other fly ​

dnosetoell_pair_all: Calculates these values for all the pairs and stores them in a mat file in the Fixtrax folder ​

angle_distance_combined:  Gives the output of all the frames for all the pairs in 0s and 1s that meet the conditions of dnosetoell is less than 8mm and that the angle subtended is greater than 0. ​

interaction_matrix: Creates two interaction matrices based on the definitions in Galit’s paper ,number of interactions (NOI) and length of interactions (LOI) using the output from the angle_distance_combined code.​

Network_parameters: Uses igraph package in R to extract network parameters like strength, betweenness centrality, density etc. for both LOI and NOI.​

Extract_score_perframe: Extract all the perframe data and behavior data into and Analyzed_scores file along with the network parameters. ​

Rearrange_Anayzed_Scores: Using the order of data as in headers_text_file, it rearranges the data into a specific order for easy grouping during plotting. It takes care of the exclusivity of certain parameters by creating empty columns or removing certain columns. ​
​