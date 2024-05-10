-- Active: 1714700953570@@172.16.101.128@3306
CREATE DATABASE Facultad
    DEFAULT CHARACTER SET = 'utf8mb4';

use Facultad;


create table departamento(
    idDepartamento int primary key,
    nombre varchar(50)
);

create table profesor(
    idProfesor int(10) primary key,
    nif varchar(9),
    nombre varchar(25) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50),
    ciudad varchar(25),
    direccion varchar(50) not null,
    telefono varchar(9),
    fecha_nacimiento date not null,
    sexo enum("H","M"),
    idDepartamento int(10),
    Foreign Key (idDepartamento) REFERENCES departamento(idDepartamento)
);


create table grado(
    idGrado int(10) primary key,
    nombre varchar(100) not null
);


create table curso_escolar(
    idCurso int(10) primary key,
    anyo_inicio year(4) not null,
    anyo_fin year(4) not null
);

create table asignatura(
    idAsignatura int(10) primary key,
    nombre varchar(100) not null,
    creditos float not NULL,
    tipo varchar(100),
    curso TINYINT(3) not null,
    cuatrimestre TINYINT(3),
    idProfesor int(10),
    idGrado int(10),
    Foreign Key (idProfesor) REFERENCES profesor(idProfesor),
    Foreign Key (idGrado) REFERENCES grado(idGrado)
);


create table alumno(
    idAlumno int(10) primary key,
    nif varchar(9),
    nombre varchar(25) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50),
    ciudad varchar(25),
    direccion varchar(50) not null,
    telefono varchar(9),
    fecha_nacimiento date not null,
    sexo enum("H","M")
);

create table alumno_se_matricula_asignatura(
    id_alumno int(10),
    id_asignatura int(10),
    id_curso_escolar int(10),
    primary key(id_alumno,id_asignatura,id_curso_escolar),
    Foreign Key (id_alumno) REFERENCES alumno(idAlumno),
    Foreign Key (id_asignatura) REFERENCES asignatura(idAsignatura),
    Foreign Key (id_curso_escolar) REFERENCES curso_escolar(idCurso)
);

    