Especificación de diseño

Campus Quest: Edición UTN

Esta guía define el sistema visual que debe utilizarse para desarrollar la aplicación. La identidad está basada en el logo oficial: verdes académicos, tonos naturales y superficies marfil.

1. Esquema general de diseño

La aplicación utiliza un sistema visual de estilo:

    Académico.

    Institucional.

    Profesional.

    Inspirado en exploración y videojuegos.

    Cálido, evitando el blanco y negro puros.

    Basado en capas y diferentes profundidades de verde.

Principio visual

La interfaz debe sentirse como un conjunto de piezas relacionadas:

    El verde bosque construye la identidad.

    El verde lima comunica descubrimiento y progreso.

    Los verdes medios distinguen categorías.

    El marfil aporta claridad y elegancia.

    Las sombras verdes generan profundidad.

    Las formas redondeadas conectan la interfaz con la forma del escudo.

No se deben introducir colores azules, violetas, naranjas o rojos decorativos que rompan la identidad del logo.

2. Paleta de colores

2.1 Colores primarios

Verde bosque principal

--color-primary: #133e2b;

Es el color principal de marca.

Usos

    Fondo superior del inicio de sesión.

    Fondo del banner principal.

    Botón primario.

    Encabezados oscuros.

    Elementos activos.

    Superficies de alta jerarquía.

    Fondos donde aparezcan textos blancos o verde lima.

No utilizar en

    Párrafos extensos sobre fondos claros.

    Todos los fondos de la aplicación.

    Contenedores secundarios pequeños.

Verde bosque profundo

--color-primary-dark: #08291b;

Es la versión más oscura del color principal.

Usos

    Estado hover del botón primario.

    Sombras profundas.

    Degradados.

    Fondos oscuros secundarios.

    Elementos decorativos dentro de superficies verdes.

    Contraste interno del header o banner.

Ejemplo

.button-primary:hover {

  background: #08291b;

}

Verde lima institucional

--color-accent: #a7cb62;

Es el principal color de acento. Proviene de las hojas y detalles claros del logo.

Usos

    Etiquetas sobre fondos verdes.

    Estados destacados.

    Progreso.

    Elementos importantes del videojuego.

    Indicadores de exploración.

    Detalles decorativos.

    Elementos activos sobre superficies oscuras.

Regla

Debe utilizarse en áreas pequeñas. No debe convertirse en el fondo predominante de una pantalla.

2.2 Colores secundarios

Verde académico

--color-secondary: #527e42;

Usos

    Etiquetas de sección.

    Enlaces secundarios.

    Iconos.

    Números de contenido.

    Sección Historia.

    Acciones secundarias.

    Textos destacados sobre fondos claros.

Debe utilizarse como apoyo del verde principal, no como sustituto.

Verde salvia

--color-sage: #72a45b;

Usos

    Avatar.

    Sección Personajes.

    Estados de foco.

    Indicadores positivos.

    Elementos relacionados con comunidad, aliados o personajes.

Verde tinta

--color-text-primary: #143b29;

Es el color principal para texto sobre superficies claras.

Usos

    Títulos.

    Encabezados.

    Iconos principales.

    Nombres de secciones.

    Texto de botones claros.

    Información de alta jerarquía.

Se utiliza en lugar de negro puro.

2.3 Colores terciarios y superficies

Fondo general

--color-background: #eef3e4;

Usos

    Fondo principal de todas las pantallas internas.

    Fondo del área de navegación.

    Fondo general detrás de tarjetas.

Este color debe ocupar la mayor superficie de la aplicación.

Superficie marfil

--color-surface: #fbfaed;

Usos

    Tarjetas.

    Formulario de acceso.

    Paneles.

    Contenedores de contenido.

    Elementos elevados.

    Listados.

Debe utilizarse para separar contenido del fondo general sin recurrir al blanco puro.

Blanco

--color-white: #ffffff;

Usos

    Texto sobre verde oscuro.

    Campos de formulario.

    Botones secundarios.

    Elementos que requieran máximo contraste.

Su uso debe ser limitado para conservar la calidez visual.

Texto secundario

--color-text-secondary: #607063;

Usos

    Párrafos.

    Descripciones.

    Ayudas.

    Subtítulos.

    Texto de campos.

    Información menos importante.

No debe utilizarse para títulos o botones principales.

Borde neutro

--color-border: #d1dac6;

