'Strict

Import enemy
Import logger
Import point

Class Ghost Extends Enemy

    Function _EditorFix: Void() End

    Method New(xVal: Int, yVal: Int, l: Int)
        Super.New()

        Self.Init(xVal, yVal, l, "ghost", "", -1, -1)

        Self.image.SetAlphaTweenFromCurrent(0.4, 5)

        For Local i := 0 Until Self.lastDist.Length()
            Self.lastDist[i] = 9999.0
        End For

        Self.overrideAttackSound = "ghostAttack"
        Self.overrideDeathSound = "ghostDeath"
    End Method

    Field lastDist: Float[4]
    Field movingAway: Bool

    Method CanBeDamaged: Bool(phasing: Bool, piercing: Bool)
        Debug.TraceNotImplemented("Ghost.CanBeDamaged(Bool, Bool)")
    End Method

    Method GetMovementDirection: Point()
        Debug.TraceNotImplemented("Ghost.GetMovementDirection()")
    End Method

    Method Move: Int()
        Debug.TraceNotImplemented("Ghost.Move()")
    End Method

    Method ProcessDistanceChanges: Void()
        Debug.TraceNotImplemented("Ghost.ProcessDistanceChanges()")
    End Method

    Method Update: Void()
        Debug.TraceNotImplemented("Ghost.Update()")
    End Method

End Class
