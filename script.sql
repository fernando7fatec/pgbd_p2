-- CREATE students_performance table
CREATE TABLE students_performance(
    id SERIAL PRIMARY KEY,
    age INT,
    scholarship INT,
    partner INT,
    salary INT,
    mother_edu INT,
    father_edu INT,
    read_freq INT,
    read_freq_sci INT,
    prep_study INT,
    prep_exam INT,
    classroom INT,
    grade INT);

-- Question # 2  --
DROP PROCEDURE IF EXISTS sp_numero_aluno_aprovado;

CREATE OR REPLACE PROCEDURE sp_numero_aluno_aprovado()
LANGUAGE plpgsql
AS $$
DECLARE
	alunos INT;
BEGIN
    SELECT count(id) INTO alunos from students_performance WHERE father_edu = 6 or mother_edu = 6 AND grade >= 3.49;
    RAISE NOTICE 'Os alunos aprovados são os %', alunos;
END;
$$

CALL sp_numero_aluno_aprovado();
