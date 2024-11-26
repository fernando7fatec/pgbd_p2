-- CREATE students_performance table --
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

-- Question # 2  
DROP PROCEDURE IF EXISTS sp_numero_aluno_aprovado;

CREATE OR REPLACE PROCEDURE sp_numero_aluno_aprovado()
LANGUAGE plpgsql
AS $$
DECLARE
	alunos INT;
BEGIN
    SELECT count(id) INTO alunos from students_performance WHERE father_edu = 6 or mother_edu = 6 AND grade >= 3.49;
    RAISE NOTICE 'Os alunos aprovados são %', alunos;
END;
$$
CALL sp_numero_aluno_aprovado();

-- Question # 3
CREATE OR REPLACE PROCEDURE alunos_aprovado_estudam_sozinho(OUT p_quantidade INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(id) INTO p_quantidade FROM students_performance WHERE partner = 2 AND grade >= 3.49;
END;
$$;



DO $$
DECLARE
    v_quantidade INT;
BEGIN
    CALL alunos_aprovado_estudam_sozinho(v_quantidade);
    RAISE NOTICE 'A quantidade de alunos aprovados que estudam sozinhos são %', v_quantidade;
END;
$$;


-- Question # 4 
CREATE OR REPLACE FUNCTION fn_alunos_estudiosos()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    resultado INT;
BEGIN
    SELECT COUNT(id)
    INTO resultado
    FROM students_performance
    WHERE salary = 5 AND prep_exam = 2;

    RETURN resultado;
END;
$$;

DO $$
DECLARE
    resultado INT;
BEGIN
    resultado := fn_alunos_estudiosos();
    RAISE NOTICE 'Número de alunos: %', resultado;
END;
$$;
