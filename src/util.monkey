'Strict

Import "native/util.cpp"
Import monkey.list
Import monkey.map
Import monkey.math
Import monkey.random
Import os
Import mojo.input
Import controller.controller_game
Import familiar
Import familiar_fixed.soul_familiar
Import level
Import audio2
Import camera
Import entity
Import gamedata
Import item
Import logger
Import necrodancer
Import player_class
Import point
Import rect
Import renderableobject
Import stack_ex

Class Util

    Global delayedStatIncrements: List<String> = New List<String>()
    Global delayedStatSets: StringMap<Int> = New StringMap<Int>()
    Global dirRotationOrder: StackEx<Int> = New StackEx<Int>()
    Global numSubmissionAttempts: Int
    Global pendingScoreRetrieval: Bool
    Global pendingScoreRetrievalEnd: Int
    Global pendingScoreRetrievalStart: Int
    Global pendingScoreSubmission: List<HighScoreSubmission> = New List<HighScoreSubmission>()
    Global storedSeed: Int

    Function AddMetric: Void(key: String, value: String, send: Bool = False, blocking: Bool = False, isNumber: Bool = False)
        Debug.TraceNotImplemented("Util.AddMetric(String, String, Bool, Bool, Bool)")
    End Function

    Function AreAriaOrCodaActive: Bool()
        Return Util.IsCharacterActive(Character.Aria) Or Util.IsCharacterActive(Character.Coda)
    End Function

    Function CreateScaledTextSprite: Object(str: Int, color: Int, scale: Int)
        Debug.TraceNotImplemented("Util.CreateScaledTextSprite(Int, Int, Int)")
    End Function

    Function CreateTextSprite: Object(str: Int, color: Int, addShadow: Bool)
        Debug.TraceNotImplemented("Util.CreateTextSprite(Int, Int, Bool)")
    End Function

    Function CustomMusicInUse: Bool()
        Debug.TraceNotImplemented("Util.CustomMusicInUse()")
    End Function

    Function DirToString: String(dir: Int)
        Select dir
            Case Direction.None Return "DIR_NONE"
            Case Direction.Right Return "DIR_RIGHT"
            Case Direction.Down Return "DIR_DOWN"
            Case Direction.Left Return "DIR_LEFT"
            Case Direction.Up Return "DIR_UP"
            Case Direction.DownRight Return "DIR_DOWNRIGHT"
            Case Direction.DownLeft Return "DIR_DOWNLEFT"
            Case Direction.UpLeft Return "DIR_UPLEFT"
            Case Direction.UpRight Return "DIR_UPRIGHT"
        End Select

        Return "Unrecognized direction " + dir
    End Function

    Function FindClosestTrulyUnoccupiedSpace: Point(xVal: Int, yVal: Int, ignoreWalls: Bool)
        Local points := [[xVal, yVal], [xVal - 1, yVal], [xVal + 1, yVal], [xVal, yVal - 1], [xVal, yVal + 1], [xVal - 1, yVal - 1], [xVal + 1, yVal - 1], [xVal - 1, yVal + 1], [xVal + 1, yVal + 1], [xVal - 2, yVal], [xVal + 2, yVal], [xVal, yVal - 2], [xVal, yVal + 2]]

        For Local p := EachIn points
            Local x := p[0]
            Local y := p[1]

            If Level.GetTileAt(x, y) <> Null And
               Not Util.IsGlobalCollisionAt(x, y, False, ignoreWalls, False, False) And
               Not Util.IsAnyPlayerAt(x, y) And
               Entity.GetEntityAt(x, y, True) = Null
                Return New Point(x, y)
            End If
        End For

        Return Null
    End Function

    Function FindClosestTrulyUnoccupiedSpaceNotAdjacentToEnemy: Object(xVal: Int, yVal: Int, ignoreWalls: Bool)
        Debug.TraceNotImplemented("Util.FindClosestTrulyUnoccupiedSpaceNotAdjacentToEnemy(Int, Int, Bool)")
    End Function

    Function FindClosestUnoccupiedSpace: Point(xVal: Int, yVal: Int, ignoreWalls: Bool)
        Debug.TraceNotImplemented("Util.FindClosestUnoccupiedSpace(Int, Int, Bool)")
    End Function

    Function GetActiveLanguagesFolderPath: Int()
        Debug.TraceNotImplemented("Util.GetActiveLanguagesFolderPath()")
    End Function

    Function GetAngleBetweenDirections: Int(dir1: Int, dir2: Int)
        Debug.TraceNotImplemented("Util.GetAngleBetweenDirections(Int, Int)")
    End Function

    Function GetAnyPlayerAt: Player(xVal: Int, yVal: Int)
        For Local i := 0 Until controller_game.numPlayers
            Local player := controller_game.players[i]
            If Not player.Perished
                If player.x = xVal And
                   player.y = yVal
                    Return player
                End If
            End If
        End For

        Return Null
    End Function

    Function GetClosestPlayer: Player(xVal: Int, yVal: Int)
        Local dist := 99999.0
        Local closestPlayer := controller_game.players[controller_game.player1]

        For Local i := 0 Until controller_game.numPlayers
            Local player := controller_game.players[i]
            Local distToPlayer := Util.GetDist(player.x, player.y, xVal, yVal)

            If dist > distToPlayer
                dist = distToPlayer
                closestPlayer = player
            End If
        End For

        Return closestPlayer
    End Function

    Function GetClosestPlayerIncludeItemEffects: Player(xVal: Int, yVal: Int, ignorePhasing: Bool)
        Local dist := 99999.0
        Local closestPlayer: Player

        For Local i := 0 Until controller_game.numPlayers
            Local player := controller_game.players[i]
            Local distToPlayer := Util.GetDist(player.x, player.y, xVal, yVal)

            If distToPlayer <= 3.0 Or
               player.GetItemInSlot("head", False) = ItemType.NinjaMask
                If ignorePhasing Or
                   Not player.IsPhasing() Or
                   Not Level.IsWallAt(player.x, player.y)
                    If dist > distToPlayer
                        dist = distToPlayer
                        closestPlayer = player
                    End If
                End If
            End If
        End For

        Return closestPlayer
    End Function

    Function GetDirAfterRotation: Int(dir: Int, rotation: Int, includeDiagonals: Bool)
        Debug.TraceNotImplemented("Util.GetDirAfterRotation(Int, Int, Bool)")
    End Function

    Function GetDirFromDiff: Int(xDiff: Int, yDiff: Int)
        Local dir := Direction.None

        If xDiff < 0
            If yDiff < 0
                dir = Direction.UpLeft
            Else If yDiff > 0
                dir = Direction.DownLeft
            Else
                dir = Direction.Left
            End If
        Else If xDiff > 0
            If yDiff < 0
                dir = Direction.UpRight
            Else If yDiff > 0
                dir = Direction.DownRight
            Else
                dir = Direction.Right
            End If
        Else
            If yDiff < 0
                dir = Direction.Up
            Else If yDiff > 0
                dir = Direction.Down
            End If
        End If

        Return dir
    End Function

    Function GetDirRotationOrder: Object()
        Debug.TraceNotImplemented("Util.GetDirRotationOrder()")
    End Function

    Function GetDist: Float(x: Int, y: Int, x2: Int, y2: Int)
        Return math.Sqrt(Util.GetDistSq(x, y, x2, y2))
    End Function

    Function GetDistSq: Int(x: Int, y: Int, x2: Int, y2: Int)
        Return ((x2 - x) * (x2 - x)) +
               ((y2 - y) * (y2 - y))
    End Function

    Function GetDistFromClosestPlayer: Float(xVal: Int, yVal: Int, includeSouls: Bool)
        Local dist := 99999.0

        For Local i := 0 Until controller_game.numPlayers
            Local player := controller_game.players[i]
            If Not player.Perished
                Local distToPlayer := Util.GetDist(player.x, player.y, xVal, yVal)
                dist = math.Min(dist, distToPlayer)
            End If
        End For

        If includeSouls
            For Local soulFamiliar := EachIn SoulFamiliar.allSouls
                Local distToSoulFamiliar := Util.GetDist(soulFamiliar.x, soulFamiliar.y, xVal, yVal)
                dist = math.Min(dist, distToSoulFamiliar)
            End For
        End If

        Return dist
    End Function

    Function GetDistSqFromClosestPlayer: Float(xVal: Int, yVal: Int, includeSouls: Bool, includeLambs: Bool)
        Local distSq := 99999.0

        For Local i := 0 Until controller_game.numPlayers
            Local player := controller_game.players[i]
            If Not player.Perished
                Local distToPlayerSq := Util.GetDistSqFromObject(xVal, yVal, player)
                distSq = math.Min(distSq, distToPlayerSq)
            End If
        End for

        If includeSouls
            For Local soulFamiliar := EachIn SoulFamiliar.allSouls
                Local distToSoulFamiliarSq := Util.GetDistSqFromObject(xVal, yVal, soulFamiliar)
                distSq = math.Min(distSq, distToSoulFamiliarSq)
            End For
        End If

        If includeLambs
            For Local familiar := EachIn Familiar.familiarList
                Local distToFamiliarSq := Util.GetDistSqFromObject(xVal, yVal, familiar)
                distSq = math.Min(distSq, distToFamiliarSq)
            End For
        End If

        Return distSq
    End Function

    Function GetDistSqFromObject: Float(xVal: Int, yVal: Int, obj: RenderableObject)
        Return Util.GetDistSq(obj.x, obj.y, xVal, yVal)
    End Function

    Function GetLanguagesFolderPath: Int()
        Debug.TraceNotImplemented("Util.GetLanguagesFolderPath()")
    End Function

    Function GetLeaderboardScores: Void(rangeStart: Int, rangeEnd: Int, dayOffset: Int, specificLeaderboard: String, useTodaysSeed: Bool, friendsOnly: Bool, playerOnly: Bool)
        Debug.TraceNotImplemented("Util.GetLeaderboardScores(Int, Int, Int, String, Bool, Bool, Bool)")
    End Function

    Function GetLeaderboardSetPrefix: Int()
        Debug.TraceNotImplemented("Util.GetLeaderboardSetPrefix()")
    End Function

    Function GetLeaderboardSuffix: Int()
        Debug.TraceNotImplemented("Util.GetLeaderboardSuffix()")
    End Function

    Function GetLeaderboardSuffixForCharacterAndCoopAndDeathlessState: Int(includeCadence: Bool, includeCustomMusic: Bool, includeExtraMode: Bool, includeChar: Bool, includeAllChars: Bool, includeTags: Bool)
        Debug.TraceNotImplemented("Util.GetLeaderboardSuffixForCharacterAndCoopAndDeathlessState(Bool, Bool, Bool, Bool, Bool, Bool)")
    End Function

    Function GetL1Dist: Int(x1: Int, y1: Int, x2: Int, y2: Int)
        Return math.Abs(x1 - x2) + math.Abs(y1 - y2)
    End Function

    Function GetPlayerLocation: Object(playerNum: Int)
        Debug.TraceNotImplemented("Util.GetPlayerLocation(Int)")
    End Function

    Function GetPlayersAt: List<Player>(where: Rect)
        Local playersAt := New List<Player>()

        For Local i := 0 Until controller_game.numPlayers
            Local player := controller_game.players[i]
            If Not player.Perished()
                If where.Contains(player.GetLocation())
                    playersAt.AddLast(player)
                End If
            End If
        End for

        Return playersAt
    End Function

    Function GetPlayersAt: List<Player>(xVal: Int, yVal: Int)
        Return Util.GetPlayersAt(New Rect(xVal, yVal, 0, 0))
    End Function

    Function GetPointFromDir: Point(dir: Int)
        Local x: Int
        Local y: Int

        Select dir
            Case Direction.Right
                x = 1
                y = 0
            Case Direction.Down
                x = 0
                y = 1
            Case Direction.Left
                x = -1
                y = 0
            Case Direction.Up
                x = 0
                y = -1
            Case Direction.DownRight
                x = 1
                y = 1
            Case Direction.DownLeft
                x = -1
                y = 1
            Case Direction.UpLeft
                x = -1
                y = -1
            Case Direction.UpRight
                x = 1
                y = -1
            Default
                x = 0
                y = 0
        End Select

        Return New Point(x, y)
    End Function

    Function GetSteamStat: Int(statName: Int)
        Debug.TraceNotImplemented("Util.GetSteamStat(Int)")
    End Function

    Function GetTimeStringFromMilliseconds: String(msecs: Int, secondsOnly: Bool, padSeconds: Bool)
        Debug.TraceNotImplemented("Util.GetTimeStringFromMilliseconds(Int, Bool, Bool)")
    End Function

    Function GetVersionString: String()
        Const MAJOR_VERSION: Int = 2
        Const MINOR_VERSION: Int = 59

        Local versionStr := "v" + MAJOR_VERSION + "." + MINOR_VERSION

        If necrodancer.DEBUG_BUILD
            versionStr += "_DEBUG"
        End If

        Return versionStr
    End Function

    Function HasLeaderboardDownloaded: Bool()
        Debug.TraceNotImplemented("Util.HasLeaderboardDownloaded()")
    End Function

    Function IncrementSteamStat: Bool(statName: String, inGameplayOnly: Bool = True, allowCoop: Bool = False, allowSeeded: Bool = False, delayUntilLevelLoad: Bool = False)
        Debug.TraceNotImplemented("Util.IncrementSteamStat(String, Bool, Bool, Bool, Bool)")
    End Function

    Function InvertDir: Int(dir: Int)
        Local inverted := Direction.None

        Select dir
            Case Direction.Up
                inverted = Direction.Down
            Case Direction.Down
                inverted = Direction.Up
            Case Direction.Left
                inverted = Direction.Right
            Case Direction.Right
                inverted = Direction.Left
            Case Direction.UpLeft
                inverted = Direction.DownRight
            Case Direction.UpRight
                inverted = Direction.DownLeft
            Case Direction.DownLeft
                inverted = Direction.UpRight
            Case Direction.DownRight
                inverted = Direction.UpLeft
        End Select

        Return inverted
    End Function

    Function IsAnyPlayerAt: Bool(xVal: Int, yVal: Int)
        For Local i := 0 Until controller_game.numPlayers
            Local player := controller_game.players[i]

            If player.Perished() Then Continue

            If player.x = xVal And
               player.y = yVal
                Return True
            End If
        End For

        Return False
    End Function

    Function IsBomblessCharacterActive: Bool()
        'For Local i := 0 Until controller_game.numPlayers
        '    Local player := controller_game.players[i]
        '    If player <> Null And
        '       player.IsBomblessCharacter()
        '        Return True
        '    End If
        'End For
        '
        'Return False
        return game_controller.activeCharacterTypes & (1 Shl Character.Eli)
    End Function

    Function IsCharacterActive: Bool(charID: Int)
        'For Local i := 0 Until controller_game.numPlayers
        '    Local player := controller_game.players[i]
        '    If player And player.characterID = charID Then Return True
        'End For
        '
        'Return False
        return (controller_game.activeCharacterTypes & (1 Shl charID)) <> 0
    End Function

    Function IsEnemyAdjacent: Bool(xVal: Int, yVal: Int)
        Debug.TraceNotImplemented("Util.IsEnemyAdjacent(Int, Int)")
    End Function

    Function IsGlobalCollisionAt: Bool(xVal: Int, yVal: Int, isPlayer: Bool, ignoreWalls: Bool, includeShopWallsDespiteIgnoringWalls: Bool, skipIgnoreWalls: Bool)
        Return Util.IsGlobalCollisionAt(xVal, yVal, isPlayer, ignoreWalls, False, includeShopWallsDespiteIgnoringWalls, skipIgnoreWalls)
    End Function

    Function IsGlobalCollisionAt: Bool(xVal: Int, yVal: Int, isPlayer: Bool, ignoreWalls: Bool, includeTheNothing: Bool, includeShopWallsDespiteIgnoringWalls: Bool, skipIgnoreWalls: Bool)
        If includeTheNothing And
           Level.GetTileAt(xVal, yVal) = Null
            Return True
        End If

        If includeShopWallsDespiteIgnoringWalls
            Select Level.GetTileTypeAt(xVal, yVal)
                Case TileType.ShopWall,
                     TileType.UnbreakableWall,
                     TileType.BossWall
                    Return True
            End Select
        End If

        For Local renderableObj := EachIn RenderableObject.renderableObjectList
            If renderableObj.collides
                If renderableObj.isPlayer And Player(renderableObj).Perished() Then Continue
                If isPlayer And renderableObj.playerOverrideCollide Then Continue

                If ignoreWalls
                    Local tile := Tile(renderableObj)
                    If tile <> Null And tile.GetType() = TileType.IndestructibleBorder Then Continue
                End If

                If skipIgnoreWalls
                    Local entity := Entity(renderableObj)
                    If entity <> Null And entity.ignoreWalls Then Continue
                End If

                If (renderableObj.x <= xVal And xVal < renderableObj.x + renderableObj.width) And
                   (renderableObj.y <= yVal And yVal < renderableObj.y + renderableObj.height)
                    Return True
                End If
            End If
        End For

        Return False
    End Function

    Function IsNonMobileCollisionAt: Bool(xVal: Int, yVal: Int)
        Debug.TraceNotImplemented("Util.IsNonMobileCollisionAt(Int, Int)")
    End Function

    Function IsOnScreen: Bool(xVal: Int, yVal: Int, cameraSeekX: Float, cameraSeekY: Float)
        Local yDiff := yVal - (cameraSeekY / 24.0)
        Local fixedHeight := Camera.GetFixedHeight()

        If (fixedHeight / -48) - 1 > yDiff
            Return False
        End If

        If (fixedHeight / 48) + 1 < yDiff
            Return False
        End If

        Local xDiff := xVal - (cameraSeekX / 24.0)
        Local fixedWidth := Camera.GetFixedWidth()

        If (fixedWidth / -48) - 1 > xDiff
            Return False
        End If

        If (fixedWidth / 48) + 1 < xDiff
            Return False
        End If

        Return True
    End Function

    Function IsWeaponlessCharacterActive: Bool()
        'For Local i := 0 Until controller_game.numPlayers
        '    Local player := controller_game.players[i]
        '    If player.IsWeaponlessCharacter() Then Return True
        'End For
        '
        'Return False
        'Weaponless characters are Melody, Aria, Eli, Dove, Coda
        Local weaponlessMask = (1 Shl Character.Melody) | (1 Shl Character.Aria) | (1 Shl Character.Eli) | (1 Shl Character.Dove) | (1 Shl Character.Coda)
        return (controller_game.activeCharacterTypes & weaponlessMask) <> 0
    End Function

    ' TODO: Figure out what's actually going on in this function.
    Function LineSegmentTileIntersect: Bool(p0_x: Float, p0_y: Float, p1_x: Float, p1_y: Float, p2_x: Float, p2_y: Float)
        Local p3_x := p2_x + 1.0
        Local p3_y := p2_y + 1.0

        Local scaled_p0_x := p0_x * 24.0
        Local scaled_p1_x := p1_x * 24.0
        Local scaled_p2_x := p2_x * 24.0
        Local scaled_p3_x := p3_x * 24.0

        Local xMax := math.Max(scaled_p0_x, scaled_p1_x)
        Local xMin := math.Min(scaled_p0_x, scaled_p1_x)
        Local x2Min := math.Min(xMax, scaled_p3_x)
        Local x3Max := math.Max(xMin, scaled_p2_x)

        If x3Max > x2Min
            Return False
        End If

        Local scaled_p0_y := p0_y * 24.0
        Local scaled_p1_y := p1_y * 24.0
        Local scaled_p2_y := p2_y * 24.0
        Local scaled_p3_y := p3_y * 24.0

        Local xDiff := scaled_p1_x - scaled_p0_x
        Local yDiff := scaled_p1_y - scaled_p0_y

        Local v29: Float
        Local v30: Float

        If math.Abs(xDiff) > 0.0000001
            Local v38 := yDiff / xDiff
            Local v39 := scaled_p0_x * v38
            v29 = x3Max * v38 + scaled_p0_y - scaled_p0_x * v38
            v30 = scaled_p0_y - v39 + v38 * x2Min
        Else
            v29 = scaled_p0_y
            v30 = scaled_p1_y
        End If

        If v29 > v30
            Local v31 := v29
            v29 = v30
            v30 = v31
        End If

        Local v35 := math.Min(v30, scaled_p3_y)
        Local v37 := math.Max(v29, scaled_p2_y)

        Return v37 <= v35
    End Function

    Function ParseTextSeed: Int(randSeedString: String)
        Local seed := 0

        For Local i := 1 Until randSeedString.Length
            seed += i * randSeedString[i - 1]
        End For

        For Local j := 0 Until randSeedString.Length
            If randSeedString[j] > input.KEY_9 Then Return seed
        End For

        seed = 0
        For Local k := 0 Until randSeedString.Length
            seed = (10 * seed) + (randSeedString[k] - input.KEY_0)
        End For

        Return seed
    End Function

    Function ProcessDelayedStats: Void()
        Debug.TraceNotImplemented("Util.ProcessDelayedStats()")
    End Function

    Function Pump: Void()
        Debug.TraceNotImplemented("Util.Pump()")
    End Function

    Function RndBool: Bool(useSeed: Bool)
        Return Util.RndIntRangeFromZero(1, useSeed) = 0.0
    End Function

    Function RndFloatRange: Float(low: Float, high: Float, useSeed: Bool)
        If useSeed
            If Util.storedSeed <> -1
                random.Seed = Util.storedSeed
                Util.storedSeed = -1
            End If
        Else
            Util.storedSeed = random.Seed
        End If

        Return random.Rnd(low, high)
    End Function

    Function RndIntRange: Int(low: Int, high: Int, useSeed: Bool, replayConsistencyChannel: Int = -1)
        Local value: Int = math.Floor(Util.RndFloatRange(low, high + 1, useSeed))
        value = math.Clamp(value, low, high)

        If replayConsistencyChannel >= 0
            If Level.isReplaying
                If Not Level.creatingMap
                    value = Level.replay.GetRand(replayConsistencyChannel)

                    If value < low Or
                       value > high
                        Return low
                    End If
                End If
            Else
                If Level.replay
                    Level.replay.RecordRand(replayConsistencyChannel, value)
                End If
            End If
        End If

        Return value
    End Function

    Function RndIntRangeFromZero: Int(high: Int, useSeed: Bool)
        Return RndIntRange(0, high, useSeed, -1)
    End Function

    Function RotateDirInDirection: Int(original: Int, dir: Int)
        Debug.TraceNotImplemented("Util.RotateDirInDirection(Int, Int)")
    End Function

    Function RotatePoint45DegreesClockwise: Object(p: Object)
        Debug.TraceNotImplemented("Util.RotatePoint45DegreesClockwise(Object)")
    End Function

    Function RotatePointInDirection: Object(original: Object, dir: Int)
        Debug.TraceNotImplemented("Util.RotatePointInDirection(Object, Int)")
    End Function

    Function RotatePointInGeneralDirection: Object(p: Object, dir: Int)
        Debug.TraceNotImplemented("Util.RotatePointInGeneralDirection(Object, Int)")
    End Function

    Function SeedRnd: Void(seed: Int)
        Util.storedSeed = -1
        random.Seed = seed
    End Function

    Function SegmentSegmentIntersection: Object(p0_x: Float, p0_y: Float, p1_x: Float, p1_y: Float, p2_x: Float, p2_y: Float, p3_x: Float, p3_y: Float)
        Debug.TraceNotImplemented("Util.SegmentSegmentIntersection(Float, Float, Float, Float, Float, Float, Float, Float)")
    End Function

    Function SendEntityTo: Void(ent: Entity, xVal: Int, yVal: Int, triggerBossStart: Bool)
        If ent.isPlayer And
           triggerBossStart And
           controller_game.currentLevel = 4
            Level.ActivateTrigger(1, Null, Null)
        End If

        If ent.isPlayer
            Local player := Player(ent)
            player.WarpTo(xVal, yVal)

            If player.clampedEnemy <> Null
                Util.SendEntityTo(player.clampedEnemy, xVal, yVal, True)
            End If
        Else
            ent.lastX = ent.x
            ent.x = xVal
            ent.lastY = ent.y
            ent.y = yVal
        End If

        ent.wasTeleported = True
    End Function

    Function SetAppFolder: Void()
        Local appPath := os.AppPath()

        appPath = Util.StringLeft(appPath, appPath.FindLast(".app"))
        appPath = Util.StringLeft(appPath, appPath.FindLast("/"))
        appPath += "/"

        util.globalAppFolder = appPath
    End Function

    Function SetSteamIntStat: Bool(statName: String, val: Int, inGameplayOnly: Bool, allowCoop: Bool, delayUntilLevelLoad: Bool)
        Debug.TraceNotImplemented("Util.SetSteamIntStat(String, Int, Bool, Bool, Bool)")
    End Function

    Function SongNameSoundtrackId: Int(songName: Int)
        Debug.TraceNotImplemented("Util.SongNameSoundtrackId(Int)")
    End Function

    Function StringLeft: String(str: String, n: Int)
        n = math.Min(n, str.Length)

        Return str[..n]
    End Function

    Function SubmitDailyHardcoreScore: Void(score: Int, z: Int, l: Int, suffix: Int, killedBy: Int, replayData: Int)
        Debug.TraceNotImplemented("Util.SubmitDailyHardcoreScore(Int, Int, Int, Int, Int, Int)")
    End Function

    Function SubmitHardcoreScore: Void(score: Int, z: Int, l: Int, suffix: Int, killedBy: Int, replayData: Int)
        Debug.TraceNotImplemented("Util.SubmitHardcoreScore(Int, Int, Int, Int, Int, Int)")
    End Function

    Function SubmitModeScore: Void(mode: Int, score: Int, z: Int, l: Int, suffix: Int, killedBy: Int, replayData: Int)
        Debug.TraceNotImplemented("Util.SubmitModeScore(Int, Int, Int, Int, Int, Int, Int)")
    End Function

    Function SubmitSeededScore: Void(score: Int, z: Int, l: Int, suffix: Int, killedBy: Int, replayData: Int)
        Debug.TraceNotImplemented("Util.SubmitSeededScore(Int, Int, Int, Int, Int, Int)")
    End Function

    Function SubmitSeededSpeedrunScore: Void(score: Int, z: Int, l: Int, suffix: Int, killedBy: Int, replayData: Int)
        Debug.TraceNotImplemented("Util.SubmitSeededSpeedrunScore(Int, Int, Int, Int, Int, Int)")
    End Function

    Function SubmitSpeedrunScore: Void(score: Int, z: Int, l: Int, suffix: Int, killedBy: Int, replayData: Int)
        Debug.TraceNotImplemented("Util.SubmitSpeedrunScore(Int, Int, Int, Int, Int, Int)")
    End Function

    Function TeleportEntity: Bool(ent: Entity, minDist: Float, oldX: Int, oldY: Int, anyFloor: Bool)
        If ent.isPlayer And
           controller_game.currentLevel = 4
            Level.ActivateTrigger(1, Null, Null)
        End If

        If Level.isReplaying
            Local x := Level.replay.GetRand(1)
            Local y := Level.replay.GetRand(1)

            If x = -999 Or
               y = -999
                Return False
            End If

            Util.SendEntityTo(ent, x, y, True)

            If ent.isPlayer
                Audio.PlayGameSound("teleport", -1, 1.0)
            Else
                Audio.PlayGameSoundAt("teleport", x, y, False, -1, False)
                Audio.PlayGameSoundAt("teleport", oldX, oldY, False, -1, False)
            End If

            Return True
        End If

        Local i := 5000
        For i = i - 1 Until 0 Step -1
            Local x := Util.RndIntRange(Level.minLevelX, Level.maxLevelX, False)
            Local y := Util.RndIntRange(Level.minLevelY, Level.maxLevelY, False)

            If x < -150 Or
               y < -150
                Continue
            End If

            If i Mod 1000 = 0
                minDist -= 1.0
            End If

            If minDist <= Util.GetDist(x, y, oldX, oldY) And
               (Level.IsNormalFloorAt(x, y) Or
                (anyFloor And Level.IsFloorAt(x, y))) And
               Not Util.IsGlobalCollisionAt(x, y, False, False, False, False)
                If ent.isPlayer
                    If Not Trap.IsLiveTrapAt(x, y) And
                       Item.GetPickupAt(x, y) = Null And
                       (controller_game.numPlayers <= 1 Or
                        Camera.IsOnScreen(x, y))
                        Util.SendEntityTo(ent, x, y, True)
                        Audio.PlayGameSound("teleport", -1, 1.0)

                        Level.RecordRand(1, x)
                        Level.RecordRand(1, y)

                        Return True
                    End If
                Else If Util.GetDistFromClosestPlayer(x, y, False) >= 3.0 Or
                        i < 1000
                    Util.SendEntityTo(ent, x, y, True)
                    Audio.PlayGameSoundAt("teleport", x, y, False, -1, False)
                    Audio.PlayGameSoundAt("teleport", oldX, oldY, False, -1, False)

                    Level.RecordRand(1, x)
                    Level.RecordRand(1, y)

                    Return True
                End If
            End If
        End For

        Return False
    End Function

    Function _EditorFix: Void() End

