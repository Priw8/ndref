'Strict

Import enemy
Import level
Import audio2
Import camera
Import entity
Import logger
Import player_class
Import point
Import sprite
Import util

Class Poltergeist Extends Enemy

    Global theGhoul: Poltergeist

    Function _EditorFix: Void() End

    Method New(xVal: Int, yVal: Int, l: Int)
        Super.New()

        Self.Init(xVal, yVal, l, "ghoul")

        Self.invisible = True
        Self.collides = False
        Self.blink_MIN = 120
        Self.blink_MAX = 240
        Self.blink_DUR = 10

        Self.overrideAttackSound = "ghoulAttack"
        Self.overrideDeathSound = "ghoulDeath"

        Self.image.SetZOff(18.0)

        Local enemyNode := Enemy.GetEnemyXML(Self.xmlName, Self.level)
        Local spritesheetNode := enemyNode.GetChild("spritesheet")
        Local path := spritesheetNode.value
        Local frameW := spritesheetNode.GetAttribute("frameW", 0)
        Local frameH := spritesheetNode.GetAttribute("frameH", 0)
        Local numFrames := spritesheetNode.GetAttribute("numFrames", 1)
        Self.alphaImage = New Sprite(path, frameW, frameH, numFrames)
        Self.alphaImage.SetAlphaValue(0.6)
        Self.alphaImage.SetZOff(18.0)

        Self.isWraithLike = True

        Poltergeist.theGhoul = Self

        If Util.IsCharacterActive(Character.Eli)
            Self.coinsToDrop = 0
            Self.Die()
        End If
    End Method

    Field alphaImage: Sprite
    Field multiImage: Bool
    Field hitPlayer: Entity
    Field seeking: Bool
    Field teleporting: Bool
    Field skippedMove: Bool
    Field hasRoared: Bool
    Field beenHit: Bool

    Method BecomeCorporeal: Void(force: Bool)
        Debug.TraceNotImplemented("Poltergeist.BecomeCorporeal(Bool)")
    End Method

    Method CheckCorporeality: Void()
        Debug.TraceNotImplemented("Poltergeist.CheckCorporeality()")
    End Method

    Method Die: Void()
        If Poltergeist.theGhoul = Self
            Poltergeist.theGhoul = Null
        End If

        Super.Die()
    End Method

    Method GetMovementDirection: Point()
        Debug.TraceNotImplemented("Poltergeist.GetMovementDirection()")
    End Method

    Method Hit: Bool(damageSource: String, damage: Int, dir: Int, hitter: Entity, hitAtLastTile: Bool, hitType: Int)
        Debug.TraceNotImplemented("Poltergeist.Hit(String, Int, Int, Entity, Bool, Int)")
    End Method

    Method MoveSucceed: Void(hitPlayer: Bool, moveDelayed: Bool)
        Debug.TraceNotImplemented("Poltergeist.MoveSucceed(Bool, Bool)")
    End Method

    Method Render: Void()
        Debug.TraceNotImplemented("Poltergeist.Render()")
    End Method

    Method Update: Void()
        If Not Self.dead And
           Entity.AnyPlayerHaveNazarCharm()
            Self.coinsToDrop = 0
            Self.Die()
        End If

        If Not Enemy.EnemiesMovingThisFrame()
            Self.CheckCorporeality()
        End If

        If Self.frozenDuration <= 0 And
           Self.teleporting
            Self.teleporting = False
            Self.multiImage = True

            Local dir := Util.GetDirFromDiff(Self.x - hitPlayer.x, Self.y - hitPlayer.y)
            dir = Util.GetDirAfterRotation(dir, 0, False)

            Local xDiff := 0
            Local yDiff := 0

            Const MAX_ROTATIONS: Int = 15
            For Local i := 0 Until MAX_ROTATIONS
                dir = Util.GetDirAfterRotation(dir, 0, False)
                Local dirPoint := Util.GetPointFromDir(dir)

                If Not Util.IsGlobalCollisionAt(Self.x + dirPoint.x, Self.y + dirPoint.y, False, True, False, False)
                    xDiff = dirPoint.x
                    yDiff = dirPoint.y

                    Exit
                End IF
            End For

            Self.MoveImmediate(xDiff, yDiff, "self")

            Self.currentMoveDelay = 2
            If Self.skippedMove
                Self.currentMoveDelay = 1
            End If

            Audio.PlayGameSoundAt("ghoulTeleport", Self.x, Self.y, True, -1, False)
        End If

        If Not Self.invisible And
           Self.IsVisible() And
           Camera.IsOnScreen(Self.x, Self.y) And
           Not Self.hasRoared And
           Not Level.isLevelEditor
            Audio.PlayGameSoundAt("ghoulCry", Self.x, Self.y, True, -1, False)
            Self.hasRoared = True
        End If

        Super.Update()
    End Method

End Class
