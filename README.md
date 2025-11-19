UTN - Facultad Regional Buenos Aires - Materia Paradigmas de Programación  

![banner-image](assets/images/banner.jpeg)

# 🎮 Metal Gear NES - Wollok Implementation

## Equipo de desarrollo:

| Nombre y Apellido | Legajo | GitHub User | email |
|-------------------|--------|-------------|-------|
| Alejo Gómez | 2133775 | agomez9907 | alegomez@frba.utn.edu.ar |
| Romina Manzaneda | 1782540 | rmanzaneda1 | rmanzanedairusta@frba.utn.edu.ar |
| Daniel Peralta | 1193235 | dperalta86 | dperalta@frba.utn.edu.ar |
| Cristian Torchia | 1116459 | ctorchia | ctorchia@frba.utn.edu.ar |

---

## 📖 Introducción

**Metal Gear NES** es una implementación del clásico juego de sigilo desarrollado en **Wollok Game** como proyecto académico universitario. El juego recrea la experiencia original de infiltración donde el jugador controla a **Solid Snake**, un agente especial que debe rescatar a un rehén infiltrándose en una base militar dividida en múltiples áreas interconectadas.

### 🎯 Características Principales:

- **Sistema de Áreas Interconectadas**: Explora 5 áreas diferentes con transiciones fluidas
- **IA de Guardias**: Enemigos con comportamientos distintos (estáticos y patrulleros)
- **Sistema de Combate**: Armas con sistema de balas en ráfaga
- **Inventario Dinámico**: Recolecta y gestiona items estratégicamente
- **Sistema de Vida**: HUD visual con corazones que reflejan tu salud
- **Mecánicas de Stealth**: Caja de cartón con durabilidad para esconderte
- **Optimización Avanzada**: Object Pool Pattern para rendimiento (~50-100ms por cambio de área)

---

## 🎥 Video Explicativo

¿Querés ver el juego en acción y entender cómo funciona? Mirá nuestro video de presentación:

