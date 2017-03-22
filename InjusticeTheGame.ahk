;Injustice: The Game

Age=18
setformat, float, 8.2

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
;default values
Age=18
permhealthdebuff = 0
eventhappiness = 0
eventhealth = 0
eventcost = 0
income = 0
eventwealth = 0
diplomaincome := 0
graduateincome := 0
collegeyears :=0
hasspouse = no
childcount = 0
wealthdivorcemod = 1
housingsitch = renter
yearshomeown = 0

;generated values
Random, Racenum, 1, 4
Random, Sexnum, 1, 2
Random, preferencenum, 1, 2
Random, parentssocioeconomicsnum, 1, 1000
Random, Homenum, 1, 100
Random, Healthnum, 52.00, 70.00
Random, Stressabilitynum, 80, 120
Random, Diplomanum, 1, 100
random, stressnum, 0.00, 10.00
random, happinessnum, 25.00, 075.00

;Trait gen

;Race: White, Hispanic, Black, Asian, 
if Racenum = 1 
	{
	Race = White
	racialincomebias := 1
	}
else if Racenum = 2
	{
	Race = Black
	racialincomebias := .6
	}
else if Racenum = 3
	{
	Race = Hispanic
	racialincomebias := .7
	}
else
	{
	Race = Asian
	racialincomebias := 1.2
	}

;Sex: Male, Female
if Sexnum = 1
	{
	Sex = Male
	sexincomebias := 1
	}