Usos

    Campos de formulario.

    Separadores.

    Contornos de tarjetas.

    Divisiones internas.

    Bordes de superficies claras.

Fondo para imágenes pendientes

--color-placeholder: #dfe8d5;

Usos

    Espacios donde posteriormente se colocará una imagen.

    Miniaturas del storyboard.

    Ilustraciones pendientes.

    Contenedores visuales de prueba.

Estos espacios deben llevar borde discontinuo y una etiqueta como:

Aquí va una imagen de la escena

2.4 Colores de apoyo por categoría

Verde académico suave

--color-secondary-soft: #dceacf;

Uso: fondo del icono de Historia.

Verde salvia suave

--color-sage-soft: #dcebd1;

Uso:

    Fondo del icono de Personajes.

    Anillo de foco de los campos.

    Estados positivos suaves.

Verde lima suave

--color-accent-soft: #e7f0cd;

Uso: fondo del icono de Storyboard.

2.5 Color de error

--color-error: #a33a30;

Usos exclusivos

    Mensajes de validación.

    Campos con error.

    Alertas.

    Acciones destructivas.

No debe usarse como color decorativo.

3. Tokens recomendados

:root {

  /* Brand */

  --color-primary: #133e2b;

  --color-primary-dark: #08291b;

  --color-accent: #a7cb62;

  /* Secondary */

  --color-secondary: #527e42;

  --color-sage: #72a45b;

  /* Soft accents */

  --color-secondary-soft: #dceacf;

  --color-sage-soft: #dcebd1;

  --color-accent-soft: #e7f0cd;

  /* Surfaces */

  --color-background: #eef3e4;

  --color-surface: #fbfaed;

  --color-white: #ffffff;

  --color-placeholder: #dfe8d5;

  /* Content */

  --color-text-primary: #143b29;

  --color-text-secondary: #607063;

  --color-border: #d1dac6;

  /* Semantic */

  --color-error: #a33a30;

  /* Typography */

  --font-heading: "Manrope", sans-serif;

  --font-body: "DM Sans", sans-serif;

  /* Elevation */

  --shadow-large: 0 24px 70px rgba(8, 41, 27, 0.18);

  --shadow-medium: 0 10px 28px rgba(8, 41, 27, 0.1);

  --shadow-button: 0 10px 24px rgba(19, 62, 43, 0.2);

}

4. Tipografía

La aplicación utiliza dos familias tipográficas.

4.1 Manrope

font-family: "Manrope", sans-serif;

Función

Manrope se utiliza para construir jerarquía e identidad.

Usos

    Títulos de pantalla.

    Nombre de la aplicación.

    Títulos de secciones.

    Títulos de tarjetas.

    Botones principales.

    Números decorativos.

    Encabezados de contenido.

Pesos

600 — títulos secundarios

700 — títulos de tarjetas y botones

800 — títulos principales y marca

Configuración recomendada

Elemento	Tamaño	Peso	Interlineado

Título de pantalla	32–34 px	800	100–110%

Título de acceso	26–28 px	800	115%

Título de banner	22–24 px	800	113%

Título de sección	20 px	700	120%

Título de tarjeta	15–16 px	700	125%

Marca del header	15 px	800	110%

Botón principal	13–14 px	700	100%

Número decorativo	36–40 px	800	100%

Espaciado

Los títulos pueden utilizar:

letter-spacing: -0.03em;

No aplicar espaciado negativo en textos pequeños.

4.2 DM Sans

font-family: "DM Sans", sans-serif;

Función

DM Sans se utiliza para lectura, formularios e información auxiliar.

Usos

    Párrafos.

    Descripciones.

    Campos de formulario.

    Etiquetas.

    Mensajes de validación.

    Texto secundario.

    Información auxiliar.

Pesos

400 — párrafos

500 — texto auxiliar

600 — mensajes y estados

700 — etiquetas

Configuración recomendada

Elemento	Tamaño	Peso	Interlineado

Párrafo introductorio	13–14 px	400	155–165%

Texto de campo	13–14 px	400	140%

Etiqueta de campo	12 px	700	140%

Descripción de tarjeta	11–12 px	400	145–155%

Texto auxiliar	11–12 px	500	140%

Mensaje de error	11–12 px	600	140%

Etiqueta superior	10–11 px	700–800	120%

En producción se recomienda no utilizar textos funcionales menores a 11 px.

5. Asignación de color por componente

5.1 Fondo de aplicación

Fondo: #EEF3E4

Texto principal: #143B29

