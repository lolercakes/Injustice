;Injustice: The Game

;Character catagories will include: race, sex, hetero/homo, socio-economic status, mental disorder, parents own house
;Flags: High School diploma, own car, rent, own home, Diabetic, Overweight, starving, homeless
;Possible events: job/raise/fired, married/divorced, suicide, childbirth, SIDS, accidents, crime, sick, PTSD, Sudden death (anyerism), kid needs braces, Buy a house, robbed, parents dead, 
;				  Required to move, get a car, calamity on house, 
;Character values: happiness, Wealth, Health, Stress Capacity, Age, Close Friends
;Last turn Change: Breakdown, 
;Character traits: Happy/Sad, Vitalous/Sickly, Stress ability, Spendy/Spendthrift, Mental disorder
;Temp traits: Young child, Layoffs at work, In debt, Retirement, 

Age=018
setformat, float, .2

;Enter Name

gui, font,s10
Gui, Add, Text,, Please enter your name:
Gui, Add, Edit,  vName, ;The v stands for variable
Gui, Add, Button, x+1 Default, OK ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Show,, Injustice: The Game
return ; End of auto-execute section. The script is idle until the user does something.
ButtonOK:
Gui, Submit ; Save the input from the user to each control's associated variable.

;Disclaimer
gui, new,, Injustice: The Game
gui, font,s10
Gui, add, Text,,This simulation starts with your character %Name% just turning 18. Each turn will represent one year of life, ending when you die.
Gui, add, text,y+1,The purpose of this simulation  is to demonstrate injustices based on variables beyond a persons control, with limited player interaction.
Gui, add, text,y+1,This is not a happy simulation, outcomes are based on algorithms built using real statistics. (mostly from government studies)
Gui, add, text,y+1,There will be a results page at the end of the simulation where you may compare your simulation compared to others.
Gui, add, Button, x350 Default, Continue
gui, show
Return
ButtonContinue:
Gui, hide

;Char gen

Gui, New,,Injustice: The Game
gui, font,s10
Gui, Add, Text,, Press the button to randomly generate a person
Gui, Add, Button, x110 Default, Generate
Gui, Show
Return
ButtonGenerate:
Age=18

Random, Racenum, 1, 4
Random, Sexnum, 1, 2
Random, preferencenum, 1, 2
Random, parentssocioeconomicsnum, 1, 1000
Random, Mentaldefectnum, 1, 4
Random, Homenum, 1, 100
Random, Outlooknum, .5, 1.5
Random, Healthnum, 52, 70
Healthnum = %healthnum%.00
Random, Stressabilitynum, 80, 120
Random, Diplomanum, 1, 100
Random, Friends, 2, 4
;Trait gen
{
;Race: White, Hispanic, Black, Asian, 
if Racenum = 1 
	{
	Race = White
	}
else if Racenum = 2
	{
	Race = Black
	}
else if Racenum = 3
	{
	Race = Hispanic
	}
else
	{
	Race = Asian
	}

;Sex: Male, Female
if Sexnum = 1
	{
	Sex = Male
	}
else
	{
	Sex = Female
	}

;Sexual preference, spouse preferance
if preferencenum = 1
	{
	preference = Homosexual
	if sex = male
		{
		spouse = man
		}
	else spouse = woman
	}
else 
	{
	preference = Heterosexual
	if sex = male
		{
		spouse = woman
		}
	else spouse = man
	}
	
;Parental Home ownership
if Race = White
	{
	if Homenum <= 72 ;72% of whites own house
		{
		parenthomeown = Homeowner
		}
	else parenthomeown = Renter
	}
else if Race = Black
	{
	if Homenum <= 43 ;43% of Blacks own house
		{
		parenthomeown = Homeowner
		}
	else parenthomeown = Renter
	}
else if Race = Asian
	{
	if Homenum <= 58 ; 58% of Asian own house
		{
		parenthomeown = Homeowner
		}
	else parenthomeown = Renter
	}
else
	{
	if Homenum <= 46 ; 46% of Hispanics own house
		{
		parenthomeown = Homeowner
		}
	Else parenthomeown = Renter
	}
	
;Parents socioeconomic reality
;Parents can pay for college if more than 250 out of 1000
;Household income calc weighted

if (race = "White" or race = "Asian")
	{
	if parentssocioeconomicsnum * 2 >=250 ; Bias for White/Asian being 2X less likely to be in poverty
		{
		parentssocioeconomics = NonPoverty 
		}
	else parentssocioeconomics = Poverty
	}
else if parentssocioeconomicsnum <= 250
	{
	parentssocioeconomics = Poverty
	}
Else parentssocioeconomics = NonPoverty


;Outlook tendancy, Storyoutlook
if outlooknum > 1.25
	{
	Outlook = Very Positive
	}
else if outlooknum > 1
	{
	Outlook = Positive
	}
else if outlooknum = 1
	{
	Outlook = Nuetral
	}
else if outlooknum < .75
	{
	Outlook = Very Negative
	}
else
	{
	Outlook = Negative
	}

;High school education

if parentssocioeconomics = Poverty
	{
	if diplomanum  > 25
		{
		Diploma = Yes
		}
	else
		{
		Diploma = No
		}
	}
else
	{
	if diplomanum > 5
		{
		Diploma = Yes
		}
	else
		{
		Diploma = No
		}
	}
	
;Starting stress, happiness, wealth,

if parentssocioeconomics = Poverty
	{
	random, stressnum, 10, 20
	random, happinessnum, 50, 70
	random, wealth, 1000, 2000
	}
else 
	{
	random, happinessnum, 60, 80
	random, wealth, 5000, 20000
	random, stressnum, 00, 10
	if stressnum < 10
		{
		stressnum = 0%stressnum%
		}
	
	}
stressnum = %stressnum%.00
}

