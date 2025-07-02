const students = []
let studentCounter = 0
const studentForm = document.getElementById("studentForm")
const studentsTableBody = document.getElementById("studentsTableBody")
const totalCount = document.getElementById("totalCount")

document.addEventListener("DOMContentLoaded", () => {
  updateStudentsTable()
  studentForm.addEventListener("submit", handleFormSubmit)
  document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener("click", function (e) {
      e.preventDefault()
      const target = document.querySelector(this.getAttribute("href"))
      if (target) target.scrollIntoView({ behavior: "smooth", block: "start" })
    })
  })
  const btnPrimary = document.querySelector(".btn-primary")
  if (btnPrimary) {
    btnPrimary.addEventListener("click", () => {
      document.querySelector("#cursos").scrollIntoView({ behavior: "smooth" })
    })
  }
})

function handleFormSubmit(e) {
  e.preventDefault()
  const nombre = document.getElementById("nombre").value.trim()
  const edad = document.getElementById("edad").value.trim()
  const curso = document.getElementById("curso").value.trim()
  const email = document.getElementById("email").value.trim()

  if (!nombre || !edad || !curso || !email) {
    alert("Por favor, completa todos los campos")
    return
  }
  if (isNaN(edad) || edad < 1 || edad > 120) {
    alert("Por favor, ingresa una edad válida")
    return
  }
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    alert("Por favor, ingresa un email válido")
    return
  }

  students.push({
    id: ++studentCounter,
    nombre: nombre,
    edad: Number.parseInt(edad),
    curso: curso,
    email: email,
  })

  updateStudentsTable()
  studentForm.reset()
  showSuccessMessage("Estudiante registrado exitosamente")
}

function updateStudentsTable() {
  studentsTableBody.innerHTML = ""
  if (students.length === 0) {
    const noStudentsRow = document.createElement("tr")
    noStudentsRow.className = "no-students"
    noStudentsRow.innerHTML = '<td colspan="4">No hay estudiantes registrados</td>'
    studentsTableBody.appendChild(noStudentsRow)
  } else {
    students.forEach((student) => {
      const row = document.createElement("tr")
      row.innerHTML = `<td>${student.nombre}</td><td>${student.edad}</td><td>${student.curso}</td><td>${student.email}</td>`
      studentsTableBody.appendChild(row)
    })
  }
  totalCount.textContent = students.length
}

function showSuccessMessage(message) {
  const messageDiv = document.createElement("div")
  messageDiv.style.cssText = `position: fixed; top: 100px; right: 20px; background: #28a745; color: white; padding: 15px 20px; border-radius: 5px; box-shadow: 0 2px 10px rgba(0,0,0,0.2); z-index: 1001; font-weight: 500;`
  messageDiv.textContent = message
  document.body.appendChild(messageDiv)
  setTimeout(() => {
    if (messageDiv.parentNode) messageDiv.parentNode.removeChild(messageDiv)
  }, 3000)
}
