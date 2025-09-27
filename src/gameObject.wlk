// Estructura base para todos los objetos del juego (No incluye personajes)
class GameObject {
    var property position
    
    method image() // Abstract - implementar en subclases
    method update() { } // TODO: Implementar
    method esColisionable() = false
}