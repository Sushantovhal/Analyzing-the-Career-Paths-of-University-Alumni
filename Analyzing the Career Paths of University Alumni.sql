USE alumni;

-- Question 3
DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj;

-- QUestion 4 (in python file)

SELECT * FROM college_a_hs LIMIT 1000;
SELECT * FROM college_a_se LIMIT 1000;
SELECT * FROM college_a_sj LIMIT 1000;
SELECT * FROM college_a_hs LIMIT 1000;
SELECT * FROM college_a_se LIMIT 1000;
SELECT * FROM college_a_sj LIMIT 1000;

-- Question 5
-- IN MYSQL FILE Project 2

-- Question 6

CREATE VIEW College_A_HS_V AS (SELECT * FROM college_a_hs WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND HSDegree IS NOT NULL AND 
EntranceExam IS NOT NULL AND Institute IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_A_HS_V;

-- Question 7

CREATE VIEW College_A_SE_V AS (SELECT * FROM college_a_se WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization 
IS NOT NULL AND Location IS NOT NULL); 

SELECT * FROM College_A_SE_V;

-- Question 8
CREATE VIEW College_A_SJ_V AS (SELECT * FROM college_a_sj WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization 
IS NOT NULL AND Designation IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_A_SJ_V;

-- Question 9
CREATE VIEW College_B_HS_V AS (SELECT * FROM college_b_hs WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Branch IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND HSDegree IS NOT NULL AND 
EntranceExam IS NOT NULL AND Institute IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_B_HS_V;

-- Question 10
CREATE VIEW college_b_se_v AS (SELECT * FROM college_b_se WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Branch IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization 
IS NOT NULL AND Location IS NOT NULL); 

SELECT * FROM College_b_se_v;

-- Question 11
CREATE VIEW college_b_sj_v AS (SELECT * FROM college_b_sj WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND
FatherName IS NOT NULL AND MotherName IS NOT NULL AND  Branch IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization 
IS NOT NULL AND Designation IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM college_b_sj_v;

-- Question 12
CALL lowercollege_a_hs;
CALL Lowercollege_a_se;
CALL lowercollege_a_sj;
CALL lowercollege_b_hs;
CALL lowercollege_b_se;
CALL lowercollege_b_sj;

-- QUestion 13

-- Question 14
DELIMITER $$
CREATE PROCEDURE get_name_collegeA
(
	INOUT  Lname TEXT(40000)
)
BEGIN
	DECLARE finished INT DEFAULT 0;
    DECLARE Lnamelist VARCHAR (16000) DEFAULT "";
    
    DECLARE Lnamedetails
		CURSOR FOR
			SELECT name FROM college_a_hs
			UNION 
            SELECT name FROM college_a_se
            UNION 
            SELECT name FROM college_a_sj;
            
		DECLARE CONTINUE HANDLER
			FOR NOT FOUND SET finished=1;
            
            OPEN Lnamedetails;
            getname1:
            LOOP
				FETCH Lnamedetails INTO Lnamelist;
                IF finished =1 THEN 
					LEAVE getname1;
				END IF;
                
                SET Lname = CONCAT
                (Lnamelist,";",Lname);
                
                END LOOP getname1;
                
                CLOSE Lnamedetails;
                
END $$
DELIMITER ;

SET @name1="";
CALL get_name_collegeA(@name1);
SELECT @name1 Name;            
            
		
        
-- Question 15

DELIMITER $$
CREATE PROCEDURE get_name_collegeB
(
	INOUT  Fname TEXT(40000)
)
BEGIN
	DECLARE finished INT DEFAULT 0;
    DECLARE Fnamelist VARCHAR (16000) DEFAULT "";
    
    DECLARE Fnamedetails
		CURSOR FOR
			SELECT name FROM college_b_hs
			UNION ALL
            SELECT name FROM college_b_se
            UNION ALL
            SELECT name FROM college_b_sj;
            
		DECLARE CONTINUE HANDLER
			FOR NOT FOUND SET finished=1;
            
            OPEN Fnamedetails;
            getname2:
            LOOP
				FETCH Fnamedetails INTO Fnamelist;
                IF finished =1 THEN 
					LEAVE getname2;
				END IF;
                
                SET Fname = CONCAT
                (Fnamelist,";",Fname);
                
                END LOOP getname2;
                
                CLOSE Fnamedetails;
                
END $$
DELIMITER ;

SET @name2="";
CALL get_name_collegeB(@name2);
SELECT @name2 Name;    



-- Question 16

SELECT "HigherStudies" PresentStatus,(SELECT COUNT(*) FROM college_a_hs)/ 
((SELECT COUNT(*) FROM college_a_hs) + (SELECT COUNT(*) FROM college_a_se) + (SELECT COUNT(*) FROM college_a_sj))*100 
College_A_Percentage,
(SELECT COUNT(*) FROM college_b_hs)/ 
((SELECT COUNT(*) FROM college_b_hs) + (SELECT COUNT(*) FROM college_b_se) + (SELECT COUNT(*) FROM college_b_sj))*100 
College_B_Percentage
UNION 
SELECT "Self Employed" PresentStatus,(SELECT COUNT(*) FROM college_a_se)/ 
((SELECT COUNT(*) FROM college_a_hs) + (SELECT COUNT(*) FROM college_a_se) + (SELECT COUNT(*) FROM college_a_sj))*100 
College_A_Percentage,
(SELECT COUNT(*) FROM college_b_se)/ 
((SELECT COUNT(*) FROM college_b_hs) + (SELECT COUNT(*) FROM college_b_se) + (SELECT COUNT(*) FROM college_b_sj))*100 
College_B_Percentage
UNION
SELECT "Service Job" PresentStatus,(SELECT COUNT(*) FROM college_a_sj)/ 
((SELECT COUNT(*) FROM college_a_hs) + (SELECT COUNT(*) FROM college_a_se) + (SELECT COUNT(*) FROM college_a_sj))*100 
College_A_Percentage,
(SELECT COUNT(*) FROM college_b_sj)/ 
((SELECT COUNT(*) FROM college_b_hs) + (SELECT COUNT(*) FROM college_b_se) + (SELECT COUNT(*) FROM college_b_sj))*100 
College_B_Percentage;



-- BY USING VIEW CALCULATE THE PERCENTAGE 

SELECT "HigherStudies" PresentStatus,(SELECT COUNT(*) FROM college_a_hs_V)/ 
((SELECT COUNT(*) FROM college_a_hs_v) + (SELECT COUNT(*) FROM college_a_se_v) + (SELECT COUNT(*) FROM college_a_sj_v))*100 
College_A_Percentage,
(SELECT COUNT(*) FROM college_b_hs_V)/ 
((SELECT COUNT(*) FROM college_b_hs_v) + (SELECT COUNT(*) FROM college_b_se_v) + (SELECT COUNT(*) FROM college_b_sj_v))*100 
College_B_Percentage
UNION 
SELECT "Self Employed" PresentStatus,(SELECT COUNT(*) FROM college_a_se_V)/ 
((SELECT COUNT(*) FROM college_a_hs_v) + (SELECT COUNT(*) FROM college_a_se_v) + (SELECT COUNT(*) FROM college_a_sj_v))*100 
College_A_Percentage,
(SELECT COUNT(*) FROM college_b_se_V)/ 
((SELECT COUNT(*) FROM college_b_hs_v) + (SELECT COUNT(*) FROM college_b_se_v) + (SELECT COUNT(*) FROM college_b_sj_v))*100 
College_B_Percentage
UNION
SELECT "Service Job" PresentStatus,(SELECT COUNT(*) FROM college_a_sj_V)/ 
((SELECT COUNT(*) FROM college_a_hs_v) + (SELECT COUNT(*) FROM college_a_se_v) + (SELECT COUNT(*) FROM college_a_sj_v))*100 
College_A_Percentage,
(SELECT COUNT(*) FROM college_b_sj_V)/ 
((SELECT COUNT(*) FROM college_b_hs_v) + (SELECT COUNT(*) FROM college_b_se_v) + (SELECT COUNT(*) FROM college_b_sj_v))*100 
College_B_Percentage;
