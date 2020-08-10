#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include JSON.AHK

;Predetermined variables
PkmImage =0000.png


;The GUI
Gui, Add, Button, gTestButton x20 y720 w50 h50, Test
Gui, Add, Button, gTestButton2 x90 y720 w50 h50, Test2
Gui, Add, Tab2, x12 y19 w920 h700 , PokeDex|Scheme
Gui, Tab, PokeDex
Gui, Add, Picture, x20 y80 w220 h220 vPkmImageControl, %A_WorkingDir%\Media\Pokemons\Images\%PkmImage%
Gui, Add, ComboBox, gChoosePkm vID x40 y50 w150 h300 , 1|2|3|4|5|6|7|8|9|10|11|
Gui, Add, Text, x20 y500 w200 h20 vAbility, Ability:
Gui, Add, Text, x20 y520 w200 h20 vEvolution, Evolution:
Gui, Add, Text, x20 y540 w200 h20 vEggGrp, Egg Group(s):
Gui, Show, w950 h800, PokeMMO Utility
return


;Everything else
ChoosePkm:
	Gui, Submit, NoHide
	FileRead, PkmFile, %A_WorkingDir%\DexData\%ID%.json
	PokeID := JSON.load(PkmFile)
	abi .= PokeID.abilities[1].name
	evo .= PokeID.evolutions[1].name
	evolvl .= PokeID.evolutions[1].val
	if (evo ="")
	{
		evo :="None"
	}
	egg_grp1 .= PokeID.egg_groups[1]
	egg_grp2 .= PokeID.egg_groups[2]
	PkmImage =%ID%.png
	GuiControl, text, EggGrp, Egg Group(s): %egg_grp1% %egg_grp2%
	GuiControl, text, Ability, Ability: %abi%
    GuiControl, text, Evolution, Evolution: %evo% at level %evolvl%
	GuiControl,, PkmImageControl, %A_WorkingDir%\Media\Pokemons\Images\%PkmImage%
	abi :=""
	evo :=""
	evolvl :=""
	egg_grp1 :=""
	egg_grp2 :=""
; msgbox, % "ID Variable:" ID "PokeID Variable:" PokeID
return

TestButton:
egg_grp1 .= PokeID.egg_groups[1]
egg_grp2 .= PokeID.egg_groups[2]
msgbox % egg_grp1 " - " egg_grp2
egg_grp1 :=""
egg_grp2 :=""
return

TestButton2:
for k, v in bulba.abilities
    for key, value in v
        abi .= key "`t" value "`r`n"
GuiControl,, Ability, Ability: %abi% 
abi :=""
return

GuiClose:
ExitApp