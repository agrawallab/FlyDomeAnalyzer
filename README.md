# FlyDomeAnalyzer

We created a MATLAB app with GUI that consists of a series of buttons that can be executed one after the other without much effort. The steps of the GUI have been explained below:

![FlyDomeAnalyzer MATLAB App_ Updated](https://github.com/user-attachments/assets/07ae57f3-139f-4178-8bc3-044308cd0963)

To use this download the repo as a zip file and extract it in a location of your choice.
To open the GUI, open MATLAB and type FlyDomeAnalyzer
Next, in the GUI click on Set Path of FlyDomeAnalyzer and choose the FlyDomeAnalyzer folder which you extracted.
The following steps are explained below:

1. Generate inputs for Fixtrax:  
To run Fixtrax (the tracking correction program from Galit’s lab) you require the movie file, the tracked .mat file in Ctrax format and an annotation file. Clicking this button asks you to select the folder containing the tracked videos and it automatically creates a “Fixtrax” folder for all the tracked video folders. It runs flytrackertoctrax to create the movie.mat file, moves and renames the video file to movie.mp4 and creates an empty  movie.ann file since the data of this file is not used by the Fixtrax software but is essential for it to run.
 
flytrackertoctrax: Fixtrax supports only the file format of ctrax output. Hence flytrackertoctrax is a matlab script to convert Flytracker output compatible with FixTrax. 


2. Run FixTrax:  
Fixtrax is the MATLAB code used to correct tracking errors using prediction algorithms (Insert Ref). The FixTrax folders generated in the previous step are the inputs. This generates a corrected registered_trx.mat and the perframe directory along with some other files within the FixTrax folder for each of the videos 
 
3. Create JAABAPlot input:
Clicking this asks you to select the folder containing all the folders of the videos that have been tracked and corrected by Fixtrax. It extracts all the paths of the “Fixtrax '' folders within the folder for all the movies into a csv file name “Fixtrax_paths.csv “. Once the csv file is made, the genotypes/conditions can be renamed along with different color codes for each in case any plotting needs to be done in JAABA – the next step.
  
4. Run JAABAPlot:  
Click on JAABAPlot. This opens the JAABA Plot GUI (Insert Ref). Use the csv file generated in the previous step as the batch input for the videos to be classified. Add the classifiers of the behaviors that are to be quantified. 
  
5. Run ‘Dome Analyzer’:
Select the folder for containing the folders of videos that have been tracked with Flytracker, corrected with Fixtrax and classified with JAABAPlot. This creates an Analyzed_scores.csv file containing the data extracted for each video into the Fixtrax folder. Essentially the Dome Analyzer does the following: Creation of interaction matrices, extraction of network parameters and analyzed scores from classified behaviors and perframe features.
It uses the following custom MATLAB codes in the background. They have been explained below:

anglesub_pair_custom: A modified version of the code from JAABA (Kabra et al. 2013) anglesub_pair to predict when the other is in the field of view (hardcoded to pi) of the focal fly (The values are in 0s and 1s)

anglesub_pair_all: Custom code that calculates these values for all the pairs and stores them in a mat file in the Fixtrax folder

dnosetoell_pair_custom: A modified version of the code  from JAABA (Kabra et al. 2013) dnosetoell_pair to calculate the distance between the nose of the focus fly and the closest point on the other fly 

dnosetoell_pair_all: Calculates these values for all the pairs and stores them in a mat file in the Fixtrax folder 

angle_distance_combined:  Gives the output of all the frames for all the pairs in 0s and 1s that meet the conditions of dnosetoell is less than 8mm and that the angle subtended is greater than 0. 

interaction_matrix: Creates two interaction matrices based on the definitions in Galit’s paper, number of interactions (NOI) and length of interactions(LOI) using the output from the angle_distance_combined code.

Network_parameters: Uses the igraph package in R to extract network parameters like strength, betweenness centrality, density etc. for both LOI and NOI.

Extract_score_perframe: Extract all the perframe data and behavior data into an Analyzed_scores file along with the network parameters. 

Rearrange_Anayzed_Scores: Using the order of data as in headers_text_file, it rearranges the data into a specific order for easy grouping during plotting. It takes care of the exclusivity of certain parameters by creating empty columns or removing certain columns. 

6. Run Compile Scores:
To collate the analyzed scores of a single genotype, add all the locations of the Fixtrax folders of a single genotype into a csv file. Click the Compile Scores button to compile all the analyzed scores of a single genotype as per the paths of Fixtrax folders provided. 
  
7. Run Z-score calculator 
Calculate z-scores of two compiled conditions or genotypes
Input: 2 compiled analyzed scores csv files (example – GH_compiled.csv, SH_compiled.csv) 
Output: 2 csv files (example – GH_compiled_zscores.csv, SH_compiled_zscores.csv) 
NOTE: The z scores depend on the combination of the 2 csv files given because they are calculated based on the combined means of the different features/scores in the two csv files.  


8. Plot lollipops: 
Select the 2 csv files containing the z scores to plot the lollipop graphs.The stats are also done for you here.  Alternatively, you can copy the z scores to any other platforms like Prism and plot them in the way you like.
