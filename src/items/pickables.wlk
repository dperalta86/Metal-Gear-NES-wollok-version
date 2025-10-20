import src.gameObject.GameObject
class Box inherits GameObject {
    override method image() = "cardboardBox.png"

    override method usar(character) {
        character.equiparItem(self)
        game.removeVisual(self)
    }

}

class RedKey inherits GameObject {
    override method image() = "red_key.png"
}

class BlueKey inherits GameObject {
    override method image() = "blue_key.png"
}

class Weapon inherits GameObject {
    override method image() = "weapon.png"
}

class Health inherits GameObject {
    override method image() = "health.png"
}