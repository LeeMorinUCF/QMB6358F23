#!/bin/bash

################################################################################
#
# QMB 6358: Software Tools for Business Analytics
# Shell Script for Creating Datasets in Assignment 4, Question 1
#
# Name:
# College of Business
# University of Central Florida
#
# Date:
#
################################################################################
#
# This shell script creates a dataset in UNIX, in two ways.
# It the runs two R scripts to test the contents of the datasets
# created in UNIX to compare with the results from R.
#
# Note: The top line tells where your bash program is located
#     and should match the result you get when you
#     type the command "which bash".
#     To run this script you have to navigate to this folder in
#     a terminal window, such as GitBash, and execute
#     ./my_shell_script.sh
#     where the name of the .sh file corresponds to the name of this file.
#
################################################################################

# Bash commands before running R
# e.g. making directory for output, etc.
echo "Running test of Assignment 4, Question 1..."



################################################################################
# Question 1: Assemble used car auction data in UNIX
################################################################################


# Question 1 a) Using a loop
echo "Running commands for Question 1a)..."


# Loop through the files in the dataset.
# If the files were listed by numbers, you might use a loop
# as follows.
NUM_FILES="1 2 3 4 5 6 7"
# Other approach:
# NUM_FILES=$(seq 1 100)
# This needs to be modified for data stored by month.

# Initialize with an empty file.
echo "" > A4Q1a_full.txt
for FILE_NUM in $NUM_FILES
do
    # Append the current dataset to the full dataset.
    echo "Loading file my_folder/QMB6358_car_auction_data/file_name_$FILE_NUM.txt"

    # Insert a cat command here, reading in the numbered dataset
    # and appending it to the full dataset A4Q1a_full.csv:


    # Note: You might have to remove the headers
    # from the names of variables.


done

echo "Completed commands for Question 1a)."





# Question 1 b) Using a one-line command.
echo "Running commands for Question 1b)..."

# Insert a cat command here, reading in all numbered datasets
# and writing to the full dataset A4Q1b_full.csv.
# One-line command goes here:


# Look inside the dataset:
# You might have to remove the headers
# from the names of variables.

echo "Completed command for Question 1b)."




################################################################################
# Testing Assignment 3, Question 1: Assemble the data in R
################################################################################

# Run the R script and save the output
echo "Running R script from Assignment 3, Question 1..."
Rscript ../assignment_03/A3Q1_data.R > A3Q1_results.out
echo "Completed R script for Assignment 3, Question 1."


################################################################################
# Testing Assignment 4, Question 1: After assembling the data in UNIX. Test it in R
################################################################################

# Run the R script and save the output
echo "Running R script for Assignment 4, Question 1..."

# Call your A4Q1_tests.R script here.
echo  "No tests yet."
# Call to Rscript goes here, as above.

echo "Completed R script for Assignment 4, Question 1."



################################################################################

# Other bash commands after output
# e.g. zip file and save copy somewhere else
echo "Completed test of Assignment 4, Question 1."


################################################################################
# end
################################################################################
