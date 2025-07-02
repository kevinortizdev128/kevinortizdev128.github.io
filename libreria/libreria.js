const books = []
let nextId = 1
const prestamos = []
let nextPrestamoId = 1

// Referencias al formulario y tabla
const form = document.getElementById("bookForm")
const tableBody = document.querySelector("#booksTable tbody")
const bookCount = document.getElementById("bookCount")
const searchInput = document.getElementById("searchInput")

// Datos de ejemplo
const ejemploLibros = [
  {
    id: nextId++,
    title: "Cien años de soledad",
    author: "Gabriel García Márquez",
    year: 1967,
    isbn: "978-84-376-0494-7",
    disponible: true,
  },
  {
    id: nextId++,
    title: "El Quijote",
    author: "Miguel de Cervantes",
    year: 1605,
    isbn: "978-84-376-0495-4",
    disponible: true,
  },
  {
    id: nextId++,
    title: "Sapiens",
    author: "Yuval Noah Harari",
    year: 2011,
    isbn: "978-84-9992-275-0",
    disponible: true,
  },
  { id: nextId++, title: "1984", author: "George Orwell", year: 1949, isbn: "978-84-376-0496-1", disponible: true },
  {
    id: nextId++,
    title: "El Principito",
    author: "Antoine de Saint-Exupéry",
    year: 1943,
    isbn: "978-84-376-0497-8",
    disponible: true,
  },
]

// Cargar libros de ejemplo
ejemploLibros.forEach((libro) => books.push(libro))

// Funciones de navegación
function showTab(tabName) {
  // Ocultar todas las pestañas
  const tabs = document.querySelectorAll(".tab-content")
  tabs.forEach((tab) => tab.classList.remove("active"))

  // Remover clase active de todos los botones
  const buttons = document.querySelectorAll(".tab-btn")
  buttons.forEach((btn) => btn.classList.remove("active"))

  // Mostrar pestaña seleccionada
  document.getElementById(tabName).classList.add("active")

  // Activar botón correspondiente
  event.target.classList.add("active")

  // Actualizar contenido según la pestaña
  switch (tabName) {
    case "prestamos":
      actualizarSelectLibros()
      mostrarPrestamos()
      break
    case "inventario":
      mostrarInventario()
      actualizarEstadisticas()
      break
    case "buscar":
      showAllBooks()
      break
  }
}

// Función para agregar libro
form.addEventListener("submit", (e) => {
  e.preventDefault()

  const title = document.getElementById("title").value.trim()
  const author = document.getElementById("author").value.trim()
  const year = Number.parseInt(document.getElementById("year").value)
  const isbn = document.getElementById("isbn").value.trim()

  // Validaciones
  if (!title || !author || !year) {
    alert("Por favor, complete los campos obligatorios (título, autor y año).")
    return
  }

  if (year < 1000 || year > new Date().getFullYear()) {
    alert("Por favor, ingrese un año válido.")
    return
  }

  // Verificar si el libro ya existe
  if (
    books.some(
      (book) => book.title.toLowerCase() === title.toLowerCase() && book.author.toLowerCase() === author.toLowerCase(),
    )
  ) {
    alert("Este libro ya está registrado.")
    return
  }

  // Agregar libro
  const book = {
    id: nextId++,
    title,
    author,
    year,
    isbn: isbn || null,
    disponible: true,
  }
  books.push(book)

  // Actualizar tabla y limpiar formulario
  updateTable()
  form.reset()

  // Mostrar mensaje de éxito
  showMessage("Libro agregado exitosamente!")
})

// Función para buscar libros
function searchBooks() {
  const searchTerm = searchInput.value.toLowerCase().trim()

  if (!searchTerm) {
    showAllBooks()
    return
  }

  const filteredBooks = books.filter(
    (book) =>
      book.title.toLowerCase().includes(searchTerm) ||
      book.author.toLowerCase().includes(searchTerm) ||
      (book.isbn && book.isbn.toLowerCase().includes(searchTerm)),
  )

  updateTable(filteredBooks)
}

// Función para mostrar todos los libros
function showAllBooks() {
  searchInput.value = ""
  updateTable()
}

// Función para actualizar la tabla
function updateTable(booksToShow = books) {
  tableBody.innerHTML = ""

  if (booksToShow.length === 0) {
    tableBody.innerHTML = '<tr><td colspan="5" class="empty-state">No se encontraron libros</td></tr>'
    bookCount.textContent = "0"
    return
  }

  booksToShow.forEach((book) => {
    const row = document.createElement("tr")
    row.innerHTML = `
            <td>${book.title}</td>
            <td>${book.author}</td>
            <td>${book.year}</td>
            <td>${book.isbn || "N/A"}</td>
            <td>
                <button class="btn-small" onclick="deleteBook(${book.id})">Eliminar</button>
            </td>
        `
    tableBody.appendChild(row)
  })

  bookCount.textContent = booksToShow.length
}

// Función para eliminar libro
function deleteBook(id) {
  if (confirm("¿Estás seguro de que quieres eliminar este libro?")) {
    const index = books.findIndex((book) => book.id === id)
    if (index !== -1) {
      books.splice(index, 1)
      updateTable()
      showMessage("Libro eliminado exitosamente!")
    }
  }
}

