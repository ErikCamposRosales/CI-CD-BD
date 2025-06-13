-- Crear base de datos
CREATE DATABASE IF NOT EXISTS mydatabase;
USE mydatabase;

-- Tabla: Grupos (crear primero por clave foránea)
CREATE TABLE Grupos (
    idGrupo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(10) NOT NULL,
    grado INT NOT NULL,
    turno ENUM('Matutino', 'Vespertino')
);

-- Tabla: Estudiantes
CREATE TABLE Estudiantes (
    idEstudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    fechaNacimiento DATE,
    genero ENUM('M','F','Otro'),
    grupoId INT,
    FOREIGN KEY (grupoId) REFERENCES Grupos(idGrupo)
);

-- Tabla: Maestros
CREATE TABLE Maestros (
    idMaestro INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    numeroEmpleado VARCHAR(20) UNIQUE NOT NULL,
    especialidad VARCHAR(100)
);

-- Tabla: Materias
CREATE TABLE Materias (
    idMateria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    clave VARCHAR(10) UNIQUE NOT NULL,
    creditos INT NOT NULL
);

-- Tabla: Calificaciones
CREATE TABLE Calificaciones (
    idCalificacion INT AUTO_INCREMENT PRIMARY KEY,
    idEstudiante INT,
    idMateria INT,
    idMaestro INT,
    calificacion DECIMAL(5,2),
    fechaRegistro DATE,
    FOREIGN KEY (idEstudiante) REFERENCES Estudiantes(idEstudiante),
    FOREIGN KEY (idMateria) REFERENCES Materias(idMateria),
    FOREIGN KEY (idMaestro) REFERENCES Maestros(idMaestro)
);

-- Insertar algunos grupos
INSERT INTO Grupos (nombre, grado, turno) VALUES 
('A', 1, 'Matutino'),
('B', 2, 'Vespertino');

-- Insertar maestros
INSERT INTO Maestros (nombre, apellido, numeroEmpleado, especialidad) VALUES
('Luis', 'Ramírez', 'EMP001', 'Matemáticas'),
('Ana', 'López', 'EMP002', 'Historia');

-- Insertar materias
INSERT INTO Materias (nombre, clave, creditos) VALUES
('Matemáticas I', 'MAT101', 6),
('Historia Universal', 'HIS201', 4);

-- Insertar estudiantes
INSERT INTO Estudiantes (nombre, apellido, matricula, fechaNacimiento, genero, grupoId) VALUES
('Carlos', 'Pérez', '2023A001', '2005-02-10', 'M', 1),
('María', 'García', '2023A002', '2005-05-22', 'F', 1),
('Daniel', 'Sánchez', '2023B001', '2004-11-03', 'M', 2);

-- Insertar calificaciones
INSERT INTO Calificaciones (idEstudiante, idMateria, idMaestro, calificacion, fechaRegistro) VALUES
(1, 1, 1, 88.5, CURDATE()),
(2, 1, 1, 95.0, CURDATE()),
(3, 2, 2, 76.0, CURDATE());