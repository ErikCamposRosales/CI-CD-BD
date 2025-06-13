CREATE TABLE IF NOT EXISTS Inscripciones (
    idInscripcion INT AUTO_INCREMENT PRIMARY KEY,
    idEstudiante INT NOT NULL,
    idMateria INT NOT NULL,
    FechaInscripcion DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (idEstudiante) REFERENCES Estudiantes(idEstudiante),
    FOREIGN KEY (idMateria) REFERENCES Materias(idMateria)
);
