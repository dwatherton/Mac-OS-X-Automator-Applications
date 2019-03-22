# Set currentDirectory to the current Finder windows location in the filesystem
tell application "Finder" to set currentDirectory to (target of front Finder window) as text

# Make sure currentDirectory is not an empty string (ex. recents on the sidebar produces empty string) 
if currentDirectory is not "" then
	
	tell application "Terminal"
		
		# Set cmd to change directory to the current directory in Finder
		set cmd to "cd " & (quoted form of POSIX path of currentDirectory)
		
		# Check if window 1 of Terminal is open and not busy
		if (exists window 1) and not busy of window 1 then
			
			# Change to the current directory in Finder of Terminal Window 1
			do script cmd in window 1
			
		else
			
			# Else, window 1 of Terminal is not open, or window 1 is busy, change to the current directory in Finder
			do script cmd
			
		end if
		
		# Activate Terminal to show the current directory in a new window Terminal window
		activate
		
		# Clear Terminal output to start - start in a clean Terminal window at the current directory of Finder
		delay 0.85
		tell application "System Events" to keystroke "k" using {command down}
		delay 0.1
		
	end tell
	
end if
