; $Id: hb3264mingw.iss $

#define MyAppName "Object Oriented (x)Harbour GUI"
#define MyAppVerO "v20.06.08.rc1"
#define MyAppVerH "Harbour 3.2"
#define MyAppVerC "MINGW 9.3.0"
#define MyAppFile "oohg_hm3264_v200608rc1"
#define MyAppPublisher "The OOHG Developer Team"
#define MyAppURL "https://oohg.github.io/"
#if DirExists('W:\OOHG_HM3264')
   #define MySource "W:\OOHG_HM3264\*"
#elif DirExists('D:\OOHG_HM3264')
   #define MySource "D:\OOHG_HM3264\*"
#elif DirExists('C:\OOHG_HM3264')
   #define MySource "C:\OOHG_HM3264\*"
#else
   #error Input folder not found !!!
#endif

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{9E0E46FC-1016-4395-B3ED-36441B5D5293}
AppName={#MyAppName}
AppVersion={#MyAppVerO} based on {#MyAppVerH} and {#MyAppVerC}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=C:\OOHG
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputBaseFilename={#MyAppFile}
SetupIconFile=..\core\resources\OOHG.ico
Compression=lzma
SolidCompression=yes
LicenseFile=license.txt
InfoBeforeFile=infobefore.txt
InfoAfterFile=infoafter_mingw.txt
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "armenian"; MessagesFile: "compiler:Languages\Armenian.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "corsican"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl"
Name: "icelandic"; MessagesFile: "compiler:Languages\Icelandic.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "slovak"; MessagesFile: "compiler:Languages\Slovak.isl"
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Files]
Source: {#MySource}; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "..\core\resources\_oohg_resconfig.h"; DestDir: "{app}\RESOURCES"; AfterInstall: WriteToFile

[Code]
procedure WriteToFile;
begin
  SaveStringToFile(
     ExpandConstant('{app}\RESOURCES\_oohg_resconfig.h'), 
     '#define oohgpath ' + ExpandConstant('{app}\RESOURCES') + #13#10 + 
     '#include "' + ExpandConstant('{app}\INCLUDE\oohgversion.h') + '"' + #13#10, False);
end;
