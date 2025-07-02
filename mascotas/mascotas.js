let mascotas = []
let citas = []
let nextMascotaId = 1
let nextCitaId = 1

// Array para almacenar las mascotas
const pets = []
let nextId = 1

// Referencias al formulario y contenedor
const form = document.getElementById("petForm")
const petsList = document.getElementById("petsList")
const petCount = document.getElementById("petCount")
const searchInput = document.getElementById("searchInput")
const speciesFilter = document.getElementById("speciesFilter")

// Iconos para especies
const especieIconos = {
  perro: "🐕",
  gato: "🐱",
  ave: "🐦",
  pez: "🐠",
  hamster: "🐹",
  conejo: "🐰",
  reptil: "🦎",
  otro: "🐾",
}

const speciesIcons = {
  perro: "🐕",
  gato: "🐱",
  ave: "🐦",
  pez: "🐠",
  hamster: "🐹",
  conejo: "🐰",
  reptil: "🦎",
  otro: "🐾",
}

// Datos de ejemplo
const mascotasEjemplo = [
  {
    id: nextMascotaId++,
    nombre: "Max",
    especie: "perro",
    raza: "Golden Retriever",
    edad: 3,
    peso: 25.5,
    color: "Dorado",
    propietario: "Juan Pérez",
    telefono: "555-0123",
    email: "juan@email.com",
    direccion: "Calle Principal 123",
    observaciones: "Muy activo, le gusta jugar con otros perros",
  },
  {
    id: nextMascotaId++,
    nombre: "Luna",
    especie: "gato",
    raza: "Siamés",
    edad: 2,
    peso: 4.2,
    color: "Gris y blanco",
    propietario: "María García",
    telefono: "555-0456",
    email: "maria@email.com",
    direccion: "Avenida Central 456",
    observaciones: "Alérgica a ciertos alimentos, dieta especial",
  },
  {
    id: nextMascotaId++,
    nombre: "Charlie",
    especie: "ave",
    raza: "Canario",
    edad: 1,
    peso: 0.02,
    color: "Amarillo",
    propietario: "Carlos López",
    telefono: "555-0789",
    email: "carlos@email.com",
    direccion: "Plaza Mayor 789",
    observaciones: "Canta muy bien, necesita vitaminas especiales",
  },
]

const ejemploMascotas = [
  {
    id: nextId++,
    name: "Max",
    species: "perro",
    breed: "Golden Retriever",
    age: 3,
    owner: "Juan Pérez",
    phone: "555-0123",
  },
  {
    id: nextId++,
    name: "Luna",
    species: "gato",
    breed: "Siamés",
    age: 2,
    owner: "María García",
    phone: "555-0456",
  },
  {
    id: nextId++,
    name: "Charlie",
    species: "ave",
    breed: "Canario",
    age: 1,
    owner: "Carlos López",
    phone: "555-0789",
  },
  {
    id: nextId++,
    name: "Nemo",
    species: "pez",
    breed: "Pez Payaso",
    age: 1,
    owner: "Ana Martínez",
    phone: "555-0321",
  },
  {
    id: nextId++,
    name: "Coco",
    species: "hamster",
    breed: "Hámster Dorado",
    age: 1,
    owner: "Luis Rodríguez",
    phone: "555-0654",
  },
]

// Inicializar con datos de ejemplo
mascotas = [...mascotasEjemplo]
ejemploMascotas.forEach((mascota) => pets.push(mascota))

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
    case "lista":
      mostrarTodasLasMascotas()
      break
    case "citas":
      actualizarSelectMascotas()
      mostrarCitas()
      break
    case "estadisticas":
      actualizarEstadisticas()
      mostrarDistribucionEspecies()
      mostrarProximasCitas()
      break
  }
}

// Función para registrar mascota
document.getElementById("form-mascota").addEventListener("submit", function (e) {
  e.preventDefault()

  const nuevaMascota = {
    id: nextMascotaId++,
    nombre: document.getElementById("nombre").value,
    especie: document.getElementById("especie").value,
    raza: document.getElementById("raza").value,
    edad: Number.parseFloat(document.getElementById("edad").value),
    peso: Number.parseFloat(document.getElementById("peso").value),
    color: document.getElementById("color").value,
    propietario: document.getElementById("propietario").value,
    telefono: document.getElementById("telefono").value,
    email: document.getElementById("email").value,
    direccion: document.getElementById("direccion").value,
    observaciones: document.getElementById("observaciones").value,
  }

  mascotas.push(nuevaMascota)

  // Limpiar formulario
  this.reset()

  mostrarMensaje("success", "Mascota registrada exitosamente")

  // Actualizar estadísticas si estamos en esa pestaña
  if (document.getElementById("estadisticas").classList.contains("active")) {
    actualizarEstadisticas()
    mostrarDistribucionEspecies()
  }
})

