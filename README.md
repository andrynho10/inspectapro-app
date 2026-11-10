# InspectaPro – Demo · App Android de inspecciones

**App Android para operadores de grúas horquilla.** Reemplaza el checklist en papel: escaneas el QR de la grúa, completas la inspección con fotos de las fallas, registras el horómetro y el supervisor la ve al instante en el panel web. **Funciona sin internet.**

> **Desarrollado como práctica profesional; esta es una versión demo con datos ficticios.**
> Empresas, personas, grúas y fotos son inventados. La demo se reinicia automáticamente cada noche.

📱 **Descargar APK demo:** [Releases → InspectaPro-Demo.apk](https://github.com/andrynho10/inspectapro-app/releases/latest)
🖥️ **Panel web en vivo:** https://inspectapro-demo.vercel.app · código: [inspectapro-panel](https://github.com/andrynho10/inspectapro-panel)

| Rol | Usuario | Contraseña |
|---|---|---|
| Operador | `operador.demo@example.com` | `Demo1234!` |
| Supervisor | `supervisor.demo@example.com` | `Demo1234!` |

<!-- CAPTURAS_APP -->

---

## El problema

Antes de cada turno, el operador debe revisar frenos, fugas, neumáticos, luces y elementos de seguridad de su grúa. En papel esto significa:

- Hojas que se pierden, se llenan "de memoria" o nunca llegan al supervisor.
- Fallas críticas que se conocen tarde, cuando la grúa ya siguió operando.
- Horómetros mal anotados, sin control real de las horas de uso.
- Ninguna evidencia confiable de quién inspeccionó, cuándo y qué encontró.

## La solución

Una app pensada para el operador en terreno, a menudo en bodegas con mala señal:

1. **Escanea el QR** pegado en la grúa (ZXing), y la app carga el checklist correspondiente.
2. **Responde Bueno / Malo** por categoría (inspección visual, fluidos, hidráulico, frenos, seguridad, neumáticos). Si algo está malo, agrega **comentario y fotos**, que la app comprime antes de subir.
3. **Registra el horómetro** inicial, validado contra el último valor conocido, y lo cierra al terminar el turno.
4. **Envía.** Si no hay señal, el reporte queda guardado en el teléfono y se **sincroniza solo** al volver la conexión (WorkManager).
5. El supervisor lo ve **en tiempo real** en el panel web, con puntaje de cumplimiento y fallas destacadas.

## Funcionalidades

- **Offline-first:** catálogo de grúas y plantillas en caché (Room), borradores que no se pierden al cerrar la app, cola de reportes pendientes, indicador de red y sincronización automática (periódica y al recuperar conexión).
- **Roles:**
  - *Operador:* inspecciones, historial de cada grúa y cierre de horómetros pendientes.
  - *Supervisor:* panel con reportes recientes, gestión de grúas y editor de plantillas de checklist (categorías y preguntas).
- **Fotos de evidencia:** cámara integrada, compresión y corrección de orientación (EXIF), y visor con zoom.
- **Horómetro y turnos:** validación de lecturas, recordatorios locales de cierre pendiente y cálculo de horas de uso en el servidor.
- **Historial por grúa** con detalle de cada inspección.

## Stack

| | |
|---|---|
| Lenguaje / UI | Kotlin, Jetpack Compose, Material 3, Navigation Compose |
| Arquitectura | MVVM (ViewModel + StateFlow), repositorios online/offline |
| Persistencia local | Room (borradores, caché, cola de sincronización) |
| Segundo plano | WorkManager + monitor de conectividad |
| Backend | Supabase (supabase-kt): Auth, PostgREST, Storage |
| Otros | ZXing (QR), Coil (imágenes), kotlinx.serialization |

La base de datos (tablas, RLS, funciones y datos demo) está documentada en el repo del panel: [`supabase/migrations`](https://github.com/andrynho10/inspectapro-panel/tree/main/supabase/migrations).

## Qué es distinto en esta versión demo

| Sistema original | Demo |
|---|---|
| Notificaciones push a supervisores (Firebase Cloud Messaging) | **Deshabilitado.** El aviso se **simula** en el servidor (tabla `notificaciones_simuladas`), así la demo no depende de un proyecto Firebase. |
| Se podían eliminar grúas y plantillas | **Eliminar está deshabilitado** (`DEMO_MODE`), y el servidor también lo bloquea |
| Firma de la empresa | APK firmado con una **keystore nueva** creada solo para la demo |

## Probar la demo

1. Descarga el APK desde [Releases](https://github.com/andrynho10/inspectapro-app/releases/latest) en un teléfono Android 8.0 o superior.
2. Autoriza "instalar apps de origen desconocido" cuando Android lo pida.
3. Entra con el usuario **operador** y elige una grúa de la lista. El QR es opcional: las grúas demo usan los códigos `IP-GH-001` a `IP-GH-008`.
4. Prueba el modo **sin conexión**: activa el modo avión, completa una inspección, vuelve a conectarte y mira cómo aparece en el [panel web](https://inspectapro-demo.vercel.app).

## Compilar

Requiere Android Studio (JDK 17+). Crea un `local.properties` con los datos de tu proyecto Supabase:

```properties
supabase.url=https://TU-PROYECTO.supabase.co
supabase.anon_key=tu-clave-anon-publica
```

Para un APK *release* firmado, agrega un `keystore.properties` (`storeFile`, `storePassword`, `keyAlias`, `keyPassword`). Ninguno de esos dos archivos se sube al repositorio.

```bash
./gradlew assembleRelease
```

## Autor

**Andrés Amaya Garcés**, Ingeniero de Ejecución en Informática (Chile).
Diseñé y desarrollé el sistema completo (app Android, panel web y base de datos) de forma individual durante mi práctica profesional (2025). Esta versión demo no contiene datos, marcas ni credenciales de la empresa donde se realizó la práctica.