Generate:
Gui, Submit


;Story so far story variables


;story poverty
if parentssocioeconomics=Poverty
	{
	storypoverty=hardship. Your parents income putting you and your family below the poverty line.
	}
else Storypoverty=fortune. Thankful that your family had the benifit of having enough money for food and clothing, entertainments and travel.

;story parenthomeown
if parenthomeown=renter
	{
	storyparenthome=Unfortunatly, your parents do not own a home, and have been renting for as long as you can remember. Moving from one apartment to the next.
	}
else storyparenthome=Your parents are fortunate to have their own home. Having a stable housing situation has always been a boon that you will look back on fondly.

;story mental defect
if mentaldefectnum = 1
	{
	mentaldis=For as long as you have lived, you have known that people would treat you differently because you where diagnosed as having a mental disorder. 
	}

;story diploma
if diploma = yes
	{
	storydiploma=Working hard these last four years has paid off. You recently graduated from highschool and got a diploma. 
	}
else storydiploma= Lifes ups and downs have been insurmountable these last few years, leading you to drop out of highschool without getting a diploma.




;Your story so far
Gui, New,, Injustice: The Game
gui, font, s15
Gui, add, text, x220, Your Story So Far:
gui, font, s10
Gui, Add, Text,w600 x15 y+20, (You are a %race% %sex%) Finally 18 years old! %storydiploma% You look back on your years of %storypoverty% %storyparenthome% %mentaldis%Your parents have always told you that your %outlook% outlook would have an impact on how your life played out. You look forward to moving out, finding a steadfast %spouse% and becoming an amazing parent.
gui, add, button, default x285, Begin
Gui, show
Return
Buttonbegin:
gui, hide


;Building the main game page after char gen	

gui, new,, Injustice: The Game
gui, font, s10
gui, add, Text, w300 y10, %Name%
gui, add, Text, y+1,Race: %Race%
gui, add, Text, y+1,Sex: %Sex%
gui, add, Text, y10 x120,Sexual Preference: %preference%
gui, add, Text, y+1,Natural Outlook: %Outlook%
gui, add, Text, y+1 vmydiploma,High School Diploma: %Diploma%
gui, add, Text, x13 y+20 vmyage ,Age: %Age%
Gui, add, text, x+20 vmyhealth,Health: %Healthnum%/70
gui, add, text, x+90 vmyhappiness,Happiness: %happinessnum%/100
Gui, add, text, y+1 x13 vmyfriends,Friends: %Friends%
Gui, add, text, x+8 vmystress,Stress: %stressnum%/%stressabilitynum%
Gui, add, text, x+37 vmywealth,Wealth: $000%wealth%
Gui, add, text, y300, 
Gui, add, button, x135 vgotjob, Getjob
Gui, add, button, default y+1 x130, Progress
gui, show 
Return