// Funciones de búsqueda y filtrado
function buscarMascotas() {
  const termino = document.getElementById("search-input").value.toLowerCase()
  const resultados = mascotas.filter(
    (mascota) =>
      mascota.nombre.toLowerCase().includes(termino) ||
      mascota.propietario.toLowerCase().includes(termino) ||
      mascota.especie.toLowerCase().includes(termino) ||
      mascota.raza.toLowerCase().includes(termino),
  )

  mostrarMascotas(resultados)
}

function filtrarPorEspecie() {
  const especieSeleccionada = document.getElementById("filtro-especie").value

  if (especieSeleccionada === "") {
    mostrarTodasLasMascotas()
  } else {
    const resultados = mascotas.filter((mascota) => mascota.especie === especieSeleccionada)
    mostrarMascotas(resultados)
  }
}

function mostrarTodasLasMascotas() {
  mostrarMascotas(mascotas)
}

function mostrarMascotas(listaMascotas) {
  const container = document.getElementById("lista-mascotas")

  if (listaMascotas.length === 0) {
    container.innerHTML = '<div class="empty-state">No se encontraron mascotas</div>'
    return
  }

  container.innerHTML = listaMascotas
    .map(
      (mascota) => `
        <div class="mascota-card">
            <div class="mascota-header">
                <div class="mascota-nombre">
                    <span class="especie-icon">${especieIconos[mascota.especie]}</span>
                    ${mascota.nombre}
                </div>
                <div>
                    <button class="btn-small editar" onclick="editarMascota(${mascota.id})">Editar</button>
                    <button class="btn-small eliminar" onclick="eliminarMascota(${mascota.id})">Eliminar</button>
                </div>
            </div>
            <div class="mascota-info">
                <div class="info-item">
                    <span class="info-label">Especie:</span>
                    <span class="info-value">${mascota.especie.charAt(0).toUpperCase() + mascota.especie.slice(1)}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Raza:</span>
                    <span class="info-value">${mascota.raza}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Edad:</span>
                    <span class="info-value">${mascota.edad} años</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Peso:</span>
                    <span class="info-value">${mascota.peso} kg</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Color:</span>
                    <span class="info-value">${mascota.color}</span>
                </div>
            </div>
            <div class="propietario-info">
                <h4>👤 Información del Propietario</h4>
                <div class="mascota-info">
                    <div class="info-item">
                        <span class="info-label">Nombre:</span>
                        <span class="info-value">${mascota.propietario}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Teléfono:</span>
                        <span class="info-value">${mascota.telefono}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Email:</span>
                        <span class="info-value">${mascota.email}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Dirección:</span>
                        <span class="info-value">${mascota.direccion}</span>
                    </div>
                </div>
                ${
                  mascota.observaciones
                    ? `
                    <div style="margin-top: 10px;">
                        <span class="info-label">Observaciones:</span>
                        <div class="info-value">${mascota.observaciones}</div>
                    </div>
                `
                    : ""
                }
            </div>
        </div>
    `,
    )
    .join("")
}

function filterPets() {
  const searchTerm = searchInput.value.toLowerCase().trim()
  const selectedSpecies = speciesFilter.value

  let filteredPets = pets

  if (searchTerm) {
    filteredPets = filteredPets.filter(
      (pet) =>
        pet.name.toLowerCase().includes(searchTerm) ||
        pet.owner.toLowerCase().includes(searchTerm) ||
        pet.breed.toLowerCase().includes(searchTerm),
    )
  }

  if (selectedSpecies) {
    filteredPets = filteredPets.filter((pet) => pet.species === selectedSpecies)
  }

  updatePetsList(filteredPets)
}

function showAllPets() {
  searchInput.value = ""
  speciesFilter.value = ""
  updatePetsList()
}

