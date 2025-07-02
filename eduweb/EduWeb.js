let cursos = []
let recursos = []
let evaluaciones = []
const students = []
let nextCursoId = 1
let nextRecursoId = 1
let nextEvaluacionId = 1
let nextId = 1

// Datos de ejemplo
const cursosEjemplo = [
  {
    id: nextCursoId++,
    titulo: "JavaScript Fundamentals",
    descripcion: "Aprende los conceptos básicos de JavaScript desde cero",
    categoria: "programacion",
    nivel: "principiante",
    duracion: 20,
    instructor: "Ana García",
    progreso: 75,
    completado: false,
  },
  {
    id: nextCursoId++,
    titulo: "React para Principiantes",
    descripcion: "Construye aplicaciones web modernas con React",
    categoria: "programacion",
    nivel: "intermedio",
    duracion: 30,
    instructor: "Carlos López",
    progreso: 45,
    completado: false,
  },
  {
    id: nextCursoId++,
    titulo: "Matemáticas Avanzadas",
    descripcion: "Cálculo diferencial e integral aplicado",
    categoria: "matematicas",
    nivel: "avanzado",
    duracion: 40,
    instructor: "Dr. Martínez",
    progreso: 100,
    completado: true,
  },
]

const recursosEjemplo = [
  {
    id: nextRecursoId++,
    titulo: "Guía de JavaScript ES6+",
    tipo: "documentos",
    descripcion: "Documento completo sobre las nuevas características de JavaScript",
    url: "#",
  },
  {
    id: nextRecursoId++,
    titulo: "Tutorial de React Hooks",
    tipo: "videos",
    descripcion: "Video tutorial sobre el uso de React Hooks",
    url: "#",
  },
  {
    id: nextRecursoId++,
    titulo: "MDN Web Docs",
    tipo: "enlaces",
    descripcion: "Documentación oficial de tecnologías web",
    url: "https://developer.mozilla.org",
  },
]

const evaluacionesEjemplo = [
  {
    id: nextEvaluacionId++,
    titulo: "Evaluación JavaScript Básico",
    curso: "JavaScript Fundamentals",
    preguntas: [
      {
        pregunta: "¿Qué es una variable en JavaScript?",
        opciones: ["Un contenedor para almacenar datos", "Una función", "Un objeto", "Un método"],
        respuestaCorrecta: 0,
      },
      {
        pregunta: "¿Cuál es la forma correcta de declarar una variable?",
        opciones: ["variable x = 5", "let x = 5", "x = 5", "declare x = 5"],
        respuestaCorrecta: 1,
      },
    ],
    disponible: true,
    completada: false,
    puntuacion: null,
  },
]

const ejemploEstudiantes = [
  {
    id: nextId++,
    nombre: "Ana García",
    edad: 22,
    curso: "Desarrollo Web",
    email: "ana.garcia@email.com",
    fechaRegistro: "2024-01-15",
  },
  {
    id: nextId++,
    nombre: "Carlos López",
    edad: 28,
    curso: "Python para Principiantes",
    email: "carlos.lopez@email.com",
    fechaRegistro: "2024-01-20",
  },
  {
    id: nextId++,
    nombre: "María Rodríguez",
    edad: 25,
    curso: "Análisis de Datos",
    email: "maria.rodriguez@email.com",
    fechaRegistro: "2024-02-01",
  },
  {
    id: nextId++,
    nombre: "Juan Martínez",
    edad: 30,
    curso: "JavaScript Avanzado",
    email: "juan.martinez@email.com",
    fechaRegistro: "2024-02-05",
  },
  {
    id: nextId++,
    nombre: "Laura Sánchez",
    edad: 24,
    curso: "React Fundamentals",
    email: "laura.sanchez@email.com",
    fechaRegistro: "2024-02-10",
  },
]

// Cargar estudiantes de ejemplo
ejemploEstudiantes.forEach((estudiante) => students.push(estudiante))

// Inicializar con datos de ejemplo
cursos = [...cursosEjemplo]
recursos = [...recursosEjemplo]
evaluaciones = [...evaluacionesEjemplo]