// Funciones de préstamos
function actualizarSelectLibros() {
  const select = document.getElementById("libro-prestamo")
  const librosDisponibles = books.filter((libro) => libro.disponible)

  select.innerHTML =
    '<option value="">Seleccionar libro</option>' +
    librosDisponibles.map((libro) => `<option value="${libro.id}">${libro.title} - ${libro.author}</option>`).join("")
}

document.getElementById("form-prestamo").addEventListener("submit", function (e) {
  e.preventDefault()

  const libroId = Number.parseInt(document.getElementById("libro-prestamo").value)
  const usuario = document.getElementById("usuario").value
  const fechaPrestamo = document.getElementById("fecha-prestamo").value
  const fechaDevolucion = document.getElementById("fecha-devolucion").value

  const libro = books.find((l) => l.id === libroId)
  if (!libro) {
    showMessage("error", "Libro no encontrado")
    return
  }

  if (!libro.disponible) {
    showMessage("error", "El libro no está disponible")
    return
  }

  const nuevoPrestamo = {
    id: nextPrestamoId++,
    libroId,
    libroTitulo: libro.title,
    usuario,
    fechaPrestamo,
    fechaDevolucion,
    devuelto: false,
  }

  prestamos.push(nuevoPrestamo)
  libro.disponible = false

  this.reset()
  showMessage("success", "Préstamo registrado exitosamente")

  actualizarSelectLibros()
  mostrarPrestamos()
})

function mostrarPrestamos() {
  const container = document.getElementById("lista-prestamos")
  const prestamosActivos = prestamos.filter((p) => !p.devuelto)

  if (prestamosActivos.length === 0) {
    container.innerHTML = '<div class="empty-state">No hay préstamos activos</div>'
    return
  }

  container.innerHTML =
    "<h3>Préstamos Activos</h3>" +
    prestamosActivos
      .map(
        (prestamo) => `
            <div class="prestamo-card">
                <h4>${prestamo.libroTitulo}</h4>
                <div class="prestamo-info">
                    <div class="info-item">
                        <span class="info-label">Usuario:</span>
                        <span class="info-value">${prestamo.usuario}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Fecha Préstamo:</span>
                        <span class="info-value">${prestamo.fechaPrestamo}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Fecha Devolución:</span>
                        <span class="info-value">${prestamo.fechaDevolucion}</span>
                    </div>
                </div>
                <button class="btn-small devolver" onclick="devolverLibro(${prestamo.id})">
                    Devolver
                </button>
            </div>
        `,
      )
      .join("")
}

function devolverLibro(prestamoId) {
  const prestamo = prestamos.find((p) => p.id === prestamoId)
  const libro = books.find((l) => l.id === prestamo.libroId)

  prestamo.devuelto = true
  libro.disponible = true

  showMessage("success", "Libro devuelto exitosamente")
  mostrarPrestamos()
  actualizarSelectLibros()

  if (document.getElementById("inventario").classList.contains("active")) {
    mostrarInventario()
    actualizarEstadisticas()
  }
}

// Funciones de inventario
function mostrarInventario() {
  const container = document.getElementById("lista-inventario")

  if (books.length === 0) {
    container.innerHTML = '<div class="empty-state">No hay libros en el inventario</div>'
    return
  }

  container.innerHTML = books
    .map(
      (libro) => `
        <div class="libro-card">
            <h4>${libro.title}</h4>
            <div class="libro-info">
                <div class="info-item">
                    <span class="info-label">Autor:</span>
                    <span class="info-value">${libro.author}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">ISBN:</span>
                    <span class="info-value">${libro.isbn || "N/A"}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Año:</span>
                    <span class="info-value">${libro.year}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Estado:</span>
                    <span class="status ${libro.disponible ? "disponible" : "prestado"}">
                        ${libro.disponible ? "Disponible" : "Prestado"}
                    </span>
                </div>
            </div>
        </div>
    `,
    )
    .join("")
}

function actualizarEstadisticas() {
  const totalLibros = books.length
  const librosDisponibles = books.filter((l) => l.disponible).length
  const librosPrestados = books.filter((l) => !l.disponible).length

  document.getElementById("total-libros").textContent = totalLibros
  document.getElementById("libros-disponibles").textContent = librosDisponibles
  document.getElementById("libros-prestados").textContent = librosPrestados
}

// Función para mostrar mensajes
function showMessage(type, message) {
  const messageDiv = document.createElement("div")
  messageDiv.className = type === "error" ? "error-message" : "success-message"
  messageDiv.textContent = message
  document.body.appendChild(messageDiv)

  setTimeout(() => {
    messageDiv.remove()
  }, 3000)
}

// Permitir búsqueda con Enter
searchInput.addEventListener("keypress", (e) => {
  if (e.key === "Enter") {
    searchBooks()
  }
})

// Inicializar la aplicación
document.addEventListener("DOMContentLoaded", () => {
  actualizarEstadisticas()
  showAllBooks()
})
