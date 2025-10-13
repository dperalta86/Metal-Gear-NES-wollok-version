import wollok.game.* // Es necesario importar wollok.game.* cuando defino una clase?

/*
 * Clase abstracta Guard, de ella heredan las clases de los distintos tipos de guardias
 */
class Guard {
    var property position
    var property direction = "down"
    var property state = "patrolling" // Por el momento no se va a utilizar...
    var property detectionRange = 3 // Idem
    var property isColisionable = false 

    method collidedForSnake() { console.println(self.toString() + " colisionado por Snake!")}
    method image() 
    
    // Método para inicializar posición
    method inicializarPosicion(_position) {
        position = _position
    }
    
    method update() {
        self.comportamiento()
        self.verificarDeteccion()
        self.actualizarEstado()
    }
    // Comportamiento polimórfico (Interfaz)
    method comportamiento() // Implementado en subclases    
    method verificarDeteccion() // Lógica para detectar al jugador    
    method actualizarEstado() // Lógica para actualizar el estado    

}