'Strict

Import familiar_fixed
Import logger

Class Rat Extends FamiliarFixed

    Function _EditorFix: Void() End

    Method New(x_: Int, y_: Int)
        Debug.TraceNotImplemented("Rat.New(Int, Int)")
    End Method

    Method ApplyEffect: Bool(dir: Int)
        Debug.TraceNotImplemented("Rat.ApplyEffect(Int)")
    End Method

    Method Update: Void()
        Debug.TraceNotImplemented("Rat.Update()")
    End Method

End Class
