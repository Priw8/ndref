'Strict

Import monkey.list
Import enemy.conductor
Import enemy
Import entity
Import logger
Import sprite

Class ConductorProp Extends Enemy

    Function _EditorFix: Void() End

    Method New(xVal: Int, yVal: Int, l: Int)
        'Bare minimum for necrolevel
        Super.New()
        Self.Init(xVal, yVal, l, "conductor_prop")

        Self.wireXs = New List<Int>
        Self.wireYs = New List<Int>

        Debug.TraceNotImplemented("ConductorProp.New(Int, Int, Int)")
    End Method

    Field origXOff: Int
    Field shieldImage: Sprite
    Field parent: Conductor
    Field wireXs: List<Int>
    Field wireYs: List<Int>
    Field vibrateCounter: Int
    Field vibrateOffset: Float
    Field shieldFrameCounter: Int

    Method AddWireAt: Tile(wireX: Int, wireY: Int)
        Self.wireXs.AddLast(wireX)
        Self.wireYs.AddLast(wireY)

        'Unsure if there's anything apart from this, there's a lot of inlining going on
        'Maybe the linux build makes more sense
        Local wireTile := Level.PlaceTileRemovingExistingTiles(wireX, wireY, TileType.ConductorWirePhase1)

        Return wireTile
    End Method

    Method Die: Void()
        Super.Die()
        Debug.TraceNotImplemented("ConductorProp.Die()")
    End Method

    Method Hit: Bool(damageSource: String, damage: Int, dir: Int, hitter: Entity, hitAtLastTile: Bool, hitType: Int)
        Debug.TraceNotImplemented("ConductorProp.Hit(String, Int, Int, Entity, Bool, Int)")
    End Method

    Method IsShielded: Bool()
        Debug.TraceNotImplemented("ConductorProp.IsShielded()")
    End Method

    Method Render: Void()
        Debug.TraceNotImplemented("ConductorProp.Render()")
    End Method

    Method Update: Void()
        Debug.TraceNotImplemented("ConductorProp.Update()")
    End Method

End Class
