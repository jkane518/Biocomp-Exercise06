#Exercise 6 shell scrip
#John Kane

#This script will execute three different commands that are described below
#This script works on the file wages.csv that outlines the gender, years of experience,
#years of education, and wage of a set of employees. 
#This script will generate 1 .txt file and 4 lines of stdout.
#THe first 3 lines of stdout relate to part 2 and the last line relates to part 3.

#usage: bash exercise6.sh wages.csv

#1) Using wages.csv, this will creater a file called gender-yearsExperience.txt that
# contains a list of employee genders and unique years of experience.
# This unique list is sorted first by gender and then by years of experience

cat $1 | grep -E "(male|female)" | cut -d , -f 1,2 | sed -E s'/,/ /g' | sort -u -t ' ' -k1,1 -k2,2n>>gender-yearsExperience.txt


#2) this is a set of 3 pipelines that will return a total of 3 values to stdout.
#The first value will be the gender, years of experience, and wage of the employee with the highest wage.
#The second value with be gender yearsexperience, and wage for the lowest earner
# The file value will be the number of women in the top ten earners in this data set.

cat $1 | grep -E "(male|female)" | cut -d , -f 1,2,4 | sed -E s'/,/ /g' | sort -t ' ' -k3n | tail -n 1

cat $1 | grep -E "(male|female)" | cut -d , -f 1,2,4 | sed -E s'/,/ /g' | sort -t ' ' -k3n | head -n 1

cat $1 | grep -E "(male|female)" | cut -d , -f 1,2,4 | sed -E s'/,/ /g' | sort -t ' ' -k3n | tail -n 10 | grep -E "female" | wc -l

#3) This final command is showing the difference in minimum  salary between employees with 16
# years of school vs 12
#the variable "collegedegree" represents the minimum salary of employees with 16 years of school
# "nocollege" represents the minimum salary of employees with 12 years of school.

collegedegree=$ cat $1 | cut -d , -f 3,4 | sed -E 's/,/ /g' | grep -E "16 " | cut -d ' ' -f 2 | sort -n |  head -n 1

nocollege=$ cat $1 | cut -d , -f 3,4 | sed -E 's/,/ /g' | grep -E "12 " | cut -d ' ' -f 2 | sort -n | head -n 1

echo "collegedegree - nocollege" | bc


#I'm not sure why this is not assinging these variables. when I run the bash command
#it gives me the correct values for collegedegree and nocollege
#but it won't assign them to subtract them.