// Navegación
function showSection(sectionName) {
  // Ocultar todas las secciones
  const sections = document.querySelectorAll(".section")
  sections.forEach((section) => section.classList.remove("active"))

  // Remover clase active de todos los enlaces
  const navLinks = document.querySelectorAll(".nav-link")
  navLinks.forEach((link) => link.classList.remove("active"))

  // Mostrar sección seleccionada
  document.getElementById(sectionName).classList.add("active")

  // Activar enlace correspondiente
  const activeLink = document.querySelector(`[href="#${sectionName}"]`)
  if (activeLink) {
    activeLink.classList.add("active")
  }

  // Actualizar contenido según la sección
  switch (sectionName) {
    case "cursos":
      mostrarCursos()
      break
    case "recursos":
      mostrarRecursos("documentos")
      break
    case "evaluaciones":
      mostrarEvaluaciones("disponibles")
      break
    case "estudiantes":
      updateStudentsTable()
      break
  }

  // Cerrar menú móvil si está abierto
  const navMenu = document.querySelector(".nav-menu")
  navMenu.classList.remove("active")
}

// Menú hamburguesa
document.querySelector(".hamburger").addEventListener("click", () => {
  const navMenu = document.querySelector(".nav-menu")
  navMenu.classList.toggle("active")
})

// Enlaces de navegación
document.querySelectorAll(".nav-link").forEach((link) => {
  link.addEventListener("click", function (e) {
    e.preventDefault()

    // Remover active de todos los enlaces
    document.querySelectorAll(".nav-link").forEach((l) => l.classList.remove("active"))
    document.querySelectorAll(".section").forEach((s) => s.classList.remove("active"))

    // Activar enlace y sección actual
    this.classList.add("active")
    const sectionId = this.getAttribute("href").substring(1)
    document.getElementById(sectionId).classList.add("active")
  })
})

// Gestión de Cursos
function mostrarCursos() {
  const container = document.getElementById("lista-cursos")

  if (cursos.length === 0) {
    container.innerHTML = '<div class="empty-state">No hay cursos disponibles</div>'
    return
  }

  container.innerHTML = cursos
    .map(
      (curso) => `
        <div class="course-card">
            <div class="course-header">
                <div>
                    <h3 class="course-title">${curso.titulo}</h3>
                    <span class="course-level ${curso.nivel}">${curso.nivel}</span>
                </div>
            </div>
            <p class="course-description">${curso.descripcion}</p>
            <div class="course-meta">
                <span>👨‍🏫 ${curso.instructor}</span>
                <span>⏱️ ${curso.duracion} horas</span>
                <span>📚 ${curso.categoria}</span>
            </div>
            <div class="course-progress">
                <div class="progress-bar">
                    <div class="progress-fill" style="width: ${curso.progreso}%"></div>
                </div>
                <small>${curso.progreso}% completado</small>
            </div>
            <div class="course-actions">
                <button class="btn-small btn-continue" onclick="continuarCurso(${curso.id})">
                    ${curso.progreso === 0 ? "Comenzar" : "Continuar"}
                </button>
                <button class="btn-small btn-info" onclick="verDetallesCurso(${curso.id})">Detalles</button>
            </div>
        </div>
    `,
    )
    .join("")
}

function filtrarCursos() {
  const categoria = document.getElementById("filtro-categoria").value
  const nivel = document.getElementById("filtro-nivel").value

  let cursosFiltrados = cursos

  if (categoria) {
    cursosFiltrados = cursosFiltrados.filter((curso) => curso.categoria === categoria)
  }

  if (nivel) {
    cursosFiltrados = cursosFiltrados.filter((curso) => curso.nivel === nivel)
  }

  const container = document.getElementById("lista-cursos")

  if (cursosFiltrados.length === 0) {
    container.innerHTML = '<div class="empty-state">No se encontraron cursos con los filtros seleccionados</div>'
    return
  }

  container.innerHTML = cursosFiltrados
    .map(
      (curso) => `
        <div class="course-card">
            <div class="course-header">
                <div>
                    <h3 class="course-title">${curso.titulo}</h3>
                    <span class="course-level ${curso.nivel}">${curso.nivel}</span>
                </div>
            </div>
            <p class="course-description">${curso.descripcion}</p>
            <div class="course-meta">
                <span>👨‍🏫 ${curso.instructor}</span>
                <span>⏱️ ${curso.duracion} horas</span>
                <span>📚 ${curso.categoria}</span>
            </div>
            <div class="course-progress">
                <div class="progress-bar">
                    <div class="progress-fill" style="width: ${curso.progreso}%"></div>
                </div>
                <small>${curso.progreso}% completado</small>
            </div>
            <div class="course-actions">
                <button class="btn-small btn-continue" onclick="continuarCurso(${curso.id})">
                    ${curso.progreso === 0 ? "Comenzar" : "Continuar"}
                </button>
                <button class="btn-small btn-info" onclick="verDetallesCurso(${curso.id})">Detalles</button>
            </div>
        </div>
    `,
    )
    .join("")
}

