; Define the X and Y coordinates for three areas
; Seatbelt Alarm Icon - Head
area1X := 596
area1Y := 1303
; Seatbelt Alarm Icon - Body
area2X := 592
area2Y := 1317
; Seatbelt On Indicator - Seatbelt icon with Purple bar when using "Badge" Icon Shape under 'I' Settings.
area3X := 387
area3Y := 1422

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
        ; ToolTip %ColorSubStr1% %ColorSubStr2% %ColorSubStr3%, 30, 30

        ; If the color values for the first two areas are within a certain range, and the color value for the third area is not within a different range
        if (((ColorSubStr1 = 0x025) or (ColorSubStr1 = 0x024) or (ColorSubStr1 = 0x026)) and ((ColorSubStr2 = 0x025) or (ColorSubStr2 = 0x024) or (ColorSubStr2 = 0x026)) and ((ColorSubStr3 != 0xFF2) or (ColorSubStr3 != 0xFF3) or (ColorSubStr3 != 0xFF4)))
        {
            ; Send the "b" key down event, wait for 50 milliseconds, then send the "b" key up event
            Send {b down}
            Sleep, 50
            Send {b up}

            ; Wait for 1000 milliseconds (1 second)
            Sleep, 1000
        }
    }

    ; Wait for 1000 milliseconds (1 second) before the next iteration of the loop
    Sleep, 1000
}