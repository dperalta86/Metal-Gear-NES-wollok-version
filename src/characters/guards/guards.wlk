import wollok.game.* // Es necesario importar wollok.game.* cuando defino una clase?

class Guard {
    var property position
    var property direction = "down"
    var property state = "patrolling" // otro posible estado: "alert"
    var property detectionRange = 3

    // Método para inicializar posición
    method inicializarPosicion(_position) {
        position = _position
    }
    
    // Comportamiento polimórfico
    method comportamiento() {
        // Implementado en subclases
    }
    
    method verificarDeteccion() {
        // Lógica para detectar al jugador
    }
    
    method actualizarEstado() {
        // Lógica para actualizar el estado
    }
    
    method update() {
        self.comportamiento()
        self.verificarDeteccion()
        self.actualizarEstado()
    }
}