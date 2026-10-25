# Arquitectura

Campus Quest es una app Flutter de una sola pantalla raíz. No usa un gestor de estado aparte: la sesión vive en Supabase y la barra inferior guarda su pestaña en el `State` del shell.

Las herramientas están en [herramientas.md](herramientas.md). Los colores y la tipografía están en [diseño.md](diseño.md).

## Capas

```text
main.dart          arranca Flutter y Supabase
app.dart           MaterialApp y el tema
core/              tokens y widgets que no conocen una pantalla
features/          pantallas por función
```

`core/` no importa `features/`. Una pantalla puede usar el tema y los widgets compartidos. El acceso no importa el archivo ni las pistas.

| Carpeta | Responsabilidad |
|---|---|
| `lib/core/theme/` | Colores, tipografía, espaciado, radios, sombras y `ThemeData` |
| `lib/core/widgets/` | Botón primario, campo, banner y tarjeta de sección |
| `lib/features/auth/` | Login, registro, recuperación y `AuthRepository` |
| `lib/features/shell/` | Barra inferior y el cambio de pestaña |
| `lib/features/home/` | Pestaña Inicio |
| `lib/features/archive/` | Pestaña Archivo y la pantalla de una sección |
| `lib/features/tracks/` | Pestaña Pistas |
| `lib/features/profile/` | Pestaña Perfil |

## Arranque

`main` inicializa Supabase y crea un `AuthRepository` con `Supabase.instance.client`. Ese objeto se pasa a `CampusQuestApp` y de ahí a `AuthGate`.

```text
sin sesión     Login
               ├─ Registro
               └─ Recuperar contraseña
con sesión     AppShell
               ├─ Inicio
               ├─ Archivo → pantalla de sección
               ├─ Pistas
               └─ Perfil
```

`AuthGate` lee `currentSession()`. Si hay correo, abre el shell. Si no, abre el login. Login y registro, cuando salen bien, reemplazan la pila con `AppShell` para que atrás no vuelva al formulario. Cerrar sesión en Perfil hace lo mismo hacia el login.

Las pantallas de acceso no llevan barra inferior. La barra solo existe dentro de `AppShell`.

## Auth

`AuthRepository` es el único sitio que llama a Supabase Auth: `signUp`, `signInWithPassword`, `resetPasswordForEmail` y `signOut`. Las pantallas no importan `supabase_flutter`.

El repositorio devuelve un `String?`: `null` si salió bien, o el mensaje que se muestra bajo el campo. No lanza la excepción de Supabase hacia la interfaz.

La sesión la restaura el SDK al arrancar. La app no guarda contraseñas.

## Shell

`AppShell` tiene un `IndexedStack` con cuatro pestañas. Cambiar de pestaña no destruye la anterior. Las tarjetas de Inicio solo cambian el índice a Archivo. Las tarjetas de Archivo hacen `Navigator.push` a `SectionScreen`, encima de la barra, con flecha de regreso.

Las tres secciones (Historia, Personajes, Storyboard) están descritas en `wiki_sections.dart`. Esa lista es la fuente de las tarjetas y de la pantalla de sección. Todavía no lee `assets/data/wiki_entries.json`.

## Qué queda fuera

- El contenido de la wiki sigue vacío. `SectionScreen` muestra un espacio de preparación.
- Pistas muestra filas, pero el icono de play no llama a `audioplayers`.
- Perfil muestra el correo y cierra sesión. La foto y el nombre todavía no tienen tabla ni bucket en Supabase.

Esas tres piezas se agregan encima de este esquema. No hace falta otro patrón de estado para conectarlas.