ButtonGetjob:
random, getjobcheck, 1, 10
if %diploma% = yes ;Higher chance to get job with diploma
	{
	getjobcheck += 1
	}
if parentssocioeconomics = Poverty
	{
	if getjobcheck > 4
		{
		random, income, 5000, 12000
		hasjob = yes
		stressnum -= 5
		happinessnum +=5
		guicontrol, hide, gotjob
		if %diploma% = yes
			{
			income += 3000
			}
		if sex = female 
			{
			income := incomeinequality(income, .93)
			}
		Msgbox, You found a Job! It pays $%income% a year.
		}
	else
		{
		msgbox, You failed to find a job! This is very stressful.
		stressnum += 05.00
		}
	}
else if parentssocioeconomics = Nonpoverty
	
	if getjobcheck > 1
		{
		random, income, 14000, 24000
		hasjob = yes
		stressnum -= 5
		happinessnum +=5
		guicontrol, hide, gotjob
		if %diploma% = yes
			{
			income += 3000
			}
		if sex = female
			{
			income := incomeinequality(income, .93)
			}
		Msgbox, You found a Job! It pays $%income% a year.
		}
	else
		{
		msgbox, You failed to find a job! This is very stressful.
		stressnum += 05.00
		}

		
		
Buttonprogress:
Turn += 1
Age += 1
if housingsitch = house
	{
	yearshomeown += 1
	}
else yearshomeown = 0

;events!
random, eventchance, 1, 4 ;1 is bad, 2 is good; 3-4 is nothing


if eventchance = 1 ;bad
		
		if eventnum = 1 ;House Damage
			{
			Msgbox, AHH! A tree fell on your house and did a massive ammount of damage. ($5000 to fix, +2 stress)
			wealth -=5000
			stressnum +=2
			}
		else if eventnum = 2 ;Bugs!
			{
			msgbox, Bugs! Bugs everywhere! You must pay $3000 to fumigate the house. ($3000 fumigation, +2 stress)
			stressnum +=2
			wealth -=3000
			}
		else if eventnum = 3 ;Injury
			{
			msgbox, While walking down the street you trip on the pavement, injuring your knee, and your pride. (Hospital bills: 1000, +1 stress)
			stressnum +=1
			injury +=1
			}
		else if eventnum = 4 ;Moving
			{
			msgbox, You must relocate. Costs to do so are $2000. (Pay $2000, +4 stress)
			stressnum += 4
			wealth -= 2000
			}
		else if eventnum = 5 ;Car crash or Massive injury
			{
			if carown = yes
				{
				Msgbox, Driving home one day, you swerve to avoid a kitten. Unfortunatly you still hit the kitten, along with an light pole. Your car is totaled and you are shaken up. (Lose your car, insurance pays $4000, chance of PTSD and/or injury)
				random, injurycheck, 1, 100
				random, PTSDcheck, 1, 100
				stressnum += 2
				if injurycheck >= 50
					{
					injury += 1
					msgbox, You were injured in the crash.
					}
				if PTSDcheck <= 25
					{
					PTSD = Yes
					msgbox, you have PTSD from the crash.
					}
				carown = no
				wealth += 4000
				}
			else 
				{
				Msgbox, A car swerves to avoid an adorable kitten. Fortunatly the kitten was saved. Unfortunatly, the car hit you going 25 miles an hour. You were hit hard enough your ancestors felt it. (Terrible injury. Hospital bills: $5000)
				injury +=2
				wealth -=5000
				}
			}
		else if eventnum = 6 ;Sickness
			{
			msgbox, You catch the flu this year. It is mildly detrimental to your health. (Lose .25 health)
			healthnum -= .25
			}
		else if eventnum = 7 ;Chronic illness
			{
			msgbox, You develop a chronic illness! There is no cure. For the rest of your life it will eat away at your health. (Lose .25 health every year)
			permhealthdebuff +=.25
			health -=.25
			}
		else if eventnum = 8 ;Commit a felony
			{
			random, fellonychance, 1, 100
			if (race = "White" or race = "Asian")
				{
				if fellonychance <= 75
					{
					msgbox, You were caught committing a felony. Thankfully the lawyer you hired was able to get you off the hook. (Pay lawyer $7000)
					wealth -=7000
					}
				else 
					{
					msgbox, You were caught commiting a felony. After a lengthy court battle you were convicted of your crime. Off to prison you go, AFTER you pay your lawyer. This will have massive implications for your entire life. (Pay lawyer $7000, Chance to lose job, harder to get a new job, lower wages)
					wealth -=7000
					felonycount +=1
					random, losejobchance, 1, 2
					if losejobchance = 1
						{
						msgbox, You lost your job!
						income = 0
						hasjob = no
						}
					}
				}
			else if fellonychance <= 25
				{
				msgbox, You were caught committing a felony. Thankfully the lawyer you hired was able to get you off the hook. (Pay lawyer $7000)
				wealth -=7000
				}
				else 
				{
				msgbox, You were caught commiting a felony. After a lengthy court battle you were convicted of your crime. Off to prison you go, AFTER you pay your lawyer. This will have massive implications for your entire life. (Pay lawyer $7000, Chance to lose job, harder to get a new job, lower wages)
				wealth -=7000
				felonycount +=1
				random, losejobchance, 1, 2
				if losejobchance = 1
					{
					msgbox, You lost your job!
					income = 0
					hasjob = no
					}
				}
			}
		else if eventnum = 9
			
			
			
			
			
		