function mostrarFormularioCurso() {
  document.getElementById("modal-curso").style.display = "block"
}

function cerrarModal() {
  document.getElementById("modal-curso").style.display = "none"
}

function continuarCurso(id) {
  const curso = cursos.find((c) => c.id === id)
  alert(`Continuando con el curso: ${curso.titulo}`)
  // Aquí iría la lógica para abrir el contenido del curso
}

function verDetallesCurso(id) {
  const curso = cursos.find((c) => c.id === id)
  alert(
    `Detalles del curso: ${curso.titulo}\n\nDescripción: ${curso.descripcion}\nInstructor: ${curso.instructor}\nDuración: ${curso.duracion} horas`,
  )
}

// Gestión de Recursos
function mostrarRecursos(tipo) {
  const container = document.getElementById("lista-recursos")

  if (recursos.length === 0) {
    container.innerHTML = '<div class="empty-state">No hay recursos disponibles</div>'
    return
  }

  const recursosFiltrados = recursos.filter((recurso) => recurso.tipo === tipo)

  if (recursosFiltrados.length === 0) {
    container.innerHTML = '<div class="empty-state">No se encontraron recursos con el tipo seleccionado</div>'
    return
  }

  container.innerHTML = recursosFiltrados
    .map(
      (recurso) => `
        <div class="resource-card">
            <h3 class="resource-title">${recurso.titulo}</h3>
            <p class="resource-description">${recurso.descripcion}</p>
            <a href="${recurso.url}" class="resource-link">Ver recurso</a>
        </div>
    `,
    )
    .join("")
}

// Gestión de Evaluaciones
function mostrarEvaluaciones(estado) {
  const container = document.getElementById("lista-evaluaciones")

  if (evaluaciones.length === 0) {
    container.innerHTML = '<div class="empty-state">No hay evaluaciones disponibles</div>'
    return
  }

  const evaluacionesFiltradas = evaluaciones.filter(
    (evaluacion) => evaluacion.disponible === (estado === "disponibles"),
  )

  if (evaluacionesFiltradas.length === 0) {
    container.innerHTML = '<div class="empty-state">No se encontraron evaluaciones con el estado seleccionado</div>'
    return
  }

  container.innerHTML = evaluacionesFiltradas
    .map(
      (evaluacion) => `
        <div class="evaluation-card">
            <h3 class="evaluation-title">${evaluacion.titulo}</h3>
            <p class="evaluation-course">Curso: ${evaluacion.curso}</p>
            <button class="btn-small btn-take" onclick="tomarEvaluacion(${evaluacion.id})">Tomar Evaluación</button>
        </div>
    `,
    )
    .join("")
}

function tomarEvaluacion(id) {
  const evaluacion = evaluaciones.find((e) => e.id === id)
  alert(`Tomando evaluación: ${evaluacion.titulo}`)
  // Aquí iría la lógica para abrir la evaluación
}

// Formulario de curso
document.getElementById("form-curso").addEventListener("submit", (e) => {
  e.preventDefault()
  // Aquí iría la lógica para manejar el envío del formulario de curso
})

// Referencias al formulario y tabla
const searchStudents = document.getElementById("searchStudents")
const courseFilter = document.getElementById("courseFilter")
const totalCount = document.getElementById("totalCount")
const activeStudents = document.getElementById("activeStudents")

// Función para formatear fecha
function formatDate(dateString) {
  const date = new Date(dateString)
  return date.toLocaleDateString("es-ES")
}

