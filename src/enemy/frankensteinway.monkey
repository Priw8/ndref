'Strict

Import monkey.list
Import monkey.map
Import monkey.stack
Import enemy.frankensteinway_prop
Import enemy
Import entity
Import logger
Import point
Import sprite
Import trap.frankensteinway_switch

Class Frankensteinway Extends Enemy

    Function _EditorFix: Void() End

    Method New(xVal: Int, yVal: Int)
        'Bare minimum for necrolevel
        Super.New()
        Self.Init(xVal, yVal, 1, "frankensteinway")

        Self.props = New Stack<FrankensteinwayProp>

        Debug.TraceNotImplemented("Frankensteinway.New(Int, Int)")
    End Method

    Field shieldImage: Sprite
    Field props: Stack<FrankensteinwayProp>
    Field didCry: Bool
    Field activeProp: FrankensteinwayProp
    Field moveDir: Int
    Field dashDir: Int
    Field phase: Int
    Field shieldFrameCounter: Int
    Field currentPattern: Stack<Object>
    Field currentPatternIndex: Int
    Field pulses: IntMap<Object>
    Field cascade: List<Object>
    Field lastHitBeat: Int

    Method AddProp: Void(propX: Int, propY: Int, switchDY: Int)
        'Simplified for necrolevel purposes (I think; maybe this is all it does, but not 100% sure on that)
        Local prop := New FrankensteinwayProp(propX, propY)
        Self.props.Push(prop)

        Local switch := New FrankensteinwaySwitch(propX, propY + switchDY)
        switch.parent = prop
    End Method

    Method AfterMove: Void()
        Debug.TraceNotImplemented("Frankensteinway.AfterMove()")
    End Method

    Method ClearAllPulses: Void()
        Debug.TraceNotImplemented("Frankensteinway.ClearAllPulses()")
    End Method

    Method Die: Void()
        Super.Die()
        Debug.TraceNotImplemented("Frankensteinway.Die()")
    End Method

    Method GetDisplayHealth: Int()
        Debug.TraceNotImplemented("Frankensteinway.GetDisplayHealth()")
    End Method

    Method GetDisplayHealthMax: Int()
        Debug.TraceNotImplemented("Frankensteinway.GetDisplayHealthMax()")
    End Method

    Method GetMovementDirection: Point()
        Debug.TraceNotImplemented("Frankensteinway.GetMovementDirection()")
    End Method

    Method GetPatternTimer: Int()
        Debug.TraceNotImplemented("Frankensteinway.GetPatternTimer()")
    End Method

    Method GetPulseAt: Object(pulseX: Int, pulseY: Int)
        Debug.TraceNotImplemented("Frankensteinway.GetPulseAt(Int, Int)")
    End Method

    Method Hit: Bool(damageSource: String, damage: Int, dir: Int, hitter: Entity, hitAtLastTile: Bool, hitType: Int)
        Debug.TraceNotImplemented("Frankensteinway.Hit(String, Int, Int, Entity, Bool, Int)")
    End Method

    Method HurtPlayerAt: Void(atX: Int, atY: Int, damage: Int, hitFloating: Bool)
        Debug.TraceNotImplemented("Frankensteinway.HurtPlayerAt(Int, Int, Int, Bool)")
    End Method

    Method IsShielded: Bool()
        Debug.TraceNotImplemented("Frankensteinway.IsShielded()")
    End Method

    Method MoveFail: Void()
        Debug.TraceNotImplemented("Frankensteinway.MoveFail()")
    End Method

    Method MovementPreview: Void(dir: Int, maxDist: Int)
        Debug.TraceNotImplemented("Frankensteinway.MovementPreview(Int, Int)")
    End Method

    Method MoveSucceed: Void(hitPlayer: Bool, moveDelayed: Bool)
        Debug.TraceNotImplemented("Frankensteinway.MoveSucceed(Bool, Bool)")
    End Method

    Method PerformMovement: Int(xVal: Int, yVal: Int)
        Debug.TraceNotImplemented("Frankensteinway.PerformMovement(Int, Int)")
    End Method

    Method Phase0Pulse: Void()
        Debug.TraceNotImplemented("Frankensteinway.Phase0Pulse()")
    End Method

    Method Phase1Pulse: Void()
        Debug.TraceNotImplemented("Frankensteinway.Phase1Pulse()")
    End Method

    Method PickDashDir: Void()
        Debug.TraceNotImplemented("Frankensteinway.PickDashDir()")
    End Method

    Method Render: Void()
        Debug.TraceNotImplemented("Frankensteinway.Render()")
    End Method

    Method RerollMoveDir: Void()
        Debug.TraceNotImplemented("Frankensteinway.RerollMoveDir()")
    End Method

    Method RerollPattern: Void()
        Debug.TraceNotImplemented("Frankensteinway.RerollPattern()")
    End Method

    Method ShowMovementPreviews: Void()
        Debug.TraceNotImplemented("Frankensteinway.ShowMovementPreviews()")
    End Method

    Method SpawnEnemy: Void(enemyType: Int, enemyX: Int, enemyY: Int)
        Debug.TraceNotImplemented("Frankensteinway.SpawnEnemy(Int, Int, Int)")
    End Method

    Method SpawnSarcophagi: Void()
        Self.SpawnSarcophagus(-7, -13)
        Self.SpawnSarcophagus(7, -13)
    End Method

    Method SpawnSarcophagus: Void(atX: Int, atY: Int)
        'This is a VERY simplified version for necrolevel
        'The actual method checks which tier to spawn, whether there's
        'anything at the spawn coordinates etc and I don't feel like doing that!
        New Sarcophagus(atX, atY, 1)
    End Method

    Method Update: Void()
        Debug.TraceNotImplemented("Frankensteinway.Update()")
    End Method

End Class
