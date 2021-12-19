-- Consulta quantidade de registros na tabela do postgres
SELECT schemaname,relname,n_live_tup 
  FROM pg_stat_user_tables 
  ORDER BY n_live_tup DESC;

-- Tabelas do moodle que estou analisando
select * from mdl_gradingform_rubric_levels;
SELECT * from mdl_workshopform_rubric;
SELECT * from mdl_gradingform_rubric_criteria;
SELECT * from mdl_gradingform_rubric_levels;
select * from mdl_assignsubmission_onlinetext;
select * from mdl_gradingform_rubric_fillings;
SELECT * from mdl_grading_instances;
select * from mdl_grade_grades_history;
SELECT * from mdl_assign_user_mapping;

select * from mdl_assign where course = 9;
select * from mdl_assign_grades;
select * from mdl_assign_submission;
select * from mdl_assignsubmission_onlinetext WHERE id = 12;

-- obter o texto avaliado
select 
mdl_assign.id,
mdl_assign.name,
mdl_assign_submission.status,
mdl_assignsubmission_onlinetext.onlinetext
from 
    mdl_assign 
    INNER JOIN mdl_assign_submission ON mdl_assign_submission.assignment = mdl_assign.id
    INNER JOIN mdl_assignsubmission_onlinetext on mdl_assignsubmission_onlinetext.submission = mdl_assign_submission.id
where 
mdl_assign.course = 9
and mdl_assign_submission.status ='submitted';


-- relação de rubrics com avaliação
select * from mdl_gradingform_rubric_fillings x
inner join mdl_gradingform_rubric_levels y on x.criterionid = y.id;

-- consulta das avaliações
SELECT
    mdl_assign_grades.assignment as id_atividade,
    mdl_assign_grades.userid as id_aluno,
    mdl_assign_grades.grade as nota_final,
    mdl_grading_instances.status as status_rubric,
    mdl_gradingform_rubric_criteria.description as desc_criterio,
    mdl_gradingform_rubric_levels.score as nota_criterio,
    mdl_gradingform_rubric_levels.definition as decricao_select
FROM
    mdl_assign_grades
    INNER JOIN mdl_grading_instances on mdl_assign_grades.id = mdl_grading_instances.itemid
    INNER JOIN mdl_gradingform_rubric_fillings  on mdl_grading_instances.id = mdl_gradingform_rubric_fillings.instanceid
    INNER JOIN mdl_gradingform_rubric_levels  on mdl_gradingform_rubric_levels.id = mdl_gradingform_rubric_fillings.levelid
    INNER JOIN mdl_gradingform_rubric_criteria  on mdl_gradingform_rubric_fillings.criterionid = mdl_gradingform_rubric_criteria.id 
WHERE mdl_grading_instances.status = 0


-- consultas mescladas

select 
    mdl_assign.id,
    mdl_assign.name,
    mdl_assign_submission.status,
    mdl_assignsubmission_onlinetext.onlinetext,
    mdl_assign_grades.assignment as id_atividade,
    mdl_assign_grades.userid as id_aluno,
    mdl_assign_grades.grade as nota_final,
    mdl_grading_instances.status as status_rubric,
    mdl_gradingform_rubric_criteria.description as desc_criterio,
    mdl_gradingform_rubric_levels.score as nota_criterio,
    mdl_gradingform_rubric_levels.definition as decricao_select
from 
    mdl_assign 
    INNER JOIN mdl_assign_submission ON mdl_assign_submission.assignment = mdl_assign.id
    INNER JOIN mdl_assignsubmission_onlinetext on mdl_assignsubmission_onlinetext.submission = mdl_assign_submission.id

    INNER JOIN  mdl_assign_grades on mdl_assign_grades.assignment = mdl_assign_submission.assignment
    INNER JOIN mdl_grading_instances on mdl_assign_grades.id = mdl_grading_instances.itemid
    INNER JOIN mdl_gradingform_rubric_fillings  on mdl_grading_instances.id = mdl_gradingform_rubric_fillings.instanceid
    INNER JOIN mdl_gradingform_rubric_levels  on mdl_gradingform_rubric_levels.id = mdl_gradingform_rubric_fillings.levelid
    INNER JOIN mdl_gradingform_rubric_criteria  on mdl_gradingform_rubric_fillings.criterionid = mdl_gradingform_rubric_criteria.id 

where 
mdl_assign.course = 9
and mdl_assign_submission.status ='submitted'
and mdl_grading_instances.status = 0;