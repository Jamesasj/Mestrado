SELECT mdl_course.id AS course,
       mdl_course_modules.id AS instanceid,
       mdl_grade_grades.userid,
       0 AS contextid,
       0 AS itemid,
       '' AS filename,
       mdl_grade_grades.rawgrademin,
       mdl_grade_grades.rawgrademax,
       mdl_grade_grades.id AS id_grade_grades,
       mdl_course_modules.idnumber AS idws,
       IFNULL(
                (SELECT mdl_grade_grades_professor.finalGRADE
                 FROM mdl_grade_grades AS mdl_grade_grades_professor, mdl_user
                 WHERE mdl_grade_grades_professor.ID = mdl_grade_grades.id
                   AND mdl_grade_grades.usermodified = mdl_user.id
                   AND mdl_user.username <> 'soap'),-1) AS notaProfessor,
       mdl_course.shortname AS course_name,
       mdl_assignsubmission_onlinetext.onlinetext AS resposta
FROM mdl_course,-- ok ok
     mdl_assign, -- ok ok
     mdl_assign_submission, -- ok ok
     mdl_assignsubmission_onlinetext, -- ok ok
     mdl_course_modules, -- ok ok
     mdl_grade_items,
     mdl_grade_grades
WHERE mdl_course.id = mdl_assign.course
  AND mdl_assign.id = mdl_assign_submission.assignment
  AND mdl_assign_submission.id = mdl_assignsubmission_onlinetext.submission
  AND mdl_assign.id = mdl_assignsubmission_onlinetext.assignment
  AND mdl_assign.id = mdl_course_modules.instance
  AND mdl_assign.id = mdl_grade_items.iteminstance
  AND mdl_grade_items.id = mdl_grade_grades.itemid
  AND mdl_assign_submission.userid = mdl_grade_grades.userid
  AND mdl_course_modules.course = mdl_assign.course
ORDER BY 1,
         2,
         3