# Check-Your-Codeforces
A powershell script to automate testing of C or C++ code for Codeforces competitions.
(Functionality for other languages could be added easily.)


This is what the basic file structure of your project should look like:

- {base contest folder}
  - A (or whatever the name of Task 1 is)
    - A.c OR A.cpp
    - cyc.PS1 (The powershill script included on this GitHub page)
    - tests
      - 1_in.txt
      - 1_out.txt
      - 1_sln.txt
  - B (Task 2)
  - {etc.}
  
  
  Then, once you have finished programming your solution, create as many test files as you see fit. 
  - {test #}\_in.txt is the input for your program.
  - {test #}\_out.txt is the file your code will write to.
  - {test #}\_sln.txt is the expected results that are compared to your output file.
  
  This is all done automatically.
