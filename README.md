# MELOBOXD 

Meloboxd es una aplicación móvil desarrollada en **Flutter** que centraliza reseñas musicales en un solo espacio.  
Su propósito es ofrecer una plataforma moderna e intuitiva donde los usuarios puedan descubrir música, escribir reseñas, calificarlas con estrellas y organizarlas en listas personalizadas llamadas **Cajitas**.

---

## Funciones principales
1. Inicio de sesión y registro de usuarios.  
2. Búsqueda de canciones, álbumes y artistas.  
3. Creación de reseñas con sistema de estrellas (1 a 5).  
4. Filtrado de reseñas por fecha o valoración.  
5. Apartado de favoritos para guardar reseñas destacadas.  
6. Organización de reseñas en **Cajitas** personalizadas.  
7. Pantalla de perfil con ajustes (modo oscuro, cerrar sesión, etc.).  
8. Interfaz intuitiva y moderna.  
9. Manejo de estado con **Provider**.  

---

## Estructura del proyecto
```bash
lib/
├── models/        # Modelos de datos
├── providers/     # Manejo de estado
├── screens/       # Pantallas principales
├── services/      # Servicios y lógica
├── theme/         # Configuración de estilos y temas
├── utils/         # Utilidades y constantes
├── widgets/       # Widgets reutilizables
└── main.dart      # Punto de entrada de la app
```


##Instalación
Todos los comandos se ejecutan en la terminal (ya sea la de tu dispositivo o la integrada en Visual Studio Code).

1. Clonar el repositorio
   ```bash
   git clone https://github.com/usuario/meloboxd.git
   
2.Entrar a la carpeta del proyecto
```bash
cd meloboxd
```
3. Instalar dependencias
 ```bash
   flutter pub get
```
4.Ejecutar la aplicacion
```bash
flutter run
```
## Uso de la aplicación
Iniciar sesión o crear cuenta.

Acceder al menú principal.

Explorar reseñas musicales y usar el buscador para encontrar canciones o artistas.

Crear una reseña y calificarla con estrellas.

Guardar reseñas favoritas en el apartado de Favoritos.

Organizar reseñas en Cajitas personalizadas.

Ajustar opciones desde el perfil (modo oscuro, cerrar sesión, etc.).

## Solución de problemas comunes
Error al iniciar la app: Verifica que tengas instalada la versión correcta de Flutter.

No carga contenido: Revisa tu conexión a Internet.

Problemas con el login: Asegúrate de que tu correo esté registrado y la contraseña sea correcta.

Pantallas en blanco: Ejecuta flutter clean y luego flutter pub get.

### Autores
Miguel Sánchez Azua

Juliana Kali Molar Molar