else
	{
	Sex = Female
	sexincomebias := .97
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
	
if (%race% = White or %race% = Asian)
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

;High school education

if parentssocioeconomics = Poverty
	{
	if diplomanum  > 25
		{
		hasDiploma := "Diploma"
		}
	else
		{
		hasDiploma := "Diplomaless"
		}
	}
else
	{
	if diplomanum > 5
		{
	hasDiploma := "Diploma"
		}
	else
		{
		hasDiploma := "Diplomaless"
		}
	}
hasdiploma := "Diplomaless" ;delete

;Starting stress, happiness, wealth,

if parentssocioeconomics = Poverty
	{
	random, stressnum, 010.00, 020.00
	random, happinessnum, 050.00, 070.00
	random, wealth, 0005000.00, 0010000.00
	}
else 
	{
	random, happinessnum, 060.00, 080.00
	random, wealth, 0010000.00, 0020000.00
	random, stressnum, 000.00, 010.00	
	}


;Generate character

Generate:
Gui, Submit

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

;story diploma

if hasdiploma = Diploma
	{
	storydiploma=Working hard these last four years has paid off. You recently graduated from highschool and got a diploma. 
	}
else storydiploma= Lifes ups and downs have been insurmountable these last few years, leading you to drop out of highschool without getting a diploma.

;Your story so far
Gui, New,, Injustice: The Game
gui, font, s15
Gui, add, text, x220, Your Story So Far:
gui, font, s10
Gui, Add, Text,w600 x15 y+20, (You are a %race% %sex%) Finally 18 years old! %storydiploma% You look back on your years of %storypoverty% %storyparenthome% You look forward to moving out, finding a steadfast %spouse% and becoming an amazing parent.
gui, add, button, default x285, Begin
Gui, show
Return
Buttonbegin:
gui, hide

;Building the main game page after char gen	
{
gui, new,, Injustice: The Game
gui, font, s10
gui, add, Text,, %Name%
gui, add, Text,, Race: %Race%
gui, add, Text,, Sex: %Sex%
gui, add, Text,, Sexual Preference: %preference%
gui, add, Text,vmydiploma, High School Diploma: %hasDiploma%
gui, add, Text,vmyage, Age: %Age%
Gui, add, text,vmyhealth, Health: %Healthnum%/70
gui, add, text,vmyhappiness, Happiness: %happinessnum%/100
Gui, add, text,vmystress, Stress: %stressnum%/%stressabilitynum%
Gui, add, text,vmywealth, Wealth: $%wealth%
Gui, add, text, y300, 
Gui, add, button,vgetjob, Get job
Gui, add, button, default, Progress
Gui, add, button,, Actions
gui, show 
Return
}

ButtonActions:
Gui, new,, Actions
gui, font, s10
Gui, add, button,vgetjob, Get job
if hasdiploma = Diplomaless
	{
	gui, add, button, vdiploma, Get a GED
	}
if (hasdiploma = "Diploma" and college := "Not a Graduate")
	{
	gui, add, button, vcollegebut, Go to college
	}
if hasspouse = no
	{
	gui, add, button, vfindspouse, Find a spouse
	}
else
	{
	gui, add, button, vdivorcespouse, Divorce your spouse
	if preferance = Heterosexual
		{
		Gui, add, button,, Have a child
		}
	else gui, add, button,, Adopt a child
	}
if housingsitch = house
	{
	Gui, add, button,, Home Payments
	}
else 
	{
	gui, add, button,, Buy a house
	}
Gui, add, button,vcancel, Back to game
gui, show
return

buttonbacktogame:
buttoncancel:
gui, submit
return


buttongotocollege:
if collegethisyear = yes
	{
	msgbox, You are already attending college this year!
	return
	}
else
	{	
	Gui, new,, Injustice: The Game college
	gui, font, s10
	Gui, add, text,,Pay $5000 to go to college for 1 year? You must go for 4 years to graduate. You have attended %collegeyears% years total.
	Gui, add, button,, College Time!
	Gui, add, button,default, Cancel
	gui, show
	return
	}
		buttoncollegetime!:
		if collegeyears = 4
			{
			msgbox, You already have a degree!
			gui, hide
			return
			}
		else
		collegeyears += 1
		collegeyearsleft := collegeyearsleftfunction(4,collegeyears)
		collegethisyear = yes
		wealth -= 5000
		if collegeyears = 4
			{
			msgbox, You have graduated! Congrats! (+10 happiness, Get a degree)
			college = Graduate
			happinessnum += 10
			gui,submit
			return
			}
		else	
			{
			msgbox, You have %collegeyearsleft% years to go before you get your degree. School is stressful though. (+10 stress)
			gui, hide
			Stressnum +=10
			return
			}
			
		gui, submit
		return
		
buttonfindaspouse:
if hasspouse = yes
	{
	msgbox, You already have a spouse!
	}
else if triedspouse = Yes
	{
	msgbox, You already spent all year searching for a nice %spouse%, to no avail.
	}
else
	{
	random,spousenum, 1, 2
	if spousenum = 1
		{
		hasspouse = Yes
		Msgbox, You found a wonderful %spouse% to enjoy life with! (+10 happiness)
		gui, submit
		return
		}
	else
		{
		triedspouse = Yes
		msgbox, You spent all year searching for a nice %spouse%, to no avail. This has left you feeling depressed. (-10 happiness, +10 stress)
		stressnum += 10
		happinessnum -=10
		return
		}
	}
return
buttonhaveachild:
buttonadoptachild:
if childtried = no
	{
	random, childchancenum, 1,2
	childtried = yes
	if childchancenum = 1
		{
		msgbox, You and your spouse have a beautiful child to look after now. It brings you great joy just as it will bring you great stress. (+20 happiness, +20 stress)
		stressnum += 20
		happinessnum +=20
		childcount +=1
		}
	else
		{
		msgbox, You and your spouse failed to have/adopt a child this year. The failed effort leaves you both disappointed. (-10 happiness, +5 stress)
		happinessnum -=10
		stressnum +=5
		}
	}
else
	{
	msgbox, You have already tried to have a child this year. Try again next year!
	return
	}
return

buttondivorceyourspouse:
	{
	msgbox, After many long nights fighting and argueing. You and your spouse both decided that it was better to seperate. This has been a very trying time for you. You also lose half of your wealth. (+20 Stress, lose 1/2 wealth,)
	stressnum -= 20
	wealthdivorcemod = .5
	hasspouse = no
	gui, Submit
	return
	}

buttonbuyahouse:
	{
	if housingsitch = house
		{
		msgbox, You already own a home.
		Return
		}
	else
		{
		gui, new,, Injustice: The Game Home
		gui, font, s10
		Gui, add,text,, A house will cost you $50000 upfront and will be 20 percent more expensive than renting. However if you own a home for 30 years, you will not have to make further payments.
		Gui, add, text,y+1, Do you really wish to buy a house?
		Gui, add, button,, Buy it
		Gui, add, button,, Cancel
		Gui, show
		return
		}
		buttonbuyit:
		wealth -= 50000
		yearshomeown += 1
		housingsitch = house
		gui, submit
		return
	}
return
buttonhousepayments:
	{
	msgbox, You have payed house payments for %yearshomeown% years. (after 30 years you dont have to pay any more)
	return
	}
	

buttongetaged:
if hasdiploma = Diplomaless
	{
	Gui, new,, Injustice: The Game diploma
	gui, font, s10
	Gui, add, text,, Pay $3000 to get a GED? This will enable you to make a higher salary. Your chances of successfully searching for a job also improve.
	Gui, add, button,vged, GED Time!
	Gui, add, button,default, Cancel
	Gui, show
	return
	}
else
	{
	msgbox, You already have a diploma!
	return
	}
		buttongedtime!:
		wealth -=3000
		hasdiploma = Diploma
		msgbox, Congrats! You now have a diploma.
		gui, hide
		return







ButtonGetjob:
{
random, getjobcheck, 1, 10
if hasdiploma = Diploma ;Higher chance to get job with diploma
	{
	getjobcheck += 1
	}
if felonycount >= 1
	{
	getjobcheck -= 2
	}
if parentssocioeconomics = Poverty
	{
	if getjobcheck > 4
		{
		random, baseincome, 20000, 26000
		hasjob = yes
		stressnum -= 5
		happinessnum +=5
		guicontrol, hide, getjob
		income := incomecalculation(baseincome, diplomaincome, graduateincome, racialincomebias, sexincomebias)
		Msgbox, You found a Job! It pays $%income% a year. (-5 stress)
		parentssocioeconomics= nonpoverty
		}
	else
		{
		msgbox, You failed to find a job! This is very stressful. (stress +5)
		stressnum += 05.00
		}
	}
else if parentssocioeconomics = Nonpoverty
	
	if getjobcheck > 1
		{
		random, baseincome, 20000, 28000
		hasjob = yes
		stressnum -= 5
		happinessnum +=5
		guicontrol, hide, getjob
		income := incomecalculation(baseincome, diplomaincome, graduateincome, racialincomebias, sexincomebias)
		Msgbox, You found a Job! It pays $%income% a year. (-5 stress)
		}
	else
		{
		msgbox, You failed to find a job! This is very stressful. (stress +5)
		stressnum += 05.00
		}
return
}

		
Buttonprogress:
{
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
	
	random, eventnum, 1, 7
	if eventnum = 1 ;House Damage
		{
		random, houseissuenum, 1, 3
		if houseissuenum = 1 ;tree
			{
			Msgbox, AHH! A tree fell on your house and did a massive ammount of damage. ($5000 to fix, +2 stress, -2 happiness)
			eventwealth -=5000
			stressnum +=2
			eventhappiness -=2
			}
		if houseissuenum = 2 ;bugs
			{
			msgbox, Bugs! Bugs everywhere! You must pay $3000 to fumigate the house. ($3000 fumigation, +2 stress, -2 happiness)
			eventwealth -=3000
			stressnum +=2
			eventhappiness -=2
			}
		if houseissuenum = 3 ;burst pipe
			{
			msgbox, A pipe has bust in the wall while you were away. ($2000 to fix, +2 stress, -2 happiness)
			eventwealth -=2000
			stressnum +=2
			eventhappiness -=2
			}
		}
	else if eventnum = 2 ;Injury
		{
		random, injuryeventnum, 1, 4
		if injuryeventnum = 1 ;trip
			{
			msgbox, While walking down the street you trip on the pavement, injuring your knee, and your pride. (Hospital bills: $1000, +1 stress, -1 happiness, get an injury)
			stressnum +=1
			injury +=1
			eventhappiness -=1
			eventwealth -=1000
			}
		if injuryeventnum = 2 ;hit by lightning
			{
			msgbox, You were struck by lighning and severley injured! What are the odds? (Hospital bills: $4000, +5 stress, -3 happiness, get a bad injury)
			stressnum +=5
			injury +=2
			eventhappiness -=3
			eventwealth -=4000
			}
		if injuryeventnum = 3 ;Hit face
			{
			msgbox, You fall out of bed and land on your face. Now everyone thinks you lost a fight. Embarrassing. (Hospital bills: $500, +3 stress, -3 happiness, get an injury, lose a tooth)
			stressnum +=3
			injury +=1
			eventhappiness -=3
			eventwealth -=1000
			}
		if injuryeventnum = 4 ;Knee to the face
			{
			msgbox, In an attempt to have some fun you jump on a trampoline. Unfortunatly you jump to high and smash your knee into your face when you land. (Hospital bills: $1000, get an injury, forever have a phobia of trampolines)
			eventwealth -=1000
			injury +=1
			}
		}
	else if eventnum = 3 ;Moving 
		{
		msgbox, You must relocate. Costs to do so are $2000. (Pay $2000, +8 stress, -4 happiness)
		stressnum += 8
		eventwealth -= 2000
		eventhappiness -=4
		}
	else if eventnum = 4 ;Car crash or Massive injury
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
			eventwealth += 4000
			}
		else 
			{
			Msgbox, A car swerves to avoid an adorable kitten. Fortunatly the kitten was saved. Unfortunatly, the car hit you going 25 miles an hour. You were hit hard enough your ancestors felt it. (Terrible injury. Hospital bills: $5000)
			injury +=2
			eventwealth -=5000
			}
		}
	else if eventnum = 5 ;Sickness
		{
		msgbox, You catch the flu this year. It is mildly detrimental to your health. (Lose .5 health)
		eventhealth -= .5
		}
	else if eventnum = 6 ;Chronic illness
		{
		msgbox, You develop a chronic illness! There is no cure. For the rest of your life it will eat away at your health. (Lose .25 health every year)
		permhealthdebuff +=.25
		health -=.25
		}
	else if eventnum = 7 ;Commit a felony
		{
		random, fellonychance, 1, 100
		if (%race% = White or %race% = Asian)
			{
			if fellonychance <= 75
				{
				msgbox, You were caught committing a felony. Thankfully the lawyer you hired was able to get you off the hook. (Pay lawyer $7000)
				eventwealth -=7000
				}
			else 
				{
				msgbox, You were caught commiting a felony. After a lengthy court battle you were convicted of your crime. Off to prison you go, AFTER you pay your lawyer. This will have massive implications for your entire life. (Pay lawyer $7000, Chance to lose job, harder to get a new job, lower wages)
				eventwealth -=7000
				felonycount +=1
				if hasjob = yes
					{
					random, losejobchance, 1, 2
					if losejobchance = 1
						{
						msgbox, You lost your job!
						income = 0
						hasjob = no
						}
					}
				}
			}
		else if fellonychance <= 25
			{
			msgbox, You were caught committing a felony. Thankfully the lawyer you hired was able to get you off the hook. (Pay lawyer $7000)
			eventwealth -=7000
			}
			else 
			{
			msgbox, You were caught commiting a felony. After a lengthy court battle you were convicted of your crime. Off to prison you go, AFTER you pay your lawyer. This will have massive implications for your entire life. (Pay lawyer $7000, Chance to lose job, harder to get a new job, lower wages)
			eventwealth -=7000
			felonycount +=1
			random, losejobchance, 1, 2
			if hasjob = yes
				{
				if losejobchance = 1
					{
					msgbox, You lost your job!
					income = 0
					hasjob = no
					}
				}
			}
		}
	else if eventnum = 8
	

