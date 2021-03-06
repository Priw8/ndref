'Strict

Import controller.controller_game
Import enemy
Import level
Import chest
Import entity
Import item
Import logger
Import point

Class TrapChest Extends Enemy

    Function _EditorFix: Void() End

    Method New(xVal: Int, yVal: Int, l: Int)
        Super.New()

        Self.Init(xVal, yVal, l, "trapchest")

        Self.stealth = True
        Self.containsItem = True
        Self.overrideAttackSound = "mimicAttack"
        Self.overrideDeathSound = "mimicDeath"
        Self.overrideMoveSound = "mimicChase"

        If Level.randSeed <> -1
            Self.DetermineContents()
        End If
    End Method

    Field contents: String = ItemType.NoItem
    Field hasMoved: Bool
    Field itemDropped: Bool

    Method CanBeDamaged: Bool(phasing: Bool, piercing: Bool)
        Debug.TraceNotImplemented("TrapChest.CanBeDamaged(Bool, Bool)")
    End Method

    Method DetermineContents: Void()
        If Self.contents = ItemType.NoItem
            If Self.level >= 6
                Self.contents = Item.GetRandomItemInClass("", controller_game.currentLevel, "urnChance")
            Else If Self.level >= 4
                Self.contents = ItemType.Bomb
            Else If Self.level >= 2
                Self.contents = Item.GetRandomItemInClass("", controller_game.currentLevel + 1, "lockedChestChance")
            Else
                Self.contents = Item.GetRandomItemInClass("", controller_game.currentLevel + 1, "chestChance")
            End If
        End If
    End Method

    Method Die: Void()
        If Not Self.dead
            Self.DropItem()

            Super.Die()
        End If
    End Method

    Method DropItem: Void()
        If Not Self.itemDropped
            If Not Level.isTrainingMode
                Self.DetermineContents()

                If Self.contents <> ItemType.NoItem
                    New Item(Self.x, Self.y, Self.contents, False, -1, False)
                End If
            End If

            Self.itemDropped = True
        End If
    End Method

    Method GetMovementDirection: Point()
        Debug.TraceNotImplemented("TrapChest.GetMovementDirection()")
    End Method

    Method Hit: Bool(damageSource: String, damage: Int, dir: Int, hitter: Entity, hitAtLastTile: Bool, hitType: Int)
        Debug.TraceNotImplemented("TrapChest.Hit(String, Int, Int, Entity, Bool, Int)")
    End Method

    Method Update: Void()
        Debug.TraceNotImplemented("TrapChest.Update()")
    End Method

End Class
