Pipeline for FlyDome Analysis

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