// Funciones de gestión de mascotas
function editarMascota(id) {
  const mascota = mascotas.find((m) => m.id === id)
  if (!mascota) return

  // Cambiar a la pestaña de registro
  showTab("registro")
  document.querySelector("[onclick=\"showTab('registro')\"]").classList.add("active")

  // Llenar el formulario con los datos de la mascota
  document.getElementById("nombre").value = mascota.nombre
  document.getElementById("especie").value = mascota.especie
  document.getElementById("raza").value = mascota.raza
  document.getElementById("edad").value = mascota.edad
  document.getElementById("peso").value = mascota.peso
  document.getElementById("color").value = mascota.color
  document.getElementById("propietario").value = mascota.propietario
  document.getElementById("telefono").value = mascota.telefono
  document.getElementById("email").value = mascota.email
  document.getElementById("direccion").value = mascota.direccion
  document.getElementById("observaciones").value = mascota.observaciones

  // Cambiar el comportamiento del formulario para editar
  const form = document.getElementById("form-mascota")
  form.dataset.editId = id
  form.querySelector('button[type="submit"]').textContent = "Actualizar Mascota"
}

function eliminarMascota(id) {
  if (confirm("¿Estás seguro de que quieres eliminar esta mascota?")) {
    mascotas = mascotas.filter((m) => m.id !== id)
    mostrarMensaje("success", "Mascota eliminada exitosamente")
    mostrarTodasLasMascotas()

    // Actualizar estadísticas si estamos en esa pestaña
    if (document.getElementById("estadisticas").classList.contains("active")) {
      actualizarEstadisticas()
      mostrarDistribucionEspecies()
    }
  }
}

function deletePet(id) {
  if (confirm("¿Estás seguro de que quieres eliminar esta mascota?")) {
    const index = pets.findIndex((pet) => pet.id === id)
    if (index !== -1) {
      pets.splice(index, 1)
      updatePetsList()
      showMessage("Mascota eliminada exitosamente!")
    }
  }
}

// Funciones de citas veterinarias
function actualizarSelectMascotas() {
  const select = document.getElementById("mascota-cita")

  select.innerHTML =
    '<option value="">Seleccionar mascota</option>' +
    mascotas
      .map(
        (mascota) =>
          `<option value="${mascota.id}">${mascota.nombre} (${mascota.especie}) - ${mascota.propietario}</option>`,
      )
      .join("")
}

document.getElementById("form-cita").addEventListener("submit", function (e) {
  e.preventDefault()

  const mascotaId = Number.parseInt(document.getElementById("mascota-cita").value)
  const mascota = mascotas.find((m) => m.id === mascotaId)

  const nuevaCita = {
    id: nextCitaId++,
    mascotaId,
    mascotaNombre: mascota.nombre,
    propietario: mascota.propietario,
    fecha: document.getElementById("fecha-cita").value,
    hora: document.getElementById("hora-cita").value,
    veterinario: document.getElementById("veterinario").value,
    motivo: document.getElementById("motivo").value,
    completada: false,
  }

  citas.push(nuevaCita)

  // Limpiar formulario
  this.reset()

  mostrarMensaje("success", "Cita programada exitosamente")
  mostrarCitas()
})

function mostrarCitas() {
  const container = document.getElementById("lista-citas")
  const citasPendientes = citas.filter((c) => !c.completada)

  if (citasPendientes.length === 0) {
    container.innerHTML = '<div class="empty-state">No hay citas programadas</div>'
    return
  }

  container.innerHTML =
    "<h3>Citas Programadas</h3>" +
    citasPendientes
      .map(
        (cita) => `
            <div class="cita-card">
                <div class="mascota-header">
                    <h4>🏥 ${cita.mascotaNombre} - ${cita.propietario}</h4>
                    <div>
                        <button class="btn-small" onclick="completarCita(${cita.id})">Completar</button>
                        <button class="btn-small eliminar" onclick="cancelarCita(${cita.id})">Cancelar</button>
                    </div>
                </div>
                <div class="mascota-info">
                    <div class="info-item">
                        <span class="info-label">Fecha:</span>
                        <span class="info-value">${cita.fecha}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Hora:</span>
                        <span class="info-value">${cita.hora}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Veterinario:</span>
                        <span class="info-value">${cita.veterinario}</span>
                    </div>
                </div>
                <div style="margin-top: 15px;">
                    <span class="info-label">Motivo:</span>
                    <div class="info-value">${cita.motivo}</div>
                </div>
            </div>
        `,
      )
      .join("")
}

