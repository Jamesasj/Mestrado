select * from mdl_course;
select
	mdl_course_modules.course,
    mdl_course_modules.instance,
    mdl_modules.id,
    mdl_modules.name
from mdl_course_modules
inner join mdl_modules on mdl_course_modules.module = mdl_modules.id
order by 1,2;

select * from  mdl_course_modules;
select * from mdl_assign;
select * from mdl_assign_submission;
select * from mdl_assignsubmission_onlinetext;

select * from mdl_grade_items;
select * from mdl_grade_grades;
select * from mdl_modules;
select * from mdl_grade_categories;

select * from mdl_files;
select * from mdl_context;