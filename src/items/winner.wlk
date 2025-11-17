import src.gameManager.*
import src.items.pickables.Pickable
class Winner inherits Pickable{
    override method displayImage() = "winner"

    override method equip(character){
        // Las verificaciones (si cumple requisitos) las hace gameManager
        gameManager.winner(character)
    }
}