'Strict

Import entity
Import logger
Import sprite
Import trap

Class TeleportTrap Extends Trap

    Function _EditorFix: Void() End

    Method New(xVal: Int, yVal: Int)
        Super.New(xVal, yVal, TrapType.TeleportTrap)

        Self.xOff = 5.0
        Self.yOff = 15.0

        Self.image = New Sprite("traps/teleporttrap.png", 14, 16, 4)
        Self.image.SetZ(-995.0)
    End Method

    Field retractCounter: Int

    Method Trigger: Void(ent: Entity)
        Debug.TraceNotImplemented("TeleportTrap.Trigger(Entity)")
    End Method

    Method Update: Void()
        If Self.retractCounter > 0
            Self.retractCounter -= 1
            If Self.retractCounter = 0
                Self.triggered = False
            End If
        End If

        Self.image.SetFrame(1)
        If Self.triggered
            Self.image.SetFrame(0)
        End If

        Super.Update()
    End Method

End Class
