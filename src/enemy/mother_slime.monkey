'Strict

Import enemy
Import entity
Import logger
Import point

Class MotherSlime Extends Enemy

    Function _EditorFix: Void() End

    Method New(xVal: Int, yVal: Int, l: Int)
        Debug.TraceNotImplemented("MotherSlime.New(Int, Int, Int)")
    End Method

    Field moveCount: Int
    Field rapierPoint: Point

    Method Die: Void()
        Super.Die()
        Debug.TraceNotImplemented("MotherSlime.Die()")
    End Method

    Method GetMovementDirection: Point()
        Debug.TraceNotImplemented("MotherSlime.GetMovementDirection()")
    End Method

    Method Hit: Bool(damageSource: String, damage: Int, dir: Int, hitter: Entity, hitAtLastTile: Bool, hitType: Int)
        Debug.TraceNotImplemented("MotherSlime.Hit(String, Int, Int, Entity, Bool, Int)")
    End Method

    Method MoveFail: Void()
        Debug.TraceNotImplemented("MotherSlime.MoveFail()")
    End Method

    Method MoveSucceed: Void(hitPlayer: Bool, moveDelayed: Bool)
        Debug.TraceNotImplemented("MotherSlime.MoveSucceed(Bool, Bool)")
    End Method

End Class
