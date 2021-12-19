SELECT mdl_course.id AS course,
       mdl_course_modules.id AS instanceid,
       mdl_grade_grades.userid,
       COALESCE(files_user.contextid, 0) AS contextid,
       COALESCE(files_user.itemid, 0) AS itemid,
       COALESCE(files_user.filename, '') AS filename,
       mdl_grade_grades.rawgrademin,
       mdl_grade_grades.rawgrademax,
       mdl_grade_grades.id AS id_grade_grades,
       mdl_course_modules.idnumber AS idnumber,
       COALESCE(
                  (SELECT mdl_grade_grades_professor.finalGRADE
                   FROM mdl_grade_grades AS mdl_grade_grades_professor, mdl_user
                   WHERE mdl_grade_grades_professor.ID = mdl_grade_grades.id
                     AND mdl_grade_grades.usermodified = mdl_user.id
                     AND mdl_user.username <> 'soap'),-1) AS notaProfessor,
       mdl_course.shortname AS course_name,
       mdl_assignsubmission_onlinetext.onlinetext AS resposta,
       mdl_course.shortname AS course_name,
       mdl_assignsubmission_onlinetext.onlinetext AS resposta
FROM mdl_course
INNER JOIN mdl_course_modules ON mdl_course_modules.module = 1
AND mdl_course_modules.course = mdl_course.id
INNER JOIN mdl_assign ON mdl_course.id = mdl_assign.course
AND mdl_course_modules.instance = mdl_assign.id
INNER JOIN mdl_assign_submission ON mdl_assign.id = mdl_assign_submission.assignment
LEFT JOIN mdl_assignsubmission_onlinetext ON mdl_assign_submission.id = mdl_assignsubmission_onlinetext.submission
LEFT JOIN mdl_modules ON mdl_modules.id = mdl_course_modules.module
INNER JOIN mdl_grade_items ON mdl_assign.id = mdl_grade_items.iteminstance
AND mdl_modules.name = mdl_grade_items.itemmodule
INNER JOIN mdl_grade_grades ON mdl_grade_items.id = mdl_grade_grades.itemid
AND mdl_assign_submission.userid = mdl_grade_grades.userid
LEFT JOIN
  (SELECT mdl_files.userid,
          mdl_files.contextid,
          mdl_files.itemid,
          mdl_files.filename,
          mdl_context.instanceid
   FROM mdl_context
   INNER JOIN mdl_files ON mdl_files.contextid = mdl_context.id
   AND mdl_files.component = 'assignsubmission_file'
   AND mdl_files.filesize > 0) AS files_user ON files_user.userid = mdl_grade_grades.userid
AND files_user.instanceid = mdl_course_modules.id
WHERE not(mdl_course_modules.idnumber IS NULL
          OR mdl_course_modules.idnumber = '')
ORDER BY 1,
         2,
         3;

select * from mdl_course_modules;



SELECT * from mdl_grading_instances

select * from mdl_gradingform_rubric_fillings;

SELECT * from mdl_gradingform_guide_criteria;

SELECT * from mdl_gradingform_guide_fillings;

SELECT * from mdl_modules;

select * from mdl_grade_items_history;

select * from mdl_gradingform_rubric_fillings;

SELECT schemaname,relname,n_live_tup 
  FROM pg_stat_user_tables 
  ORDER BY n_live_tup DESC;


select * from mdl_gradingform_rubric_levels;
SELECT * from mdl_workshopform_rubric;
SELECT * from mdl_gradingform_rubric_criteria;
SELECT * from mdl_gradingform_rubric_levels;
select * from mdl_assignsubmission_onlinetext;