function completarCita(id) {
  const cita = citas.find((c) => c.id === id)
  cita.completada = true

  mostrarMensaje("success", "Cita completada exitosamente")
  mostrarCitas()

  if (document.getElementById("estadisticas").classList.contains("active")) {
    actualizarEstadisticas()
    mostrarProximasCitas()
  }
}

function cancelarCita(id) {
  if (confirm("¿Estás seguro de que quieres cancelar esta cita?")) {
    citas = citas.filter((c) => c.id !== id)
    mostrarMensaje("success", "Cita cancelada exitosamente")
    mostrarCitas()

    if (document.getElementById("estadisticas").classList.contains("active")) {
      actualizarEstadisticas()
      mostrarProximasCitas()
    }
  }
}

// Funciones de estadísticas
function actualizarEstadisticas() {
  const totalMascotas = mascotas.length
  const totalPerros = mascotas.filter((m) => m.especie === "perro").length
  const totalGatos = mascotas.filter((m) => m.especie === "gato").length
  const citasPendientes = citas.filter((c) => !c.completada).length

  document.getElementById("total-mascotas").textContent = totalMascotas
  document.getElementById("total-perros").textContent = totalPerros
  document.getElementById("total-gatos").textContent = totalGatos
  document.getElementById("citas-pendientes").textContent = citasPendientes
}

function mostrarDistribucionEspecies() {
  const container = document.getElementById("especies-chart")
  const especies = {}

  mascotas.forEach((mascota) => {
    especies[mascota.especie] = (especies[mascota.especie] || 0) + 1
  })

  if (Object.keys(especies).length === 0) {
    container.innerHTML = '<div class="empty-state">No hay datos para mostrar</div>'
    return
  }

  container.innerHTML = Object.entries(especies)
    .map(
      ([especie, cantidad]) => `
        <div class="especies-item">
            <div class="especie-info">
                <span style="font-size: 1.5rem;">${especieIconos[especie]}</span>
                <span>${especie.charAt(0).toUpperCase() + especie.slice(1)}</span>
            </div>
            <span class="especie-count">${cantidad}</span>
        </div>
    `,
    )
    .join("")
}

function mostrarProximasCitas() {
  const container = document.getElementById("proximas-citas")
  const citasPendientes = citas
    .filter((c) => !c.completada)
    .sort((a, b) => new Date(a.fecha + " " + a.hora) - new Date(b.fecha + " " + b.hora))
    .slice(0, 5)

  if (citasPendientes.length === 0) {
    container.innerHTML = '<div class="empty-state">No hay citas programadas</div>'
    return
  }

  container.innerHTML = citasPendientes
    .map(
      (cita) => `
        <div class="cita-pendiente">
            <div class="cita-fecha">${cita.fecha} - ${cita.hora}</div>
            <div class="cita-info">${cita.mascotaNombre} con ${cita.veterinario}</div>
        </div>
    `,
    )
    .join("")
}

// Función para mostrar mensajes
function mostrarMensaje(tipo, mensaje) {
  const existingMessage = document.querySelector(".success-message, .error-message")
  if (existingMessage) {
    existingMessage.remove()
  }

  const messageDiv = document.createElement("div")
  messageDiv.className = tipo === "success" ? "success-message" : "error-message"
  messageDiv.textContent = mensaje

  const activeTab = document.querySelector(".tab-content.active")
  activeTab.insertBefore(messageDiv, activeTab.firstChild)

  setTimeout(() => {
    messageDiv.remove()
  }, 3000)
}

function showMessage(message) {
  const messageDiv = document.createElement("div")
  messageDiv.className = "success-message"
  messageDiv.textContent = message
  document.body.appendChild(messageDiv)

  setTimeout(() => {
    messageDiv.remove()
  }, 3000)
}

// Permitir búsqueda con Enter
document.getElementById("search-input").addEventListener("keypress", (e) => {
  if (e.key === "Enter") {
    buscarMascotas()
  }
})

// Filtrado automático al cambiar especie
speciesFilter.addEventListener("change", filterPets)

