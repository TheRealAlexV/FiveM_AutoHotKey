; Toggle for showing tooltips (set to true to show tooltips, false to hide them)
showTooltips := true

; Define the key to be sent
keyToSend := "b"  ; Replace with the desired key

; Define the X and Y coordinates for three areas
Coords := {1: {x: 2303, y: 1201}, 2: {x: 2279, y: 1357}}

; Define the acceptable color values for each area
acceptableColors := { 1: ["0x33C"], 2: ["0x329", "0x339"]}

; Start an infinite loop
Loop
{
    SetTitleMatchMode, 2
    if WinActive("by Cfx.re -")
    {
        ; Initialize variables
        colors := []
        TooltipText := ""
        colorMatchForFirst := false
        colorMismatchForSecond := true

        ; Check colors for each of the two areas
        Loop, 2
        {
            coord := Coords[A_Index]
            PixelGetColor, color, % coord.x, % coord.y, RGB
            SubColor := SubStr(color, 3, 3)  ; Get the first 3 characters of the RGB part
            colors[A_Index] := SubColor
            expectedColors := JoinColors(acceptableColors[A_Index])
            matchStatus := IsColorInRange(SubColor, acceptableColors[A_Index])
            
            if (A_Index = 1)
                colorMatchForFirst := matchStatus
            if (A_Index = 2 && matchStatus)
                colorMismatchForSecond := false

            matchText := matchStatus ? "Match" : "No Match"
            TooltipText .= "Area " A_Index ": " SubColor " (Expected: " expectedColors ") (Match: " matchText ")`n"
        }

        ; Display tooltip with color values and match status
        if (showTooltips)
        {
            Tooltip, %TooltipText%, 0, 0
        }

        ; Check if conditions are met (match for first, mismatch for second)
        if (colorMatchForFirst && colorMismatchForSecond)
        {
            SendKey(keyToSend)
        }
    }
    Sleep, 200
}

JoinColors(colorsArray)
{
    result := ""
    for index, color in colorsArray
    {
        if (index != 1)
            result .= ", "
        result .= color
    }
    return result
}

IsColorInRange(color, acceptableColors)
{
    for index, accColor in acceptableColors
    {
        if (color = SubStr(accColor, 3, 3))
            return true
    }
    return false
}

SendKey(key)
{
    Send, %key%
}
