const mascotas = [
    {
        nombre: "Luna",
        especie: "Perro",
        raza: "Golden Retriever",
        edad: 5,
        dueno: "María Pérez",
        contacto: "555-1234"
    },
    {
        nombre: "Michi",
        especie: "Gato",
        raza: "Persa",
        edad: 3,
        dueno: "Carlos Díaz",
        contacto: "555-5678"
    },
    {
        nombre: "Kira",
        especie: "Conejo",
        raza: "Enano holandés",
        edad: 2,
        dueno: "Ana López",
        contacto: "555-9012"
    }
];

// Referencias al formulario y contenedor de tabla
const form = document.getElementById('formMascota');
const contenedorTabla = document.getElementById('tablaMascotas');

/**
 * Crea y muestra la tabla con los datos actuales del arreglo 'mascotas'
 */
function mostrarTablaMascotas() {
    contenedorTabla.innerHTML = ''; // Limpiar contenido anterior

    if (mascotas.length === 0) {
        contenedorTabla.textContent = 'No hay mascotas registradas aún.';
        return;
    }

    const tabla = document.createElement('table');

    const encabezados = ['Nombre', 'Especie', 'Raza', 'Edad', 'Nombre del Dueño', 'Número de Contacto'];
    const thead = document.createElement('thead');
    const trEncabezado = document.createElement('tr');
    
    encabezados.forEach(titulo => {
        const th = document.createElement('th');
        th.textContent = titulo;
        trEncabezado.appendChild(th);
    });
    thead.appendChild(trEncabezado);
    tabla.appendChild(thead);

    const tbody = document.createElement('tbody');

    mascotas.forEach(mascota => {
        const tr = document.createElement('tr');
        const datos = [
            mascota.nombre,
            mascota.especie,
            mascota.raza,
            mascota.edad + ' años',
            mascota.dueno,
            mascota.contacto
        ];
        datos.forEach(valor => {
            const td = document.createElement('td');
            td.textContent = valor;
            tr.appendChild(td);
        });
        tbody.appendChild(tr);
    });

    tabla.appendChild(tbody);
    contenedorTabla.appendChild(tabla);
}

/**
 * Manejador del formulario para agregar una nueva mascota
 * @param {Event} e 
 */
function agregarMascota(e) {
    e.preventDefault();

    const nuevaMascota = {
        nombre: document.getElementById('nombre').value.trim(),
        especie: document.getElementById('especie').value.trim(),
        raza: document.getElementById('raza').value.trim(),
        edad: parseInt(document.getElementById('edad').value),
        dueno: document.getElementById('dueno').value.trim(),
        contacto: document.getElementById('contacto').value.trim()
    };

    if (Object.values(nuevaMascota).includes('') || isNaN(nuevaMascota.edad)) {
        alert('Por favor, completa todos los campos correctamente.');
        return;
    }

    mascotas.push(nuevaMascota);
    form.reset();
    mostrarTablaMascotas();
}

// Escuchar evento del formulario
form.addEventListener('submit', agregarMascota);

// Mostrar tabla con mascotas pre-cargadas al inicio
document.addEventListener('DOMContentLoaded', mostrarTablaMascotas);
