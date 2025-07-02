const books = [];

// Referencia al formulario y tabla
const form = document.getElementById('bookForm');
const tableBody = document.querySelector('#booksTable tbody');

/**
 * Función para validar el año de publicación
 * @param {string} yearStr 
 * @returns {boolean}
 */
function validarAno(yearStr) {
    const year = Number(yearStr);
    // Validar que sea número entero positivo razonable
    return Number.isInteger(year) && year > 0 && year <= new Date().getFullYear();
}

/**
 * Función para agregar un libro al arreglo y actualizar la tabla
 * @param {Object} libro 
 */
function agregarLibro(libro) {
    books.push(libro);
    actualizarTabla();
}

/**
 * Función para limpiar el cuerpo de la tabla y llenarla con los datos de books
 */
function actualizarTabla() {
    // Limpiar tabla
    tableBody.innerHTML = '';

    // Crear filas
    books.forEach((libro) => {
        const row = document.createElement('tr');

        const tdTitle = document.createElement('td');
        tdTitle.textContent = libro.title;
        row.appendChild(tdTitle);

        const tdAuthor = document.createElement('td');
        tdAuthor.textContent = libro.author;
        row.appendChild(tdAuthor);

        const tdYear = document.createElement('td');
        tdYear.textContent = libro.year;
        row.appendChild(tdYear);

        tableBody.appendChild(row);
    });
}

/**
 * Manejador del envío del formulario
 * @param {Event} e 
 */
function manejarEnvioFormulario(e) {
    e.preventDefault();

    const title = form.title.value.trim();
    const author = form.author.value.trim();
    const year = form.year.value.trim();

    // Validaciones
    if (!title || !author || !year) {
        alert('Por favor, complete todos los campos.');
        return;
    }

    if (!validarAno(year)) {
        alert('Por favor, ingrese un año válido y numérico.');
        return;
    }

    // Crear objeto libro
    const libro = {
        title,
        author,
        year: Number(year)
    };

    // Agregar libro y actualizar tabla
    agregarLibro(libro);

    // Limpiar formulario
    form.reset();
}

// Evento de envío del formulario
form.addEventListener('submit', manejarEnvioFormulario);
