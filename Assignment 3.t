%***********************************************************************%
%                          PROGRAM HEADER                               %
%***********************************************************************%
%***********************************************************************%
%                                                                       %
% PROGRAMMER'S NAME:    Matthew                                         %
%                                                                       %
% DATE:                 Thursday, October 11, 2018                      %
%                                                                       %
% PROGRAM NAME:         Student Marks and Average                       %
%                                                                       %
% CLASS:                TEJ3M1-01                                       %
%                                                                       %
% ASSIGNMENT:           Assignment #3                                   %
%                                                                       %
% TEACHER:              Mr. Henrich                                     %
%                                                                       %
% DUE DATE:             Thursday, October 11, 2018                      %
%                                                                       %
%***********************************************************************%
%                                                                       %
% WHAT THE PROGRAM DOES                                                 %
%                                                                       %
% This program asks for a student number (up to 50) and then asks for a %
% total number of test then asks for marks for that many tests once done%
% the program will calculate a average for that student and will repeat %
% until 50 students are entered or "9999999" is entered as a student    %
% number as a exit command. The program will display a table with all   %
% the information that was entered.                                     %
%***********************************************************************%
%                                                                       %
% PROCEDURES                                                            %
%                                                                       %
% One procedure is used within this program:                            %
% clearScreen:    This procedure is used to provide the user with a     %
%                 prompt to alert the user that the screen is about to  %
%                 be cleared.                                           %
%***********************************************************************%
%                                                                       %
% ERROR HANDLING                                                        %
%                                                                       %
% This program uses error handling routines, such as strintok, length   %
% and loops to check if the numbers inputed are within the acceptable   %
% range.                                                                %
%***********************************************************************%
%                                                                       %
% PROGRAM LIMITATIONS                                                   %
%                                                                       %
% Needs alot of error checks to not randomly crash.                     %
%***********************************************************************%
%                                                                       %
% EXTENSIONS AND IMPROVEMENTS                                           %
% This program could be improved in a variety of ways:                  %
% 1. Add comments                                                       %
% 2. Optimize Code                                                      %
%***********************************************************************%

%"Enter to continue" Procedure
procedure clearScreen
    put "Press ENTER to continue."
    loop
	exit when hasch
    end loop
    cls
end clearScreen

% Declaring all deez variables
var marks : array 1 .. 50, 1 .. 7 of int
var avg : array 1 .. 50 of real
var student : string
var mark : string
var markamount : string
var sum : int
var total : int
var x : int
var y : int
var yr : int
var z : int
var exitnum : int
total := 0
sum := 0
x := 1
y := 1
yr := 1
z := 0
exitnum := 9999999

%Initializing marks array as -1
for i : 1 .. 50
    for j : 1 .. 7
	marks (i, j) := -1
    end for
end for

%Main loop time - embedded loops for continious loops
loop
    loop
	put "Please enter a 7 digit student number. Type 9999999 to quit."
	get student
	% Exiting loop upon entering the exit number
	if strintok (student) = true and strint (student) = exitnum then
	    exit
	    % Main feature - entering marks.
	elsif strintok (student) = true and length (student) = 7 and strint (student) > 0 then
	    loop
		marks (x, 1) := strint (student)
		put "Please enter test marks for student: ", strint (student)
		put "You cannot enter more than six test marks."
		loop
		    get markamount
		    if strintok (markamount) = false or strintok (markamount) = true and strint (markamount) > 6 or strint (markamount) < 0 or strint (markamount) < 1 then
			put "You must enter a number between 1 to 6."
			exit
		    elsif strint (markamount) <= 6 then
			exit
		    end if
		end loop
		exit when strintok (markamount) and strint (markamount) <= 6 and strint (markamount) > 0
	    end loop
	    % Setting y to 2 to make sure (x, 1) doesn't get overwritten
	    y := 2
	    loop
		loop
		    % y - 1 is put because y alone does not reflect the test number
		    put "Please enter the test ", y - 1, " mark for ", strint (student), " as a number between 0 to 100."
		    get mark
		    if strintok (mark) and strint (mark) <= 100 and strint (mark) > 0 then
			% Entering marks into the array
			marks (x, y) := strint (mark)
			sum := sum + marks (x, y)
			y := y + 1
			exit
			% If statements for invalid marks.
		    elsif strintok (mark) = false then
			put "Your value of ", mark, " was not between 1 and 100."
			y := y
			exit
		    elsif strint (mark) > 100 or strint (mark) < 0 then
			put "Your value of ", mark, " was not between 1 and 100."
			y := y
			exit
		    end if
		end loop
		% Exit commands for when "y" is more than the mark amount.
		exit when y - 1 > strint (markamount)
	    end loop
	    % Setting the average
	    avg (x) := sum / strint (markamount)
	    loop
		% Resetting variables for use later
		sum := 0
		x := x + 1
		y := yr
		total := total + 1
		clearScreen
		exit
	    end loop
	    % Other if statements for entering student number
	elsif strintok (student) = true and strint (student) = exitnum then
	    exit
	elsif strintok (student) = false then
	    put student, " is not a valid number. Try again."
	    student := intstr (0)
	    exit
	elsif strintok (student) = true and length (student) > 7 or length (student) < 7 and length (student) > 0 then
	    put student, " is not valid. The student number must be 7 digits long. Type 0s if necessary."
	    student := intstr (0)
	    exit
	elsif strintok (student) = true and length (student) = 7 and strint (student) < 0 then
	    put student, " isn't a positive integer. Try again."
	    student := intstr (0)
	    exit
	end if
    end loop
    % Exit statement for exiting loop
    if strint (student) = exitnum or total = 50 then
	clearScreen
	exit
    end if
end loop

% Printing student numbers and marks
put "Student Number  Test 1   Test 2   Test 3   Test 4   Test 5   Test 6   Average"
for i : 1 .. total
    x := 0
    loop
	x := x + 1
	y := 1
	loop
	    put "" : 4 ..
	    if y = 8 then
		put "" : 3, avg (x) : 1 : 0, ""
	    elsif marks (x, y) = -1 then
		put "" : 2, "***" ..
	    else
		put marks (x, y) : 5 ..
	    end if
	    y := y + 1
	    exit when y > 8
	end loop
	exit when x = total
    end loop
    exit when x = total
end for
