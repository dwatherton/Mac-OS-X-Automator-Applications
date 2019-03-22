# Get the selected items from finder
tell application "Finder" to set selectedItems to selection

# Loop through each item in the selected items in finder
repeat with eachItem in selectedItems
	
	# Set the itemToDelete to the File/Folder that is each item in the selected items (Quoted in case of spaces in name(s))
	set itemToDelete to quoted form of POSIX path of (eachItem as string)
	
	# Set the filename to the name of the File/Folder to delete
	set filename to name of eachItem
	
	# Set the deletedname to make sure the File/Folder is not already deleted
	set deletedname to ("/Users/daniel/.Trash/" & (filename as string))
	
	# Only delete items not already in the Trashcan and not the Delete.app (Handles File, then Folder, then Delete App)
	if (itemToDelete is not quoted form of (deletedname)) and (itemToDelete is not quoted form of (deletedname & "/")) and (filename is not "Delete.app") then
		
		# Confirmation before deleting an item ("Are you sure", "Yes or No", with a caution icon, default answer "Yes")
		set answer to the button returned of (display dialog "Are you sure you want to move \"" & (filename as string) & "\" to Trash? " with title "Confirmation" with icon caution buttons {"Yes", "No"} default button 1)
		
		# If user wants to delete the selected item in question (answer == "Yes")
		if answer is "Yes" then
			
			# Set cmd to move the item to the Trashcan
			set cmd to "mv " & itemToDelete & " /Users/daniel/.Trash"
			
			# Execute move command
			do shell script (cmd)
			
		end if
		
	end if
	
end repeat