if eventchance = 2 ;good
	
	






















	
	


	
;Cost of home ownership with function def
housingsitch = house ;delete

if yearshomeown >= 30
	{
	housingcost = 0
	}
else if housingsitch = none
	{
	housingcost = 0
	}
else if income <= 20000
	{
	housingcost = 6000
	}
else if housingsitch = house 
	{
	housingcost := housingcostfunction(income,,1.2)
	}
else if housingsitch = renter
	{
	housingcost := housingcostfunction(income)
	}
housingcostfunction(x, y:=.3, z:=1) ;x is income, y is .3
	{
	return x * y * z
	}
	
	
	
	
;add income to wealth subtract costs
wealth := wealthchangefunction(wealth, income)
wealthchangefunction(x, y)
	{
	return x + y
	}



;Stress effect on health
if stressnum/stressabilitynum => 1 
	{
	healthnum -= 1
	}
else if stressnum/stressabilitynum > .75
	{
	healthnum -= .5
	}
else if stressnum/stressabilitynum > .5
	{
	healthnum -= .25
	}

if stressnum < 0 
	{
	stressnum = 00.00
	}
if (healthnum = 0 or Age = 99) ;If you are 99 or have 0hp you die
	{
	death = 1
	}

;Wealth effect on stress and health, homelessness
if wealth < -12000 
	{
	Stressnum += 5
	healthnum -= 3
	if housingsitch = house
		{
		housingsitch = None
		msgbox, You have lost your home and now live on the streets.
		Stressnum += 5
		}
	if housingsitch = renter
		{
		housingsitch = none
		msgbox, You have lost your apartment and now live on the streets.
		Stressnum += 5
		}
	}
else if wealth < -6000
	{
	Stressnum += 3
	healthnum -= 1.5
	Msgbox, Be careful. If your wealth drops below -$12000 you will become homeless.
	}
else if wealth < 0
	{
	stressnum += 2
	Msgbox, Be careful. If your wealth drops below -$12000 you will become homeless.
	}
else if wealth > 25000
	{
	stressnum -= 1
	}
	

	
;fnunction definitions
incomeinequality(a,b)
	{
	return a * b
	}
	
	
	
	
	
	
	
	
	
	

	