// Función para actualizar la tabla de estudiantes
function updateStudentsTable(studentsToShow = students) {
  const tableBody = document.querySelector("#studentsTable tbody")
  tableBody.innerHTML = ""

  if (studentsToShow.length === 0) {
    tableBody.innerHTML = '<tr><td colspan="6" class="empty-state">No se encontraron estudiantes</td></tr>'
    totalCount.textContent = "0"
    activeStudents.textContent = "0"
    return
  }

  studentsToShow.forEach((student) => {
    const row = document.createElement("tr")
    row.innerHTML = `
        <td>${student.nombre}</td>
        <td>${student.edad}</td>
        <td>${student.curso}</td>
        <td>${student.email}</td>
        <td>${formatDate(student.fechaRegistro)}</td>
        <td>
            <button class="btn-delete" onclick="deleteStudent(${student.id})">Eliminar</button>
        </td>
    `
    tableBody.appendChild(row)
  })

  // Actualizar contadores
  totalCount.textContent = studentsToShow.length
  activeStudents.textContent = students.length
}

// Función para eliminar estudiante
function deleteStudent(id) {
  if (confirm("¿Estás seguro de que quieres eliminar este estudiante?")) {
    const index = students.findIndex((student) => student.id === id)
    if (index !== -1) {
      students.splice(index, 1)
      updateStudentsTable()
      showMessage("Estudiante eliminado exitosamente!")
    }
  }
}

// Función para filtrar estudiantes
function filterStudents() {
  const searchTerm = searchStudents.value.toLowerCase().trim()
  const selectedCourse = courseFilter.value

  let filteredStudents = students

  if (searchTerm) {
    filteredStudents = filteredStudents.filter(
      (student) =>
        student.nombre.toLowerCase().includes(searchTerm) ||
        student.email.toLowerCase().includes(searchTerm) ||
        student.curso.toLowerCase().includes(searchTerm),
    )
  }

  if (selectedCourse) {
    filteredStudents = filteredStudents.filter((student) => student.curso === selectedCourse)
  }

  updateStudentsTable(filteredStudents)
}

// Función para mostrar todos los estudiantes
function showAllStudents() {
  searchStudents.value = ""
  courseFilter.value = ""
  updateStudentsTable()
}

// Manejar envío del formulario
document.getElementById("studentForm").addEventListener("submit", (e) => {
  e.preventDefault()

  const nombre = document.getElementById("nombre").value.trim()
  const edad = Number.parseInt(document.getElementById("edad").value)
  const curso = document.getElementById("curso").value
  const email = document.getElementById("email").value.trim()

  // Validaciones
  if (!nombre || !edad || !curso || !email) {
    alert("Por favor, complete todos los campos.")
    return
  }

  if (edad < 16 || edad > 100) {
    alert("La edad debe estar entre 16 y 100 años.")
    return
  }

  // Validar email
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!emailRegex.test(email)) {
    alert("Por favor, ingrese un email válido.")
    return
  }

  // Verificar si el email ya existe
  if (students.some((student) => student.email.toLowerCase() === email.toLowerCase())) {
    alert("Ya existe un estudiante registrado con este email.")
    return
  }

  // Agregar estudiante
  const student = {
    id: nextId++,
    nombre,
    edad,
    curso,
    email,
    fechaRegistro: new Date().toISOString().split("T")[0],
  }
  students.push(student)

  // Actualizar tabla y limpiar formulario
  updateStudentsTable()
  document.getElementById("studentForm").reset()

  // Mostrar mensaje de éxito
  showMessage("Estudiante registrado exitosamente!")
})

// Función para mostrar mensajes
function showMessage(message) {
  const messageDiv = document.createElement("div")
  messageDiv.className = "success-message"
  messageDiv.textContent = message
  document.body.appendChild(messageDiv)

  setTimeout(() => {
    messageDiv.remove()
  }, 3000)
}

// Permitir filtrado con Enter
searchStudents.addEventListener("keypress", (e) => {
  if (e.key === "Enter") {
    filterStudents()
  }
})

// Filtrado automático al cambiar curso
courseFilter.addEventListener("change", filterStudents)

// Cargar tabla inicial
updateStudentsTable()

// Animación para las tarjetas de cursos
document.addEventListener("DOMContentLoaded", () => {
  const courseCards = document.querySelectorAll(".course-card")

  courseCards.forEach((card, index) => {
    card.style.opacity = "0"
    card.style.transform = "translateY(20px)"

    setTimeout(() => {
      card.style.transition = "all 0.6s ease"
      card.style.opacity = "1"
      card.style.transform = "translateY(0)"
    }, index * 200)
  })
})
