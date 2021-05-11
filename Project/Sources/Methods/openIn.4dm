//%attributes = {"invisible":true,"shared":true}
#DECLARE($app : Text; $methodPath : Text)

var $workingDirectory : 4D:C1709.Folder
$workingDirectory:=Folder:C1567(Folder:C1567(fk database folder:K87:14).platformPath; fk platform path:K87:2)

var $workingFile : 4D:C1709.File
$workingFile:=$workingDirectory.file(fileForMethod($methodPath))

var $in; $out; $error : Text

Case of 
	: ($app="terminal")
		LAUNCH EXTERNAL PROCESS:C811("open -a terminal '"+$workingDirectory.path+"'"; $in; $out; $error)
	: ($app="finder")
		SHOW ON DISK:C922($workingFile.platformPath)
	: ($app="code")
		LAUNCH EXTERNAL PROCESS:C811("open -a 'Visual Studio Code' '"+$workingDirectory.path+"'"; $in; $out; $error)
		LAUNCH EXTERNAL PROCESS:C811("open -a 'Visual Studio Code' '"+$workingFile.path+"'"; $in; $out; $error)
	: ($app="sourcetree")
		LAUNCH EXTERNAL PROCESS:C811("open -a SourceTree '"+$workingDirectory.path+"'"; $in; $out; $error)
	: ($app="githubdesktop")
		LAUNCH EXTERNAL PROCESS:C811("open -a 'Github Desktop' '"+$workingDirectory.path+"'"; $in; $out; $error)
	: ($app="github")
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY"; $workingDirectory.platformPath)
		LAUNCH EXTERNAL PROCESS:C811("/usr/local/bin/git config --get remote.origin.url"; $in; $out; $error)
		var $url : Text
		$url:=Replace string:C233($out; "\n"; "")
		OPEN URL:C673($url)
	Else 
		ASSERT:C1129(False:C215; "Not implemented")
End case 