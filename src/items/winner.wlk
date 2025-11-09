import src.gameManager.*
import src.items.pickables.Pickable
class Winner inherits Pickable{
    override method displayImage() = "winner"

    override method equip(character){
        gameManager.winner(character)
    }
}