Texto secundario: #607063

5.2 Header

Fondo: #EEF3E4 con transparencia

Título: #143B29

Subtítulo: #527E42

Borde inferior: verde tinta con 8% de opacidad

Logo: imagen oficial

Avatar: #72A45B

Texto del avatar: #FFFFFF

El header debe permanecer fijo durante el desplazamiento.

5.3 Pantalla de acceso

Área superior

Fondo principal: #133E2B

Degradado: #A7CB62 con baja opacidad

Texto auxiliar: blanco al 65%

Logo: imagen oficial

Borde del logo: blanco al 22%

Panel del formulario

Fondo: #FBFAED

Título: #143B29

Descripción: #607063

5.4 Campos de formulario

Estado normal

Fondo: #FFFFFF

Borde: #D1DAC6

Texto: #143B29

Placeholder: #849084

Icono: #607063

Estado de foco

Borde: #72A45B

Anillo exterior: #DCEBD1

Estado de error

Borde: #A33A30

Texto de error: #A33A30

Estado deshabilitado

Fondo: #EEF3E4

Texto: #607063

Opacidad: 60%

5.5 Botón primario

Estado normal

Fondo: #133E2B

Texto: #FFFFFF

Icono: #FFFFFF

Sombra: rgba(19, 62, 43, 0.20)

Hover

Fondo: #08291B

Presionado

Fondo: #08291B

Escala: 0.98

Sombra reducida

Foco

Anillo: #A7CB62

Separación externa: 2–3 px

Deshabilitado

Fondo: #607063

Texto: #FFFFFF

Opacidad: 55%

5.6 Botón secundario

Fondo: #FBFAED

Texto: #143B29

Borde: #D1DAC6

Icono: #527E42

Hover

Fondo: #E7F0CD

Borde: #A7CB62

5.7 Enlaces y botones de texto

Color normal: #527E42

Hover: #133E2B

Foco: anillo #A7CB62

No usar verde lima para texto pequeño sobre fondos claros porque puede perder contraste.

5.8 Banner principal

Fondo: #133E2B

Título: #FFFFFF

Descripción: blanco al 64%

Etiqueta superior: #A7CB62

Decoración: #A7CB62 al 9%

El espacio para imagen puede utilizar:

Fondo: blanco al 4%

Borde: blanco al 45%

Texto: blanco al 55%

5.9 Tarjetas de navegación

Base

Fondo: #FBFAED

Título: #143B29

Descripción: #607063

Borde: #143B29 al 8%

Sombra: verde profundo al 5%

Hover

    Elevación de 2 px.

    Aumento de sombra.

    Movimiento ligero de la flecha hacia la derecha.

    El fondo permanece marfil.

Número decorativo

Color: #143B29 al 6%

Tipografía: Manrope 800

Flecha

Fondo: #EEF3E4

Color: #143B29

6. Color por categoría

Historia

Color principal: #527E42

Fondo del icono: #DCEACF

Icono: libro

Personajes

Color principal: #72A45B

Fondo del icono: #DCEBD1

Icono: grupo de personas

Storyboard

Color principal: #4D7339

Fondo del icono: #E7F0CD

Icono: panel dividido

Los colores de categoría solo deben aparecer en:

    Iconos.

    Etiquetas.

    Indicadores.

    Detalles pequeños.

Las tarjetas deben conservar el fondo marfil.

7. Tarjetas de contenido

Fondo: #FBFAED

Borde: #143B29 al 8%

Título: #143B29

Descripción: #607063

Índice: #527E42

Tipografía

Título: Manrope, 15–16 px, 700

Descripción: DM Sans, 11–13 px, 400

Índice: Manrope, 11–12 px, 800

8. Espacios para imágenes

Mientras no existan imágenes definitivas:

Fondo: #DFE8D5

Borde: #607063 discontinuo

Texto: #607063

Etiqueta

DM Sans

11 px

700

Mayúsculas

Espaciado entre letras: 0.04em

Cuando se agreguen las imágenes reales:

    Eliminar borde discontinuo.

    Eliminar texto indicativo.

    Mantener el radio del contenedor.

    Usar object-fit: cover.

    Agregar texto alternativo.

    Añadir una capa verde oscura si aparece texto sobre la imagen.

9. Formas y radios

El sistema utiliza bordes redondeados y algunas esquinas asimétricas.

Componente	Radio recomendado

Contenedor del logo	24 px, con una esquina de 8 px

