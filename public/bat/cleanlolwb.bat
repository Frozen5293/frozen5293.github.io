del evalPerformance.ini
del GameCheck.exe
del GameSetMan.exe
del ImportCer.exe
del IniConfig.ini
del NMgameset.ini
del NMgameset8300.ini
del node.dll
del PlayPlayCfg.ini
del SunwardPkg.cks
del SunwardPkg.idx
del sw_PlayPlay.exe
del TQM.ini
del 访问官网.lnk
del 取消录制功能.bat

del /f /s /q CONF
del /f /s /q log
del /f /s /q System32File
del /f /s /q ErrorReport
del /f /s /q WeGameLauncher
rd log
rd CONF
echo Y | rd /s System32File
rd ErrorReport
echo Y | rd /s WeGameLauncher
echo y | icacls Cross /T /deny Administrator:R