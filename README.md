# Flutter Native Resource App

Este repositorio contiene una aplicación Flutter que hace uso de diversos recursos nativos de dispositivos móviles (iOS y Android), incluyendo sensores, permisos, mapas, notificaciones y más.  

## Instalación

Sigue estos pasos para clonar y ejecutar la aplicación:

1. **Clonar el repositorio:**

```bash
git clone https://github.com/trejoscr/flutter-native-resource-app.git
cd flutter-native-resource-app
```

2. **Instalar dependencias de Flutter:**

```bash
flutter pub get
```

3. **Ejecutar la app en un dispositivo o emulador:**

```bash
flutter run
```

> Nota: Asegúrate de tener configurado correctamente tu entorno de Flutter para Android o iOS según la documentación oficial: [Flutter Setup](https://docs.flutter.dev/get-started/install)

4. **Permisos y configuraciones adicionales:**

- Algunos permisos requieren configuraciones en Android (`AndroidManifest.xml`) y en iOS (`Info.plist`).  
- Configura bundle ID y App ID según sea necesario.

---

## Temas Abordados

### Estado de la Aplicación
- Resumed
- Paused
- Detached
- Inactive
- Reaccionar basado en el estado de la app

### Manejo de Permisos
- Cámara
- Localización
- Body Sensors
- Galería
- Otros permisos requeridos
- Riverpod y centralización de permisos

### Sensores y Movimiento
- Bloqueo de orientación del teléfono
- Giroscopio
- Acelerómetro
- Magnetómetro
- Providers y Streams
- Mover Widget basado en el giroscopio
- Brújula y animaciones

### Navegación
- Rutas con argumentos

### Conexión y Datos
- Peticiones HTTP
- Domain Driven Design (DDD)
- FutureProviders
- Share Plus
- Configuraciones iOS y Android
- DeepLinking y despliegue de sitio web (Railway)
- Ejemplos de sitios web (Facebook)
- Patrón adaptador alrededor de un paquete
- Diversos proveedores de Riverpod (opcional pero recomendado)

### Autenticación y Biometrics
- FadeID
- Fingerprint reader
- Probar en Android e iOS

### Mapas y Ubicación
- Mapas
- Ubicación de usuario
- Controladores del mapa
- Marcadores
- Eventos
- InfoWindow
- Seguimiento de ubicación
- Streams

### Atajos y Notificaciones
- QuickActions (Android - QuickActions Shortcuts)
- App Notification Numbers (Android e iOS)
- Workmanager
- Configuraciones y restricciones

### Base de Datos Local
- Isar
- Repositorios y Datasources para base de datos
- Schemas
- Inserción y lectura de base de datos
- Shared Preferences
- Dispatchers
