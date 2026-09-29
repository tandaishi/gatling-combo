#Requires AutoHotkey v2.0.27+
#SingleInstance Force
configFileName := 'configFile.ini'
if (!FileExist(configFileName)){
    IniWrite('g',configFileName,'skill','bbq')
    IniWrite('b',configFileName,'skill','trample')
}
bbqKey := IniRead(configFileName, 'skill', 'bbq', 'g')
trampleKey := IniRead(configFileName, 'skill', 'trample', 'b')
SendKey(Key) {
    VK := GetKeyVK(Key), SC := GetKeySC(Key)
    DllCall('keybd_event', 'uchar', VK, 'uchar', SC, 'uint', 0, 'uptr', 0)
    Sleep(50)
    DllCall('keybd_event', 'uchar', VK, 'uchar', SC, 'uint', 2, 'uptr', 0)
}
bbq(){
    SendKey('c')
    Sleep(13)
    SendKey(bbqKey)
}
trample(){
    SendKey('c')
    Sleep(13)
    SendKey(trampleKey)
}
lastKey := ''
setLastKey(InputHookObj, Char){
    global lastKey
    if(Char = bbqKey){
        lastKey := 'bbqKey'
    }else If (Char = trampleKey){
        lastKey := 'trampleKey'
    }
}
InstallKeybdHook
InputHookObj := InputHook('V')
InputHookObj.Start()
InputHookObj.OnChar := setLastKey
Tab:: {
    if(lastKey = 'bbqKey'){
        trample()
    }else{
        bbq()
    }
}
OnExit()=>InputHookObj.Stop()