[![Metal Gear NES - Video Presentación](https://img.shields.io/badge/▶️_Ver_Video-YouTube-red?style=for-the-badge&logo=youtube)](https://www.youtube.com/watch?v=zIRBjMeFjro)

En el video explicamos:
- 🎮 Gameplay completo del nivel 1
- 🏗️ Arquitectura y patrones de diseño implementados
- 💡 Decisiones técnicas clave (Object Pool, Factory Pattern)
- 🎯 Conceptos de POO aplicados

---

## 🎮 Cómo Jugar

### 🎯 Objetivo Principal

Tu misión es **rescatar al rehén** que se encuentra cautivo en el área 05 de la base militar. Para lograrlo deberás:

1. Explorar las 5 áreas de la base militar
2. Encontrar la **llave roja** (imprescindible para ganar)
3. Evitar o enfrentar a los guardias enemigos
4. Llegar al área 05 y rescatar al rehén

### ⌨️ Controles

| Tecla | Acción |
|-------|--------|
| **↑ ↓ ← →** | Mover a Snake |
| **A** | Recoger item |
| **S** | Soltar item |
| **D** | Usar item equipado |
| **M** | Mostrar mapa del nivel (2.5 seg) |
| **H** | Mostrar ayuda (3 seg) |
| **P** | Pausar/Reanudar juego |
| **SPACE** | Iniciar juego / Reintentar |
| **Q** | Salir (solo en Game Over/Victoria) |

---

## 🗺️ Estructura del Nivel

El juego cuenta con **5 áreas interconectadas**:

### 📍 Área 01 - Zona de Inicio
- Punto de entrada a la base
- Guardias patrulleros
- Conexiones: Área 02 (arriba) y Área 03 (izquierda)

### 📍 Área 02 - Sector Norte
- Guardias estáticos estratégicamente ubicados
- **Arma** disponible para recolectar
- Conexiones: Área 01 (abajo) y Área 05 (arriba)

### 📍 Área 03 - Zona de Tanques
- Área con múltiples obstáculos
- **Caja de cartón** para esconderte
- Conexiones: Área 01 (derecha) y Área 04 (arriba)

### 📍 Área 04 - Sector de Almacenamiento
- **Llave Roja** (¡NECESARIA PARA GANAR!)
- **Health Kit** para recuperar vida
- Guardias patrulleros
- Conexiones: Área 03 (abajo)

### 📍 Área 05 - Celda del Rehén
- **Objetivo final**: Rescatar al rehén
- Área pequeña y cerrada
- Requiere haber explorado y sobrevivido a las áreas anteriores

---

## 🎖️ Enemigos

### 👮 Static Guard
- Permanece en una posición fija
- Realiza rotaciones periódicas cada 20 ticks
- Secuencia de rotación predefinida: abajo → izquierda → derecha → arriba

### 👮 Patrol Guard  
- Se mueve aleatoriamente por el mapa
- Mayor peso de movimiento horizontal
- Impredecible y peligroso en espacios abiertos

> **💡 Consejo**: Observa los patrones de movimiento antes de avanzar. La paciencia es tu mejor aliada.

---

## 🎒 Sistema de Items

### 🔑 Llaves
- **Llave Azul**: Abre puertas básicas
- **Llave Roja**: ¡ESENCIAL! Sin ella no puedes completar el juego

### 📦 Caja de Cartón
- Te permite esconderte de los guardias
- **Durabilidad**: 2 usos
- Reduce el daño recibido a la mitad mientras está activa
- Se destruye automáticamente cuando pierde toda su durabilidad

### 🔫 Arma
- Dispara **3 balas en ráfaga** con un solo uso
- Cada bala causa **50 de daño**
- Las balas viajan en línea recta en la dirección que miras
- Útil para eliminar guardias desde la distancia

### ❤️ Health Kit
- Restaura **100 puntos de vida** (vida completa)
- Recupera corazones perdidos en el HUD
- Se recoge automáticamente al colisionar

---

## ⚔️ Sistema de Combate y Daño

### 💔 Vida de Snake
- **Vida máxima**: 100 puntos
- **Sistema visual**: HUD con corazones
- Al llegar a 0 de vida → **Game Over**

### 🎯 Daño
- **Colisión con guardia**: 20 de daño
- **Impacto de bala**: 50 de daño
- **Con caja equipada**: Daño reducido a la mitad

### 🛡️ Estrategias de Supervivencia
1. Evita el combate directo cuando sea posible
2. Usa la caja para reducir daño en situaciones inevitables
3. Planifica tu ruta para minimizar encuentros
4. Busca Health Kits antes de enfrentamientos difíciles

---

## 🏆 Condiciones de Victoria y Derrota

### ✅ Victoria
Para ganar el juego debes:
1. ✓ Encontrar la **llave roja** (área 04)
2. ✓ Llegar al **área 05**
3. ✓ **Colisionar con el rehén** para rescatarlo

### ❌ Game Over
Pierdes el juego si:
- Tu vida llega a **0**
- Debes reiniciar desde el área 01

---

## 🏗️ Arquitectura y Diseño Técnico

### 🎨 Patrones de Diseño Implementados

#### Object Pool Pattern
- Todos los objetos del nivel se crean **una sola vez** al inicio
- Se activan/desactivan según el área actual
- **Mejora de rendimiento**: De ~10 segundos a 50-100ms por cambio de área

#### Factory Pattern
- `areaFactory` crea objetos desde matrices de tiles
- Mapeo declarativo entre caracteres y clases de objetos
- Facilita la creación y modificación de niveles

#### Singleton Pattern
- `solidSnake`: Personaje único controlado por el jugador
- `gameCurrentStatus`: Single Source of Truth del estado del juego
- `colissionHandler`, `objectPool`, `areaManager`: Gestores centralizados

### 🔧 Componentes Clave

#### Sistema de Áreas (`areaManager.wlk`, `level01.wlk`)
- Gestión de transiciones mediante eventos `AreaChange`
- Carga/descarga optimizada de áreas
- Control de guardias activos por área

#### Sistema de Colisiones (`colissions.wlk`)
- Registro centralizado de objetos colisionables
- Procesamiento de pickups y drops
- Pre-instanciación de colisiones para minimizar lag

#### Object Pool (`objectPool.wlk`)
- Dictionary de objetos organizados por área
- Métodos `activate()` / `deactivate()` para gestión eficiente
- Filtrado de guardias activos para actualización de IA

#### Game Status (`gameStatus.wlk`)
- Área actual y TileMap correspondiente
- Sistema de verificación de colisiones por matriz
- Gestión de niveles (preparado para expansión)

#### Sistema de Balas (`bullet.wlk`)
- Pool de 3 balas reutilizables por arma
- Trayectoria basada en dirección del disparo
- Auto-desactivación después de recorrido

---

## 📁 Estructura del Proyecto

```
src/
├── characters/           # Personajes del juego
│   ├── character.wlk    # Clase base Character
│   ├── snake/           # Solid Snake y su equipamiento
│   └── guards/          # Tipos de guardias (Static, Patrol)
├── gameObject/          # Clase base GameObject
├── items/               # Items del juego
│   ├── pickables.wlk    # Llaves, caja, arma, health
│   ├── bullet.wlk       # Sistema de balas
│   └── hostage.wlk      # Rehén (objetivo)
├── levels/              # Niveles y áreas
│   ├── level01.wlk      # 5 áreas del nivel 1
│   ├── tilemap.wlk      # Matrices de tiles
│   ├── factory.wlk      # Factory de objetos
│   └── areaManager.wlk  # Gestión de áreas
├── system/              # Sistemas del juego
│   ├── objectPool.wlk       # Pool de objetos
│   ├── colissions.wlk       # Gestor de colisiones
│   ├── gameStatus.wlk       # Estado global
│   ├── levelsManager.wlk    # Carga de niveles
│   ├── soundManager.wlk     # Audio
│   └── initialConfig.wlk    # Configuración inicial
├── inputManager/        # Control de inputs
│   ├── inputManager.wlk     # Teclado
│   └── movements.wlk        # Movimientos
├── ui/                  # Interfaz de usuario
│   ├── hud.wlk         # Sistema de corazones
│   └── visual.wlk      # Pantallas y mensajes
├── utils/              # Utilidades
│   ├── utils.wlk       # Funciones auxiliares
│   └── log.wlk         # Sistema de logging
└── gameManager.wlk     # Controlador principal del juego
```

---

## 🎓 Conceptos de Programación Aplicados

### Paradigma de Objetos
- **Herencia**: `Character` → `Snake`, `Guard`; `GameObject` → `Pickable`, `Bullet`
- **Polimorfismo**: Método `move()` implementado diferente en cada tipo de guardia
- **Encapsulamiento**: Cada clase maneja su propio estado y comportamiento
- **Composición**: Snake tiene `equipment`, `equipment` tiene lista de items

### Patrones de Diseño
- **Object Pool**: Reutilización de objetos para optimización
- **Factory**: Creación de objetos desde configuración
- **Singleton**: Objetos únicos y globales (Snake, managers)
- **Observer**: Sistema de colisiones con `onCollideDo`

### Buenas Prácticas
- Separación de responsabilidades (SRP)
- Código modular y reutilizable
- Comentarios descriptivos en español
- Logging para debugging
- Gestión eficiente de memoria

---

## 📚 Documentación Adicional

- **Documentación completa del proyecto**: [docs/project.md](docs/project.md)
- **Bitácora del desarrollo**: [docs/bitacora.md](docs/bitacora.md)
- **Diagrama UML actualizado** (17/10/25): [docs/uml/actual.png](docs/uml/actual.png)
- **Documentación oficial de Wollok**: [www.wollok.org](https://www.wollok.org/)

---

## 🎵 Créditos de Audio

**Música de fondo**:
- *Chiptune One* por CarlosCarty
- Fuente: [FreeSound.org](https://freesound.org/s/427513/)
- Licencia: Attribution 4.0

---

## 📝 Notas del Proyecto

> ⚠️ **Este es un proyecto académico aprobado**  
> El repositorio está en modo archivo. No se aceptan contribuciones externas.

### Estado del Proyecto
- ✅ Proyecto aprobado
- ✅ Nivel 1 completo (5 áreas)
- ⏳ Sistema preparado para expansión a múltiples niveles
- ⏳ Base lista para agregar más tipos de guardias y enemigos

---

## 🚀 Instalación y Ejecución

### Requisitos
- Wollok IDE instalado
- Java 11 o superior

### Pasos
1. Clonar el repositorio
2. Abrir el proyecto en Wollok IDE o VS Code
3. Ejecutar el archivo principal `main.wpgm`
4. ¡Disfrutar del juego!

---

**Desarrollado con ❤️ para Paradigmas de Programación - UTN FRBA**

*Versión del proyecto: 1.0 (Post-entrega optimizada)*