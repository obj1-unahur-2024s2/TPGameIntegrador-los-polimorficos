import personaje.*
class Monstruo{
    var property position = game.at(x, y)
    var x = (0.. game.width()-1).anyOne()
    var y = (0.. game.height()-1).anyOne()

    method image() = "monstruo.png"

    method perseguirPersonaje(){
        if (self.position() != coco.position())
            position = game.at(self.perseguirEnDireccionX(), self.perseguirEnDireccionY())
    }

    method perseguirEnDireccionX(){
        if(coco.position().x() > self.position().x())
         x =+ 1 
        else if(coco.position().x() < self.position().x()) 
         x -= 1
        return x
    } 

    method perseguirEnDireccionY(){
        if(coco.position().y() > self.position().y())
         y =+ 1 
        else if(coco.position().y() < self.position().y()) 
         y -= 1
        return y
    }    
}
