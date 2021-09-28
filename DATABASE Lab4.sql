--1)
SELECT * from course
WHERE credits>3;

SELECT * from classroom
WHERE building='Watson' or building='Packard';

SELECT * from course
WHERE dept_name='Comp. Sci.';

SELECT title from course,section
WHERE course.course_id=section.course_id and section.semester='Fall';

SELECT * from student
WHERE tot_cred>45 and tot_cred<90;

SELECT * from student
WHERE name like '%a'
or name like '%e'
or name like '%u'
or name like '%i'
or name like '%o';

SELECT title from course,prereq
WHERE course.course_id=prereq.course_id and prereq.prereq_id='CS-101';

--2)
SELECT avg(salary) from instructor
group by dept_name
order by avg(salary) asc;

SELECT building, count(course_id) as number from department,course
WHERE department.dept_name=course.dept_name
group by department.building
having count(course_id)>=all(SELECT count(course_id) as number from department,course
WHERE department.dept_name=course.dept_name
group by department.building);


SELECT course.dept_name,count(course_id) as number from department,course
WHERE department.dept_name=course.dept_name
group by course.dept_name
having count(course_id)<=all(SELECT count(course_id) as number from department,course
WHERE department.dept_name=course.dept_name
group by course.dept_name);

SELECT student.id,name, count(course_id) from student,takes
WHERE student.id=takes.id and student.dept_name='Comp. Sci.'
group by student.id, name
having count(course_id)>3;

SELECT * from instructor
WHERE dept_name in ('Biology','Philosophy','Music');

SELECT name from instructor
WHERE name not in (Select name from instructor,teaches
WHERE instructor.id=teaches.id and teaches.year=2017);

--3)
SELECT student.id,name,course.title from student,takes,course
WHERE student.id=takes.id and takes.course_id=course.course_id and course.dept_name='Comp. Sci.' and takes.grade in ('A','-A')
order by name asc;

SELECT distinct name,s_id,i_id from advisor,takes,student
WHERE takes.id=advisor.s_id and student.id=takes.id and takes.grade not in ('A','A-','B+','B');

SELECT distinct dept_name from course
WHERE dept_name not in (SELECT dept_name from course,takes
WHERE course.course_id=takes.course_id and takes.grade in ('F','C'));

SELECT distinct name from instructor
WHERE name not in (select name from takes,teaches,instructor
WHERE instructor.id=teaches.id and teaches.course_id=takes.course_id and takes.grade='A');

SELECT distinct title,start_hr,start_min,end_hr,end_min from time_slot,section,course
WHERE course.course_id=section.course_id and section.time_slot_id=time_slot.time_slot_id and section.time_slot_id in ('A','B','C');