msgbox, Wealth:%wealth%, Income:%income%, Housingsitch:%housingsitch%, housingcost:%housingcost%


gui, submit, nohide

guicontrol,,myage,Age: %Age%
guicontrol,,myhealth,Health: %healthnum%/70
guicontrol,,mystress,Stress: %stressnum%/%stressabilitynum%
guicontrol,,myhappiness,Happiness: %happinessnum%/100
guicontrol,,mywealth,Wealth: $%wealth%
guicontrol,,mydiploma,High School Diploma: %Diploma%
guicontrol,,myfriends,Friends: %Friends%
return




Death:
GuiClose: ;Makes the x close the window
ExitApp


































; Example: Tab control:

/*
Gui, Add, Tab2,, First Tab|Second Tab|Third Tab  ; Tab2 vs. Tab requires v1.0.47.05.
Gui, Add, Checkbox, vMyCheckbox, Sample checkbox
Gui, Tab, 2
Gui, Add, Radio, vMyRadio, Sample radio1
Gui, Add, Radio,, Sample radio2
Gui, Tab, 3
Gui, Add, Edit, vMyEdit r5  ; r5 means 5 rows tall.
Gui, Tab  ; i.e. subsequently-added controls will not belong to the tab control.
Gui, Add, Button, default xm, OK  ; xm puts it at the bottom left corner.
Gui, Show
return

ButtonOK:
GuiClose:
GuiEscape:
Gui, Submit  ; Save each control's contents to its associated variable.
MsgBox You entered:`n%MyCheckbox%`n%MyRadio%`n%MyEdit%
ExitApp

*/

; Example: A simple input-box that asks for first name and last name:

/*
Gui, Add, Text,, First name:
Gui, Add, Text,, Last name:
Gui, Add, Edit, vFirstName ym  ; The ym option starts a new column of controls.
Gui, Add, Edit, vLastName
Gui, Add, Button, default, OK  ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Show,, Simple Input Example
return  ; End of auto-execute section. The script is idle until the user does something.

GuiClose:
ButtonOK:
Gui, Submit  ; Save the input from the user to each control's associated variable.
MsgBox You entered "%FirstName% %LastName%".
ExitApp

*/

; Example: On-screen display (OSD) via transparent window:

/*
CustomColor = EEAA99  ; Can be any RGB color (it will be made transparent below).
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %CustomColor%
Gui, Font, s32  ; Set a large font size (32-point).
Gui, Add, Text, vMyText cLime, XXXXX YYYYY  ; XX & YY serve to auto-size the window.
; Make all pixels of this color transparent and make the text itself translucent (150):
WinSet, TransColor, %CustomColor% 150
SetTimer, UpdateOSD, 200
Gosub, UpdateOSD  ; Make the first update immediate rather than waiting for the timer.
Gui, Show, x0 y400 NoActivate  ; NoActivate avoids deactivating the currently active window.
return

UpdateOSD:
MouseGetPos, MouseX, MouseY
GuiControl,, MyText, X%MouseX%, Y%MouseY%
return
*/

; Example: Display context-senstive help (via ToolTip) whenever the user moves the mouse over a particular control:

/*
Gui, Add, Edit, vMyEdit
MyEdit_TT := "This is a tooltip for the control whose variable is MyEdit."
Gui, Add, DropDownList, vMyDDL, Red|Green|Blue
MyDDL_TT := "Choose a color from the drop-down list."
Gui, Add, Checkbox, vMyCheck, This control has no tooltip.
Gui, Show
OnMessage(0x200, "WM_MOUSEMOVE")
return

WM_MOUSEMOVE()
{
    static CurrControl, PrevControl, _TT  ; _TT is kept blank for use by the ToolTip command below.
    CurrControl := A_GuiControl
    If (CurrControl <> PrevControl and not InStr(CurrControl, " "))
    {
        ToolTip  ; Turn off any previous tooltip.
        SetTimer, DisplayToolTip, 1000
        PrevControl := CurrControl
    }
    return

    DisplayToolTip:
    SetTimer, DisplayToolTip, Off
    ToolTip % %CurrControl%_TT  ; The leading percent sign tell it to use an expression.
    SetTimer, RemoveToolTip, 3000
    return

    RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return
}


GuiClose:
ExitApp

*/

