# VITRA — Sitio web organizado por módulos

El sitio se dividió en 5 páginas independientes, todas enlazadas desde el mismo
menú de navegación (en este orden):

| #   | Módulo    | Archivo         | Contenido                                                               |
| --- | --------- | --------------- | ----------------------------------------------------------------------- |
| 1   | Inicio    | `inicio.html`   | Portada de bienvenida y presentación de lentes tecnológicos.            |
| 2   | Catálogo  | `catalogo.html` | Soluciones VITRA, lentes tecnológicos y prototipos a medida.            |
| 3   | Galería   | `galeria.html`  | Integrantes del equipo: foto, nombre, rol y biografía.                  |
| 4   | Acerca de | `acerca.html`   | Historia de VITRA, equipo y principios de diseño tecnológico.           |
| 5   | Registro  | `registro.html` | Formulario de reserva/registro con confirmación por correo (Formspree). |

## Carpetas

- `Assets/CSS/style.css` — estilos compartidos por todas las páginas (incluye
  al final un bloque nuevo para la sección **Galería**).
- `Assets/JS/script.js` — lógica compartida (menú móvil, resaltado del enlace
  activo, modales del catálogo, envío de formularios, etc.). Está escrito
  para funcionar en las 5 páginas sin generar errores aunque un elemento no
  exista en alguna de ellas.
- `Assets/Images` — recursos visuales de la marca y los lentes tecnológicos.

## Para completar la Galería

Abre `galeria.html` y busca el bloque `<ul class="team-grid">`. Cada
integrante es una tarjeta `<li class="team-card">` con:

```html
<h3 class="team-name">Nombre del Integrante</h3>
<p class="team-role">Rol / Carrera</p>
<p class="team-bio">Biografía...</p>
```

Duplica o edita esas tarjetas cuando tengas las biografías reales; también
puedes reemplazar el ícono de `ion-icon` por una foto real dentro de
`.team-photo` usando una etiqueta `<img>`.

## Pendientes / a personalizar

- Dirección, teléfono, correo y mapa (actualmente son datos de la plantilla
  original y deben reemplazarse por los reales).
- El formulario de `registro.html` usa un endpoint de Formspree de ejemplo;
  reemplázalo por el propio antes de publicar el sitio.
- El formulario de boletín en el pie de página usa una cuenta de Brevo de
  ejemplo; reemplázala si vas a usar esa función.