Banner principal	25 px, con una esquina de 8 px

Imagen principal	22 px

Tarjeta de navegación	19 px

Tarjeta de contenido	18 px

Icono de categoría	15 px

Botón primario	14 px

Campo de formulario	13 px

Botón pequeño	12 px

Avatar	50%

La esquina asimétrica debe utilizarse en componentes de marca, no en todos los elementos.

10. Espaciado

La aplicación utiliza una cuadrícula base de 4 px.

Escala

4 px   — separación mínima

8 px   — etiqueta y título

12 px  — elementos relacionados

16 px  — interior de tarjetas

20 px  — bloques de contenido

24 px  — banners y componentes destacados

28 px  — márgenes laterales del acceso

32 px  — separación de secciones

40 px  — bloques principales

Márgenes móviles

Pantallas generales: 18 px

Pantalla de acceso: 28 px

11. Sombras

Elemento principal

box-shadow: 0 24px 70px rgba(8, 41, 27, 0.18);

Usar en:

    Marco móvil.

    Elementos principales flotantes.

Tarjetas elevadas

box-shadow: 0 10px 28px rgba(8, 41, 27, 0.1);

Usar en:

    Tarjetas activas.

    Botones de navegación.

    Menús flotantes.

Botón principal

box-shadow: 0 10px 24px rgba(19, 62, 43, 0.2);

Las sombras siempre deben tener matiz verde, no negro puro.

12. Iconografía

Estilo

    Iconos lineales.

    Sin relleno.

    Extremos redondeados.

    Trazo aproximado de 1.8 px.

    Tamaño normal entre 19 y 24 px.

    Una sola biblioteca o familia de iconos.

Colores

    Iconos principales: #143B29.

    Iconos secundarios: #607063.

    Iconos sobre fondos oscuros: #FFFFFF.

    Iconos activos sobre fondos oscuros: #A7CB62.

    Iconos de categoría: color correspondiente a su sección.

13. Logo

Uso principal

El logo completo debe utilizarse en:

    Inicio de sesión.

    Pantalla de bienvenida.

    Créditos.

    Acerca del juego.

Uso en header

En espacios pequeños puede utilizarse dentro de un contenedor cuadrado con recorte controlado.

Reglas

    No cambiar sus colores.

    No agregar filtros.

    No estirar.

    No inclinar.

    No colocar sobre fondos con poco contraste.

    Mantener espacio libre a su alrededor.

    No cubrir el texto del logo con otros elementos.

14. Estructura de pantallas

Inicio de sesión

    Fondo verde bosque.

    Etiqueta institucional.

    Logo.

    Panel marfil.

    Título.

    Descripción.

    Formulario.

    Acciones secundarias.

    Botón principal.

Inicio

    Header fijo.

    Banner principal.

    Etiqueta de sección.

    Título “¿Qué quieres explorar?”.

    Lista de tarjetas:

        Historia.

        Personajes.

        Storyboard.

Pantallas de detalle

    Header con regreso.

    Etiqueta superior.

    Título.

    Introducción.

    Imagen principal.

    Tarjetas o capítulos.

    Desplazamiento vertical.

Todas las pantallas internas deben compartir esta estructura para mantener consistencia.

15. Accesibilidad

    Área táctil mínima: 44 × 44 px.

    Texto normal con contraste mínimo 4.5:1.

    Foco visible en todos los controles.

    No comunicar estados únicamente mediante color.

    Texto funcional mínimo recomendado: 12 px.

    Etiquetas visibles en los campos.

    Mensajes de error debajo del campo correspondiente.

    Texto alternativo en imágenes.

    Compatibilidad con prefers-reduced-motion.

    Botones completos pulsables, no solo sus iconos.

16. Resumen de implementación

Tipografía

Manrope: títulos, botones, números y marca.

DM Sans: contenido, formularios y descripciones.

Jerarquía cromática

Verde bosque: identidad y acciones principales.

Verde lima: descubrimiento y elementos destacados.

Verdes medios: categorías y acciones secundarias.

Marfil: tarjetas y superficies.

Verde crema: fondo general.

Verde tinta: títulos y texto principal.

Gris verdoso: texto secundario.

Rojo: únicamente errores.

Regla principal

La interfaz debe sentirse como una extensión del escudo: sólida, académica y profesional. Cada color debe cumplir una función específica; los verdes no se usan de manera aleatoria, sino para establecer jerarquía, categoría, estado y profundidad.