-- 1. Obtener toda la información del profesor cédula 3333
SELECT * FROM profesor WHERE Cedula = 3333;
/* Resultado:
Cedula | Nombre  | Telefono
----------------------------
3333   | Alvarez | 2467865
*/

-- 2. Obtener los carnets de todos los estudiantes que han matriculado cursos, en orden de código de materia, grupo y carnet
SELECT DISTINCT Carnet FROM matricula ORDER BY CodMateria, Grupo, Carnet;
/* Resultado:
Carnet
-------
600000
700000
800000
*/

-- 3. Obtener los códigos y nombres de los cursos que tienen entre 2 y 4 créditos
SELECT CodMateria, Nombre FROM materia WHERE Creditos BETWEEN 2 AND 4;
/* Resultado:
CodMateria | Nombre
---------------------
A20        | Ciencias
A21        | Biología
C20        | Español
D20        | Inglés
*/

-- 4. Obtener la cédula y el nombre de todos los profesores cuyo apellido empieza con A
SELECT Cedula, Nombre FROM profesor WHERE Nombre LIKE 'A%';
/* Resultado:
Cedula | Nombre
----------------
2222   | Arce
3333   | Alvarez
*/

-- 5. Listar la cédula, el nombre y el teléfono de todos los profesores apellido Rojas
SELECT Cedula, Nombre, Telefono FROM profesor WHERE Nombre = 'Rojas';
/* Resultado:
Cedula | Nombre | Telefono
---------------------------
4444   | Rojas  | 5551234
*/

-- 6. Listar la nota promedio de todos los estudiantes matriculados
SELECT AVG(Nota) AS PromedioGeneral FROM matricula;
/* Resultado:
PromedioGeneral
----------------
79.0
*/

-- 7. Listar la cantidad total de estudiantes que efectuaron matrícula
SELECT COUNT(DISTINCT Carnet) AS TotalEstudiantes FROM matricula;
/* Resultado:
TotalEstudiantes
-----------------
3
*/

-- 8. Listar la suma de las notas de los estudiantes que matricularon Ciencias
SELECT SUM(Nota) AS SumaNotasCiencias FROM matricula WHERE CodMateria = 'A20';
/* Resultado:
SumaNotasCiencias
------------------
100
*/

-- 9. Obtener la cantidad de cursos que tienen más de 3 créditos
SELECT COUNT(*) AS CantidadCursos FROM materia WHERE Creditos > 3;
/* Resultado:
CantidadCursos
---------------
3
*/

-- 10. Lista: nombre del profesor, nombre de materia, grupo, créditos
SELECT p.Nombre, m.Nombre, g.Grupo, m.Creditos
FROM grupo g
JOIN profesor p ON g.Prof = p.Cedula
JOIN materia m ON g.CodMateria = m.CodMateria;
/* Resultado (resumen):
NombreProf | NombreMateria | Grupo | Creditos
---------------------------------------------
Pérez      | Ciencias       | 02    | 4
Pérez      | Matemátic      | 01    | 5
Arce       | Ciencias       | 01    | 4
Arce       | Español        | 01    | 4
Arce       | Español        | 02    | 4
Alvarez    | Biología       | 01    | 3
Alvarez    | Inglés         | 02    | 2
*/

-- 11. Materia, grupo, estudiante, nota (>90)
SELECT m.Nombre, g.Grupo, e.Nombre, ma.Nota
FROM matricula ma
JOIN estudiante e ON ma.Carnet = e.Carnet
JOIN grupo g ON ma.CodMateria = g.CodMateria AND ma.Grupo = g.Grupo
JOIN materia m ON ma.CodMateria = m.CodMateria
WHERE ma.Nota > 90;
/* Resultado:
NombreMateria | Grupo | NombreEstudiante | Nota
-----------------------------------------------
Ciencias      | 01    | Rojas            | 100
Biología      | 01    | Rojas            | 95
*/

-- 12. Estudiantes con Alvarez que perdieron
SELECT DISTINCT e.Nombre
FROM profesor p
JOIN grupo g ON p.Cedula = g.Prof
JOIN matricula m ON g.CodMateria = m.CodMateria AND g.Grupo = m.Grupo
JOIN estudiante e ON m.Carnet = e.Carnet
WHERE p.Nombre = 'Alvarez' AND m.Nota < 60;
/* Resultado:
Nombre
-------
Castro
*/

-- 13. Código, nombre, cantidad de matriculados por materia
SELECT m.CodMateria, m.Nombre, COUNT(DISTINCT ma.Carnet) AS TotalEstudiantes
FROM materia m
LEFT JOIN matricula ma ON m.CodMateria = ma.CodMateria
GROUP BY m.CodMateria, m.Nombre;
/* Resultado:
CodMateria | Nombre     | TotalEstudiantes
------------------------------------------
A20        | Ciencias   | 1
A21        | Biología   | 1
B20        | Matemátic  | 2
C20        | Español    | 0
D20        | Inglés     | 1
*/

-- 14. Materias impartidas por Alvarez (cod 'A%') y total de matriculados
SELECT m.Nombre, g.Grupo, COUNT(ma.Carnet) AS TotalMatriculados
FROM grupo g
JOIN profesor p ON g.Prof = p.Cedula
JOIN materia m ON g.CodMateria = m.CodMateria
JOIN matricula ma ON g.CodMateria = ma.CodMateria AND g.Grupo = ma.Grupo
WHERE p.Nombre = 'Alvarez' AND m.CodMateria LIKE 'A%'
GROUP BY m.Nombre, g.Grupo;
/* Resultado:
NombreMateria | Grupo | TotalMatriculados
-----------------------------------------
Biología      | 01    | 1
*/

-- 15. Estudiantes que matricularon Inglés y están en Matemática
SELECT DISTINCT e.Nombre
FROM estudiante e
JOIN matricula m ON e.Carnet = m.Carnet
JOIN materia mat ON m.CodMateria = mat.CodMateria
WHERE mat.Nombre = 'Inglés' AND e.Carrera = 'Matemática';
/* Resultado:
Nombre
-------
Castro
*/
