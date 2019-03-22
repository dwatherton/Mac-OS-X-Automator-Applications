# Get the selected items from finder
tell application "Finder" to set selectedItems to selection

# Loop through each item in the selected items in finder
repeat with eachItem in selectedItems
	
	# Set the scriptToRun to the File that is each item in the selected items (Quoted in case of spaces in name(s))
	set scriptToRun to quoted form of POSIX path of (eachItem as string)
	
	# Set the filename to the name of eachItem
	set filename to name of eachItem
	
	# Run each item with Python if the filename contains ".py" (highly unlikely a filename contains ".py" but is not a Python Script)
	if ".py" is in filename then
		
		# Run the Python Script in Terminal
		tell application "Terminal"
			
			# set cmd to run a Python Script
			set cmd to "python " & scriptToRun
			
			# Check if window 1 of Terminal is open and not busy
			if (exists window 1) and not busy of window 1 then
				
				# Run Python Script in Terminal Window 1
				do script cmd in window 1
				
			else
				
				# Else, window 1 of Terminal is not open, or window 1 is busy, Run Python Script
				do script cmd
				
			end if
			
			# Activate Terminal to show the Python Script in a new window
			activate
			
		end tell
		
	end if
	
end repeat