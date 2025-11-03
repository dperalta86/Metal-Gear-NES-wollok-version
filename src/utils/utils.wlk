object utils{
    /*
    * Devuelve el nombre simple de la clase (sin el paquete completo) 
    * de una instancia dada. 
    * Ejemplo: si instancia.className() = "src.characters.Snake"
    * devuelve "Snake".
    * 
    * En caso de error o si la instancia no tiene método className(), 
    * devuelve el string "Unknown".
    */
    method getClassName(instancia) {
        try {
            if (instancia == null) 
            {
                return "Unknown"
            } 
            const fullName = instancia.className()
            if (fullName == null)
            {
                return "Unknown"
            } 
            const parts = fullName.split(".")
            if (parts.isEmpty())
            {
                return "Unknown"
            }
            return parts.last()
        } catch e {
            console.println("[utils.getClassName] Error al obtener nombre de clase: " + e)
            return "Unknown"
        }
    }
}