if eventchance = 2 ;good
	
	

eventchance = 0
eventnum = 0

;Cost of home ownership with function def

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
	
yearlycost = 10000
	
;cost of living housingcost + yearlycost + eventcost
costofliving := costoflivingfunction(housingcost, yearlycost, eventcost)
eventcost = 0
;add income to wealth subtract costs
wealth := wealthchangefunction(wealth, income, eventwealth, costofliving, wealthdivorcemod)
eventwealth := 0
;health change per turm/ base health - 1per turn - event - permhealthdebuff
healthdegradeperturn :=1
healthnum := healthchangefunction(healthnum, healthdegradeperturn, eventhealth, permhealthdebuff)
eventhealth := 0

;happiness change per trun happinessnum + event happiness - permhappinessdebuff
happinessnum := happinesschangefunction(happinessnum, eventhappiness)
eventhappiness := 0






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
	
if wealth <= -12000 
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
	if (housingsitch = "renter" or housingsitch = "house")
		{
		Msgbox, Be careful. If your wealth drops below -$12000 you will become homeless.
		}
	}
else if wealth < 0
	{
	stressnum += 2
	if (housingsitch = "renter" or housingsitch = "house")
		{
		Msgbox, Be careful. If your wealth drops below -$12000 you will become homeless.
		}
	}
	
	
