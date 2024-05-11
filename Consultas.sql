
-- consultas

--Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.

select pr.nombre as Profesor , pr.apellido1 as "Apellido 1",pr.apellido2 as "Apellido 2", dp.nombre as Departamento 
from profesor as pr
left join departamento as dp on dp.idDepartamento=pr.idDepartamento;
-- 2

-- 2. Devuelve un listado con los profesores que no están asociados a un departamento.

select pr.nombre as Profesor , pr.apellido1 as "Apellido 1",pr.apellido2 as "Apellido 2"
from profesor as pr
left join departamento as dp on dp.idDepartamento=pr.idDepartamento
where dp.nombre is null ;

-- 3.Devuelve un listado con los departamentos que no tienen profesores asociados.

select dp.nombre as Departamento 
from profesor as pr
right join departamento as dp on dp.idDepartamento=pr.idDepartamento
where pr.nombre is null;

-- Devuelve un listado con los profesores que no imparten ninguna asignatura.

select pr.nombre as Profesor , pr.apellido1 as "Apellido 1",pr.apellido2 as "Apellido 2"
from profesor as pr 
left join asignatura as asig on asig.idProfesor=pr.idProfesor
where asig.nombre is null;

-- Devuelve un listado con las asignaturas que no tienen un profesor asignado.

select asig.nombre as Asignatura 
from profesor as pr 
right join asignatura as asig on asig.idProfesor=pr.idProfesor
where pr.nombre is null;

-- 6. Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.

-- es vacio por que los datos de las asignaturas deben ser inpartidas en algun curso
select dp.nombre as Departamento, asig.nombre as Asignatura,  ce.idCurso 
from departamento as dp
inner join profesor as pr on dp.idDepartamento=pr.idDepartamento
left join asignatura as asig on asig.idProfesor=pr.idProfesor
inner join alumno_se_matricula_asignatura as ama on ama.id_asignatura = asig.idAsignatura
inner join curso_escolar as ce on ce.idCurso=ama.id_curso_escolar; 

-- 7. Devuelve el número total de **alumnas** que hay.

select COUNT(al.idAlumno)
from alumno as al
where sexo = "M";


-- Calcula cuántos alumnos nacieron en 1999.


select count(idAlumno) as "Alumnos 1999"
from alumno as al
WHERE year(al.fecha_nacimiento)= "1999";


-- Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.

select dp.nombre as "Departamento", count(pr.idProfesor) as "Cantidad Profesores"
from profesor as pr
inner join departamento as dp on dp.idDepartamento = pr.idDepartamento
group by dp.nombre
order by count(pr.idProfesor) desc;

-- Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también tienen que aparecer en el listado.

select dp.nombre as "Departamento", count(pr.idProfesor) as "Cantidad Profesores"
from profesor as pr
right join departamento as dp on dp.idDepartamento = pr.idDepartamento
group by dp.nombre
order by count(pr.idProfesor) desc;



-- Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.


select gr.nombre as "Grado", COUNT(asig.idAsignatura) as Asignatura
from grado as gr
left join asignatura as asig on asig.idGrado= gr.idGrado
GROUP BY gr.nombre
order by COUNT(asig.idAsignatura) desc;


-- Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas. 


select gr.nombre as "Grado", COUNT(asig.idAsignatura) as Asignatura
from grado as gr
left join asignatura as asig on asig.idGrado= gr.idGrado
GROUP BY gr.nombre
having COUNT(asig.idAsignatura) > 40
order by COUNT(asig.idAsignatura) desc;

-- Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo. Ordene el resultado de mayor a menor por el número total de crédidos.

select gr.nombre, asig.tipo, sum(asig.creditos) 
from grado as gr
inner join asignatura as asig on asig.idGrado= gr.idGrado
group by gr.nombre, asig.tipo
order by sum(asig.creditos) desc;


-- Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.

select ce.anyo_inicio, count(al.nombre) as "Estudiantes Matriculados"
from alumno as al
inner join alumno_se_matricula_asignatura as ama on ama.id_alumno = al.idAlumno 
inner join asignatura as asig on asig.idAsignatura = ama.id_asignatura
inner join curso_escolar as ce on ce.idCurso= ama.id_curso_escolar
group by ce.anyo_inicio;


--Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.

select pr.idProfesor, pr.nombre, pr.apellido1, pr.apellido2, count(asig.idAsignatura) as "Numero Asignaturas"
from asignatura as asig
right join profesor as pr on asig.idProfesor = pr.idProfesor
group by pr.idProfesor, pr.nombre, pr.apellido1, pr.apellido2
order by count(asig.idAsignatura) desc;



-- 16. Devuelve todos los datos del alumno más joven.

select *
from alumno
order by fecha_nacimiento DESC
limit 1;



-- 17. Devuelve un listado con los profesores que no están asociados a un departamento.

select pr.nombre as Profesor , pr.apellido1 as "Apellido 1",pr.apellido2 as "Apellido 2"
from profesor as pr
left join departamento as dp on dp.idDepartamento=pr.idDepartamento
where dp.nombre is null ;


-- 18. Devuelve un listado con los departamentos que no tienen profesores asociados.

select dp.nombre as Departamento 
from profesor as pr
right join departamento as dp on dp.idDepartamento=pr.idDepartamento
where pr.nombre is null;


--Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.

select pr.nombre as "Profesor" 
from profesor as pr
inner join departamento as dp on dp.idDepartamento=pr.idDepartamento
left join asignatura as asig on asig.idProfesor = pr.idProfesor
where asig.idAsignatura is null;


-- Devuelve un listado con las asignaturas que no tienen un profesor asignado.


select distinct(asig.nombre)
from profesor as pr
right join asignatura as asig on asig.idProfesor = pr.idProfesor
where pr.idProfesor is null;



























