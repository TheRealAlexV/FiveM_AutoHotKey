; Define the X and Y coordinates for three areas

area1X := 74
area1Y := 53

area2X := 209
area2Y := 51

area3X := 199
area3Y := 51

; Start an infinite loop
Loop
{
    ; Set the title match mode to 2 (a window's title can contain WinTitle anywhere inside it to be a match)
    SetTitleMatchMode, 2

    ; Check if the active window's title contains "by Cfx.re -"
    if WinActive("by Cfx.re -")
    {
        ; Get the color of the pixel at the specified coordinates for each area
        PixelGetColor, Color1, %area1X%, %area1Y%
        PixelGetColor, Color2, %area2X%, %area2Y%
        PixelGetColor, Color3, %area3X%, %area3Y%

        ; Extract the first 5 characters from each color value
        ColorSubStr1 := SubStr(Color1, 1, 5)
        ColorSubStr2 := SubStr(Color2, 1, 5)
        ColorSubStr3 := SubStr(Color3, 1, 5)

        ; Uncomment below to Display a tooltip with the color values at the specified screen coordinates
        ;kToolTip %Color1% %Color2% %Color3%, 5, 100

        ; If the color values for the first two areas are within a certain range, and the color value for the third area is not within a different range
        if (((ColorSubStr1 = 0xF1E) or (ColorSubStr1 = 0xDBE) or (ColorSubStr1 = 0xE4E) or (ColorSubStr1 = 0xE4D) or (ColorSubStr1 = 0xE9E)) and ((ColorSubStr2 = 0xDBE) or (ColorSubStr2 = 0x3A3) or (ColorSubStr2 = 0xE4E) or (ColorSubStr2 = 0xE4D) or (ColorSubStr2 = 0xE9E) or (ColorSubStr3 = 0x373) or (ColorSubStr3 = 0x323) or (ColorSubStr3 = 0x343) or (ColorSubStr3 = 0x313) or (ColorSubStr3 = 0x3C3) or (ColorSubStr3 = 0x383)))
        {
            ; Send the "b" key down event, wait for 50 milliseconds, then send the "b" key up event
            Send {k down}
            Sleep, 50
            Send {k up}

            ; Wait for 1000 milliseconds (1 second)
            Sleep, 200
        }
    }

    ; Wait for 1000 milliseconds (1 second) before the next iteration of the loop
    Sleep, 200
}