;function definitions
costoflivingfunction(a:=0, b:=0, c:=0) ;housing + yearlycosts + eventcost
	{
	return a + b + c
	}
	
incomeinequality(a,b)
	{
	return a * b
	}
	
wealthchangefunction(a, b, c, d, e) ;wealth + income + eventwealth - costofliving * wealthdivorcemod
	{
	return (a + b + c - d) * e
	}
	
healthchangefunction(a, b:=1, c:=0, d:=0)  ;base health - 1per turn - event - permhealthdebuff
	{
	return a - b - c - d
	}
	
happinesschangefunction(a, b:=0, c:=0) ;happiness change per trun happinessnum + event happiness - permhappinessdebuff
	{
	return a + b + c
	}
incomecalculation(a:=0, b:=0, c:=0, d:=1, e:=1)
	{
	return (a + b + c) * d * e
	}
collegeyearsleftfunction(a,b)
	{
	return a - b
	}
}


gui, submit, nohide

guicontrol,,myage,Age:%Age%
guicontrol,,myhealth,Health: %healthnum%/70
guicontrol,,mystress,Stress: %stressnum%/%stressabilitynum%
guicontrol,,myhappiness,Happiness: %happinessnum%/100
guicontrol,,mywealth,Wealth: $%wealth%
guicontrol,,mydiploma,High School Diploma: %hasdiploma%
if hasjob = no
	{
	Gui, add, button,, Getjob
	}
collegethisyear = no
triedspouse = no
childtried = no
wealthdivorcemod = 1
return




Death:
GuiClose: ;Makes the x close the window
ExitApp

