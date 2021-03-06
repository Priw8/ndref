Strict

Import monkey.stack
Import util

Class StackEx<T> Extends Stack<T>

    Function _EditorFix: Void() End

    Method ChooseRandom: T(useSeed: Bool)
        Local randomIndex := Util.RndIntRangeFromZero(Self.Length - 1, useSeed)

        Return Self.Get(randomIndex)
    End Method

    Method Extend: Void(other: StackEx<T>)
        For Local item := EachIn other
            Self.Push(item)
        End For
    End Method

    Method Shuffle: Void(useSeed: Bool)
        For Local i := 1 Until Self.Length
            Local randomValue := Util.RndIntRangeFromZero(i, useSeed)
            If i <> randomValue
                Local value_at_i := Self.Get(i)
                Local value_at_randomValue := Self.Get(randomValue)

                Self.Set(i, value_at_randomValue)
                Self.Set(randomValue, value_at_i)
            End If
        End For
    End Method

End
