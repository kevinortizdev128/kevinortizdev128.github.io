// compra.js

// Ocultar formularios antiguos para evitar conflicto
document.querySelectorAll('.formulario-compra').forEach(f => f.style.display = 'none');

const modal = document.getElementById('modalCompra');
const nombreProductoSpan = document.getElementById('nombreProducto');
const precioProductoSpan = document.getElementById('precioProducto');
const imgProducto = document.getElementById('imgProducto');
const formCompra = document.getElementById('formCompra');
const btnCerrar = document.getElementById('btnCerrar');

let productoSeleccionado = null;

document.querySelectorAll('.btn-comprar').forEach(boton => {
  boton.addEventListener('click', () => {
    const producto = boton.closest('.producto');
    const nombre = producto.getAttribute('data-nombre');
    const precio = producto.getAttribute('data-precio');
    const imgSrc = producto.querySelector('img').src;
    const imgAlt = producto.querySelector('img').alt;

    productoSeleccionado = producto;

    nombreProductoSpan.textContent = nombre;
    precioProductoSpan.textContent = Number(precio).toLocaleString('es-CR');
    imgProducto.src = imgSrc;
    imgProducto.alt = imgAlt;

    formCompra.reset();
    formCompra.cantidad.value = 1;

    modal.style.display = 'block';
    document.body.style.overflow = 'hidden';  // Evitar scroll detrás del modal
    formCompra.cantidad.focus();
  });
});

btnCerrar.addEventListener('click', () => {
  modal.style.display = 'none';
  document.body.style.overflow = 'auto';
});

window.addEventListener('click', e => {
  if (e.target === modal) {
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
  }
});

window.addEventListener('keydown', e => {
  if(e.key === 'Escape' && modal.style.display === 'block'){
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
  }
});

formCompra.addEventListener('submit', e => {
  e.preventDefault();

  const cantidad = parseInt(formCompra.cantidad.value);
  if (cantidad < 1) {
    alert('La cantidad debe ser al menos 1.');
    formCompra.cantidad.focus();
    return;
  }

  alert(`Gracias por su compra, ${formCompra.nombreCliente.value}!\n\n` +
    `Producto: ${productoSeleccionado.getAttribute('data-nombre')}\n` +
    `Cantidad: ${cantidad}\n` +
    `Total a pagar: ₡${(productoSeleccionado.getAttribute('data-precio') * cantidad).toLocaleString('es-CR')}\n` +
    `Correo: ${formCompra.emailCliente.value}\n` +
    `Dirección: ${formCompra.direccionCliente.value}`);

  modal.style.display = 'none';
  document.body.style.overflow = 'auto';
});
