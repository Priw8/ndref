'Strict

Import monkey.list
Import enemy
Import enemy.conductor_prop
Import entity
Import logger
Import point

Class Conductor Extends Enemy

    Global theConductor: Object

    Function ClearWire: Void()
        Debug.TraceNotImplemented("Conductor.ClearWire()")
    End Function

    Function _EditorFix: Void() End

    Method New(xVal: Int, yVal: Int)
        'Bare minimum for necrolevel
        Super.New()
        Self.Init(xVal, yVal, 1, "conductor")
        Conductor.theConductor = Self

        Debug.TraceNotImplemented("Conductor.New(Int, Int)")
    End Method

    Field phase: Int
    Field origXOff: Int
    Field fireTraps: List<Object>
    Field nprops: Int
    Field cycleCounter: Int
    Field pulses: List<Object>
    Field shouldSummonWaterBall: Int
    Field muteFirstSummon: Bool
    Field vibrateCounter: Int
    Field vibrateOffset: Float
    Field flashCounter: Int
    Field angrySoundsPlayed: List<Object>

    Method AddProp: Void(propX: Int, propY: Int, propType: Int)
        Local prop := New ConductorProp(propX, propY, propType)
        prop.ActivateLight(0.01, 1.5)
        prop.parent = Self

        Self.nprops = Self.nprops + 1

        'Create wire going up/down from the prop
        If propType = 1 Or propType = 2 Then
            'Y coordinate on which the wire turns left/right
            Local wireTurnY := propY + 2
            For Local wireY := propY Until wireTurnY + 1
                Local wireTile := prop.AddWireAt(propX, wireY)
                Local wireDirection: Int
                If wireY = wireTurnY Then
                    If propType = 1 Then
                        wireDirection = Direction.Right
                    Else
                        wireDirection = Direction.Left
                    End
                Else
                    wireDirection = Direction.Down
                End
                wireTile.AddWireConnection(wireDirection)

                If propY < wireY Then
                    wireTile.AddWireConnection(Direction.Up)
                End
            End For
        Else
            Local wireTurnY := propY - 2
            For Local wireY := wireTurnY Until propY + 1
                Local wireTile := prop.AddWireAt(propX, wireY)
                Local wireDirection: Int
                If wireY = wireTurnY Then
                    If propType = 3 Then
                        wireDirection = Direction.Right
                    Else
                        wireDirection = Direction.Left
                    End
                Else
                    wireDirection = Direction.Up
                End
                wireTile.AddWireConnection(wireDirection)
    
                If propY > wireY Then
                    wireTile.AddWireConnection(Direction.Down)
                End
            End For
        End

        'Create wire going left/right from the previously created wire
        If propType = 1 Or propType = 3 Then
            Local wireY: Int
            If propType = 1 Then
                wireY = propY + 2
            Else
                wireY = propY - 2
            End

            Local lastWireX := propX + 4
            For Local wireX := propX + 1 Until lastWireX + 1
                Local wireTile := prop.AddWireAt(wireX, wireY)
                If wireX <> lastWireX Then
                    wireTile.AddWireConnection(Direction.Right)
                End
                wireTile.AddWireConnection(Direction.Left)
            End For
        Else
            Local wireY: Int
            If propType = 2 Then
                wireY = propY + 2
            Else
                wireY = propY - 2
            End

            Local lastWireX := propX - 4
            For Local wireX := lastWireX Until propX
                Local wireTile := prop.AddWireAt(wireX, wireY)
                If wireX <> lastWireX Then
                    wireTile.AddWireConnection(Direction.Left)
                End
                wireTile.AddWireConnection(Direction.Right)
            End
        End

    End Method

    Method BeginPhase2: Void()
        Debug.TraceNotImplemented("Conductor.BeginPhase2()")
    End Method

    Method CastSpell: Void(b: Object)
        Debug.TraceNotImplemented("Conductor.CastSpell(Object)")
    End Method

    Method Die: Void()
        Conductor.theConductor = Null
        Debug.TraceNotImplemented("Conductor.Die()")
    End Method

    Method DoWarningZap: Void(large: Bool)
        Debug.TraceNotImplemented("Conductor.DoWarningZap(Bool)")
    End Method

    Method GetMovementDirection: Point()
        Debug.TraceNotImplemented("Conductor.GetMovementDirection()")
    End Method

    Method GetNextSpawnZone: Int()
        Debug.TraceNotImplemented("Conductor.GetNextSpawnZone()")
    End Method

    Method Hit: Bool(damageSource: String, damage: Int, dir: Int, hitter: Entity, hitAtLastTile: Bool, hitType: Int)
        Debug.TraceNotImplemented("Conductor.Hit(String, Int, Int, Entity, Bool, Int)")
    End Method

    Method MoveFail: Void()
        Debug.TraceNotImplemented("Conductor.MoveFail()")
    End Method

    Method MoveSucceed: Void(hitPlayer: Bool, moveDelayed: Bool)
        Debug.TraceNotImplemented("Conductor.MoveSucceed(Bool, Bool)")
    End Method

    Method OnPropHit: Void(propNum: Int)
        Debug.TraceNotImplemented("Conductor.OnPropHit(Int)")
    End Method

    Method RemoveBatteryWire: Void(propX: Int, propY: Int)
        Debug.TraceNotImplemented("Conductor.RemoveBatteryWire(Int, Int)")
    End Method

    Method RemovePropWire: Void(propX: Int, propY: Int, propType: Int)
        Debug.TraceNotImplemented("Conductor.RemovePropWire(Int, Int, Int)")
    End Method

    Method SpawnEnemy: Void(spawnType: Int, xVal: Int, yVal: Int)
        Debug.TraceNotImplemented("Conductor.SpawnEnemy(Int, Int, Int)")
    End Method

    Method SpawnEnemy2: Void(spawnType: Int)
        Debug.TraceNotImplemented("Conductor.SpawnEnemy2(Int)")
    End Method

    Method SpawnEnemy3: Void()
        Debug.TraceNotImplemented("Conductor.SpawnEnemy3()")
    End Method

    Method SpawnMinibosses: Void(propNum: Int)
        Debug.TraceNotImplemented("Conductor.SpawnMinibosses(Int)")
    End Method

    Method Update: Void()
        Debug.TraceNotImplemented("Conductor.Update()")
    End Method

End Class
