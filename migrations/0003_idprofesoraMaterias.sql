ALTER TABLE Materias
ADD COLUMN idProfesor INT,
ADD CONSTRAINT fk_profesor
    FOREIGN KEY (idProfesor) REFERENCES Profesores(idProfesor);
