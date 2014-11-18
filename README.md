README
========================================================

This is an tutorial to use **run_analysis.R** correctly.
First of all, it's necessary download Data set in **https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip** and put the downloaded file in your work directory. The second step is extract there, in work directory.

Now **run_analysis.R** it's ready for run.

The code was structured in as following:

* FUNCTIONS SECTION - where declared all of Functions
  * Function to Read txt files
  * Function to Write txt files
  * Function to download zipfile - NOT OK to use
* Setting File and Path Names
* READING Files Section
  * Reading Activities Labels And Features
  * Reading train Data
  * Reading test Data
* TRANSFORM SECTION
* Combining Data sets Subjects and Activities
  * merge to add Activities Labels in table
  * Setting Collumns Names
  * Combining Data sets with Data Measurements and Subjects and Activities
  * Join the Train and Test Data
  * Creating a deliverable dataset

*Now you can press play and await the outcome*

