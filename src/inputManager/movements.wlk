import src.characters.snake.solidSnake
import wollok.game.*

/*
 * Definición base para todos los movimientos de todos los personajes.
 * idea: Tener un objeto movement que defina la dirección y la distancia
 *      recibe un character y lo mueve en la dirección indicada.
 *      Verifica colisiones con paredes y otros personajes
 *      actualiza la posición del character.
 *      Puede tener efectos de sonido asociados (pasos, etc).
 *      Verificar si el movimiento genera un cambio de área
*/
object movement {
    method moveUp(character) {
        character.lastMovement("up")
        character.moveTo(character.position().up(1))
    }

    method moveDown(character) {
        character.lastMovement("down")
        character.moveTo(character.position().down(1))
    }

    method moveLeft(character) {
        character.lastMovement("left")
        character.moveTo(character.position().left(1))
    }

    method moveRight(character) {
        character.lastMovement("right")
        character.moveTo(character.position().right(1))
    }
}