; Toggle for showing tooltips (set to true to show tooltips, false to hide them)
showTooltips := false

; Define the key to be sent
keyToSend := "k"  ; Replace 'k' with the desired key

; Define the X and Y coordinates for three areas
Coords := {1: {x: 74, y: 53}, 2: {x: 209, y: 51}, 3: {x: 199, y: 51}}

; Define the acceptable color values for each area
acceptableColors := {1: ["0xF0E"], 2: ["0xE5E", "0x393"], 3: ["0x5B5", "0x393"]}

; Start an infinite loop
Loop
{
    SetTitleMatchMode, 2
    if WinActive("by Cfx.re -")
    {
        ; Initialize variables
        colors := []
        TooltipText := ""
        allColorsMatch := true

        ; Check colors for each area
        Loop, 3
        {
            coord := Coords[A_Index]
            PixelGetColor, color, % coord.x, % coord.y, RGB
            SubColor := SubStr(color, 3, 3)  ; Get the first 3 characters of the RGB part
            colors[A_Index] := SubColor
            expectedColors := JoinColors(acceptableColors[A_Index])
            matchStatus := IsColorInRange(SubColor, acceptableColors[A_Index])
            allColorsMatch := allColorsMatch && matchStatus
            matchText := matchStatus ? "Match" : "No Match"
            TooltipText .= "Area " A_Index ": " SubColor " (Expected: " expectedColors ") (Match: " matchText ")`n"
        }

        ; Display tooltip with color values and match status
        if (showTooltips)
        {
            Tooltip, %TooltipText%, 5, 100
            Sleep, 2000
        }

        if (allColorsMatch)
        {
            if (showTooltips)
            {
                Tooltip, "All colors match. Attempting to send key: " . keyToSend, 400, 300
                Sleep, 2000
            }
            SendKey(keyToSend)
        }
        else if (showTooltips)
        {
            Tooltip, "Not all colors match.", 400, 300
            Sleep, 2000
        }
    }
    else if (showTooltips)
    {
        Tooltip, "Target window not active.", 400, 300
        Sleep, 2000
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
    if (showTooltips)
    {
        Tooltip, "Pressed key: " . key, 400, 300  ; Ensure proper concatenation of the 'key' variable with the string
        Sleep, 3000
        Tooltip  ; This hides the tooltip
    }
}
