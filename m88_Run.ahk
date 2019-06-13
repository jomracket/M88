#NoEnv
#SingleInstance Force
emucfgloc= m88.ini
romf= %1%
romfx= %2%
splitpath,romf,romfp,romfd,romx,romfn
if (romfx = "")
	{	
		disklbls= *disk 2 of*|*disk B*|*side b*|*tape 2*|*part 2*|*disk_2_of*|*disk_B*|*side_b*|*tape_2*|*part_2*|*disk-2-of*|*disk-B*|*side-b*|*tape-2*|*part-2*
		loop,parse,disklbls,|
			{
				loop,%romfd%\%A_LoopField%.%romx%
					{
						romfx= %A_LoopFileFullPath%
						romfp2= %A_LoopFileName%
						break
					}
			}
	}
spp= %A_ScriptDir%\m88.exe
splitpath,spp,,sppth
IniRead, pc88Mode , %emucfgloc%, M88p2 for Windows, BASICMode
IniRead, FSMODE , %emucfgloc%, M88p2 for Windows, FullScreen32
IniRead, FSWIN , %emucfgloc%, M88p2 for Windows, FullWindow
IniWrite, 49, %emucfgloc%, M88p2 for Windows, BASICMode
IniWrite, %romfd%, %emucfgloc%, M88p2 for Windows, Directory
IniWrite, %romf%, %emucfgloc%, M88p2 for Windows, d88
IniWrite, %romf%, %emucfgloc%, M88p2 for Windows, FD1NAME0
IniWrite, %romfx%, %emucfgloc%, M88p2 for Windows, FD2NAME0
IniWrite, 0, %emucfgloc%, M88p2 for Windows, Resume
run, %spp%,%sppth%,,sivr
Blockinput,on
sleep,500
winwait, ahk_pid %sivr%
WinMenuSelectItem, ahk_pid %sivr%, , Drive 1, %romf%
sleep,500
WinMenuSelectItem, ahk_pid %sivr%, , 1&, 1&
sleep,500
WinMenuSelectItem, ahk_pid %sivr%, , Drive 2, %romfx%
Sleep,500
if ((FSMODE = 1)or(FSWIN = 1))
	{
		Send, {Alt Down}{Enter}
		Send, {Alt up}
	}
Blockinput,off
winwaitclose, ahk_pid %sivr%
exitapp