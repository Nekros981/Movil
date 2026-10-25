# Herramientas

Campus Quest es una wiki del videojuego, hecha en Flutter. Esta página dice para qué está cada herramienta en este repositorio y qué todavía no hace.

El sistema visual (colores, tipografía, pantallas) está en [diseño.md](diseño.md). Los mockups están en `docs/mockups/`.

## Mapa

| Herramienta | Versión | Para qué está | Estado |
|---|---|---|---|
| Flutter / Dart | SDK `^3.13.5` | App, pantallas y tema | En uso |
| `supabase_flutter` | `^2.18.3` | Cliente del proyecto Supabase | Conectado al arrancar. El login aún no lo usa |
| Supabase CLI | local, carpeta `supabase/` | Vincular este repo al proyecto remoto | Vinculado. No hace falta levantar Docker |
| `shared_preferences` | `^2.5.6` | Usuarios y sesión en el teléfono | En uso. Se va a reemplazar |
| `google_fonts` | `^9.0.0` | Manrope y DM Sans | En uso |
| `audioplayers` | `^6.8.1` | Pistas musicales | Instalado. El reproductor aún no existe |
| `cupertino_icons` | `^1.0.8` | Iconos iOS de la plantilla Flutter | En el `pubspec`. La UI usa iconos de Material |
| `flutter_lints` | `^6.0.0` | Reglas del analizador | En uso |
| `flutter_test` | SDK | Pruebas de widgets | En uso |

## Flutter

Framework de la app. El código está en `lib/`.

```bash
flutter run
flutter analyze
flutter test
```

`flutter pub add <paquete>` agrega una dependencia y actualiza `pubspec.yaml` y `pubspec.lock`. Hay que commitear los dos.

## Supabase

Backend de cuentas: registro, inicio de sesión, recuperar contraseña, foto y nombre. La wiki y las pistas no van aquí; siguen en la app.

Hay dos piezas:

- **Proyecto en la nube.** La app habla con `https://khaxjerxneoluzoktrdc.supabase.co`. La conexión está en `lib/main.dart`, con la clave pública (`sb_publishable_`). Esa clave puede vivir en el cliente. La clave `sb_secret_` no se pone en la app ni en Git.
- **CLI.** `supabase init` y `supabase link` crearon `supabase/config.toml`. La carpeta `supabase/.temp/` guarda datos locales del vínculo y no se sube (está en `supabase/.gitignore`).

`supabase start` levanta Postgres y Auth en tu máquina con Docker. Este proyecto no lo usa.

Hoy `Supabase.initialize` corre al abrir la app, pero `lib/features/auth/auth_repository.dart` sigue guardando usuarios en el teléfono. El siguiente cambio es pasar ese repositorio a Supabase Auth.

## shared_preferences

Guarda datos simples en el dispositivo. Ahora mismo guarda el mapa de usuarios (`auth_users`) y, si el usuario marcó Recordarme, el nombre de la sesión (`auth_session`). Las contraseñas quedan en texto plano. Por eso este paquete sale cuando el acceso pase a Supabase.

## google_fonts

Descarga Manrope (títulos y botones) y DM Sans (texto y formularios). Los estilos están en `lib/core/theme/app_typography.dart`. La primera vez que se abre la app hace falta red. En pruebas se desactiva la descarga con `GoogleFonts.config.allowRuntimeFetching = false`.

## audioplayers

Va a reproducir las pistas desde archivos de la app (`assets/`), no desde Supabase. El paquete ya está en el `pubspec`. Todavía no hay pantalla ni reproductor.

## Análisis y pruebas

`analysis_options.yaml` activa `flutter_lints`. `flutter analyze` debe quedar sin avisos antes de un commit.

`test/widget_test.dart` abre la app sin pasar por `main.dart`, así que no inicializa Supabase. Usa `SharedPreferences` en memoria porque el login actual lee el almacenamiento al arrancar.