End Class

Class HighScoreSubmission

    Function _EditorFix: Void() End

    Method New(s: Int, z: Int, l: Int, lb: Int, sa: Int, dt: Int)
        Debug.TraceNotImplemented("HighScoreSubmission.New(Int, Int, Int, Int, Int, Int)")
    End Method

    Field pendingSubmitLeaderboard: String
    Field submissionAttemptNumber: Int
    Field submitted: Bool
    Field pendingSubmitScore: Int
    Field pendingSubmitZone: Int
    Field pendingSubmitLevel: Int
    Field data: String

End Class

Class Direction

    Const None: Int = -1

    Const MinCardinalDirection: Int = 0
    Const MaxCardinalDirection: Int = 3
    Const Right: Int = 0
    Const Down: Int = 1
    Const Left: Int = 2
    Const Up: Int = 3

    Const MinDiagonalDirection: Int = 4
    Const MaxDiagonalDirection: Int = 7
    Const DownRight: Int = 4
    Const DownLeft: Int = 5
    Const UpLeft: Int = 6
    Const UpRight: Int = 7

End Class

Function CalcChecksum: Int(fileContents: String)
    Debug.TraceNotImplemented("CalcChecksum(String)")

    Return gamedata.NECRODANCER_XML_CHECKSUM
End Function

Function SetVSync: Void(v: Int)
    Debug.TraceNotImplemented("SetVSync(Int)")
End Function

Extern

Global globalAppFolder: String

Function GetAppFolder: String()