; Example: Simple text editor with menu bar.

/*

; Create the sub-menus for the menu bar:
Menu, FileMenu, Add, &New, FileNew
Menu, FileMenu, Add, &Open, FileOpen
Menu, FileMenu, Add, &Save, FileSave
Menu, FileMenu, Add, Save &As, FileSaveAs
Menu, FileMenu, Add  ; Separator line.
Menu, FileMenu, Add, E&xit, FileExit
Menu, HelpMenu, Add, &About, HelpAbout

; Create the menu bar by attaching the sub-menus to it:
Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu

; Attach the menu bar to the window:
Gui, Menu, MyMenuBar

; Create the main Edit control and display the window:
Gui, +Resize  ; Make the window resizable.
Gui, Add, Edit, vMainEdit WantTab W600 R20
Gui, Show,, Untitled
CurrentFileName =  ; Indicate that there is no current file.
return

FileNew:
GuiControl,, MainEdit  ; Clear the Edit control.
return

FileOpen:
Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFile, SelectedFileName, 3,, Open File, Text Documents (*.txt)
if SelectedFileName =  ; No file selected.
    return
Gosub FileRead
return

FileRead:  ; Caller has set the variable SelectedFileName for us.
FileRead, MainEdit, %SelectedFileName%  ; Read the file's contents into the variable.
if ErrorLevel
{
    MsgBox Could not open "%SelectedFileName%".
    return
}
GuiControl,, MainEdit, %MainEdit%  ; Put the text into the control.
CurrentFileName = %SelectedFileName%
Gui, Show,, %CurrentFileName%   ; Show file name in title bar.
return

FileSave:
if CurrentFileName =   ; No filename selected yet, so do Save-As instead.
    Goto FileSaveAs
Gosub SaveCurrentFile
return

FileSaveAs:
Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFile, SelectedFileName, S16,, Save File, Text Documents (*.txt)
if SelectedFileName =  ; No file selected.
    return
CurrentFileName = %SelectedFileName%
Gosub SaveCurrentFile
return

SaveCurrentFile:  ; Caller has ensured that CurrentFileName is not blank.
IfExist %CurrentFileName%
{
    FileDelete %CurrentFileName%
    if ErrorLevel
    {
        MsgBox The attempt to overwrite "%CurrentFileName%" failed.
        return
    }
}
GuiControlGet, MainEdit  ; Retrieve the contents of the Edit control.
FileAppend, %MainEdit%, %CurrentFileName%  ; Save the contents to the file.
; Upon success, Show file name in title bar (in case we were called by FileSaveAs):
Gui, Show,, %CurrentFileName%
return

HelpAbout:
Gui, About:+owner1  ; Make the main window (Gui #1) the owner of the "about box".
Gui +Disabled  ; Disable main window.
Gui, About:Add, Text,, Text for about box.
Gui, About:Add, Button, Default, OK
Gui, About:Show
return

AboutButtonOK:  ; This section is used by the "about box" above.
AboutGuiClose:
AboutGuiEscape:
Gui, 1:-Disabled  ; Re-enable the main window (must be done prior to the next step).
Gui Destroy  ; Destroy the about box.
return

GuiDropFiles:  ; Support drag & drop.
Loop, Parse, A_GuiEvent, `n
{
    SelectedFileName = %A_LoopField%  ; Get the first file only (in case there's more than one).
    break
}
Gosub FileRead
return

GuiSize:
if ErrorLevel = 1  ; The window has been minimized.  No action needed.
    return
; Otherwise, the window has been resized or maximized. Resize the Edit control to match.
NewWidth := A_GuiWidth - 20
NewHeight := A_GuiHeight - 20
GuiControl, Move, MainEdit, W%NewWidth% H%NewHeight%
return

FileExit:     ; User chose "Exit" from the File menu.
GuiClose:  ; User closed the window.
ExitApp

*/