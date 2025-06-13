ALTER TABLE Materias
ADD COLUMN idProfesor INT,
ADD FOREIGN KEY (idProfesor) REFERENCES Profesores(idProfesor);