// Modificar el comportamiento del formulario para manejar edición
document.getElementById("form-mascota").addEventListener("submit", function (e) {
  if (this.dataset.editId) {
    e.preventDefault()

    const id = Number.parseInt(this.dataset.editId)
    const mascota = mascotas.find((m) => m.id === id)

    // Actualizar datos
    mascota.nombre = document.getElementById("nombre").value
    mascota.especie = document.getElementById("especie").value
    mascota.raza = document.getElementById("raza").value
    mascota.edad = Number.parseFloat(document.getElementById("edad").value)
    mascota.peso = Number.parseFloat(document.getElementById("peso").value)
    mascota.color = document.getElementById("color").value
    mascota.propietario = document.getElementById("propietario").value
    mascota.telefono = document.getElementById("telefono").value
    mascota.email = document.getElementById("email").value
    mascota.direccion = document.getElementById("direccion").value
    mascota.observaciones = document.getElementById("observaciones").value

    // Limpiar formulario y resetear modo edición
    this.reset()
    delete this.dataset.editId
    this.querySelector('button[type="submit"]').textContent = "Registrar Mascota"

    mostrarMensaje("success", "Mascota actualizada exitosamente")

    // Actualizar vista si estamos en lista
    if (document.getElementById("lista").classList.contains("active")) {
      mostrarTodasLasMascotas()
    }
  }
})

// Función para obtener icono de especie
function getSpeciesIcon(species) {
  return speciesIcons[species] || speciesIcons["otro"]
}

// Función para actualizar la lista de mascotas
function updatePetsList(petsToShow = pets) {
  if (petsToShow.length === 0) {
    petsList.innerHTML = '<div class="empty-state">No se encontraron mascotas.</div>'
    petCount.textContent = "0"
    return
  }

  petsList.innerHTML = petsToShow
    .map(
      (pet) => `
        <div class="pet-card">
            <div class="pet-header">
                <div class="pet-name">
                    <span class="species-icon">${getSpeciesIcon(pet.species)}</span>
                    ${pet.name}
                </div>
                <button class="btn-delete" onclick="deletePet(${pet.id})">Eliminar</button>
            </div>
            <div class="pet-info">
                <div class="info-item">
                    <span class="info-label">Especie:</span>
                    <span class="info-value">${pet.species.charAt(0).toUpperCase() + pet.species.slice(1)}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Raza:</span>
                    <span class="info-value">${pet.breed}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Edad:</span>
                    <span class="info-value">${pet.age} ${pet.age === 1 ? "año" : "años"}</span>
                </div>
            </div>
            <div class="owner-info">
                <h4>👤 Información del Propietario</h4>
                <div class="pet-info">
                    <div class="info-item">
                        <span class="info-label">Nombre:</span>
                        <span class="info-value">${pet.owner}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Teléfono:</span>
                        <span class="info-value">${pet.phone}</span>
                    </div>
                </div>
            </div>
        </div>
    `,
    )
    .join("")

  petCount.textContent = petsToShow.length
}

// Manejar envío del formulario
form.addEventListener("submit", (e) => {
  e.preventDefault()

  const name = document.getElementById("name").value.trim()
  const species = document.getElementById("species").value
  const breed = document.getElementById("breed").value.trim()
  const age = Number.parseInt(document.getElementById("age").value)
  const owner = document.getElementById("owner").value.trim()
  const phone = document.getElementById("phone").value.trim()

  // Validaciones
  if (!name || !species || !breed || !age || !owner || !phone) {
    alert("Por favor, complete todos los campos.")
    return
  }

  if (age < 0 || age > 30) {
    alert("Por favor, ingrese una edad válida (0-30 años).")
    return
  }

  // Verificar si la mascota ya existe
  if (
    pets.some((pet) => pet.name.toLowerCase() === name.toLowerCase() && pet.owner.toLowerCase() === owner.toLowerCase())
  ) {
    alert("Ya existe una mascota con este nombre y propietario.")
    return
  }

  // Agregar mascota
  const pet = {
    id: nextId++,
    name,
    species,
    breed,
    age,
    owner,
    phone,
  }
  pets.push(pet)

  // Actualizar lista y limpiar formulario
  updatePetsList()
  form.reset()

  // Mostrar mensaje de éxito
  showMessage("Mascota registrada exitosamente!")
})

// Inicializar la aplicación
document.addEventListener("DOMContentLoaded", () => {
  actualizarEstadisticas()
  mostrarTodasLasMascotas()
  updatePetsList()
})
