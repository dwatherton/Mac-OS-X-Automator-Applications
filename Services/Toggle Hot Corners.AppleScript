# Set a property to hold my preferred Hot Corners configuration
property myPreferredHotCorners : {"Dashboard", "Mission Control", "Put Display to Sleep", "Desktop"}

tell application "System Preferences"
	
	# Open System Preferences
	activate
	
	# Set the current pane of System Preferences to Expose (aka Mission Control)
	set current pane to pane id "com.apple.preference.expose"
	
	tell application "System Events"
		
		# Wait for .15 seconds (Automator tries to go before window is ready)
		delay 0.15
		
		# Tell Mission Control to work with Hot Corners
		tell window "Mission Control" of process "System Preferences"
			
			# Wait for .175 seconds (Automator tries to go before window is ready)
			delay 0.175
			
			# Select the Hot Corners button for Hot Corners configuration
			click button "Hot CornersÉ"
			
			# Tell the sheet that Pops Up from Hot Corners button to
			tell sheet 1
				
				# Tell the first group (Active Screen Corners) to
				tell group 1
					
					# Set current hot corners to the value of the current Hot Corners buttons
					set currentHotCorners to value of pop up buttons
					
					# Check if currentHotCorners are set to (-,-,-,-) AKA Hot Corners are OFF
					if currentHotCorners is {"-", "-", "-", "-"} then
						
						# Loop for each of the four buttons with index i
						repeat with i from 1 to 4
							
							# Set the button value to the value corresponding to i in my preffered Hot Corners
							set buttonValue to item i of myPreferredHotCorners
							
							# Tell the ith button to
							tell pop up button i
								
								# Click to open the options menu of this Hot Corner
								click
								
								# Click the menu item corresponding to the buttonValue of my preffered Hot Corner
								click menu item buttonValue of menu 1
								
								# End telling the ith button to change the Hot Corner value
							end tell
							
							# End repeating for each of the four buttons (Hot Corners set to my preffered Hot Corners -> ON)
						end repeat
						
						# Else currentHotCorners are ON
					else
						
						# Copy the current Hot Corners to my preffered Hot Corners property (Save Hot Corners)
						copy currentHotCorners to myPreferredHotCorners
						
						# Loop for each of the four buttons with index i
						repeat with i from 1 to 4
							
							# Tell the ith button to	
							tell pop up button i
								
								# Click to open the options menu of this Hot Corner
								click
								
								# Click the last menu item of the Hot Corner options menu (-)
								click last menu item of menu 1
								
								# End telling the ith button to change the Hot Corner value
							end tell
							
							# End repeating for each of the four buttons (Hot Corners set to "-" -> OFF)
						end repeat
						
						# End checking the state of the Hot Corners
					end if
					
					# End telling group 1 (Active Screen Corners)	
				end tell
				
				# Click the OK button on the sheet with the Hot Corners options to close and save Hot Corners
				click button "OK"
				
				# End telling sheet 1 with Hot Corners options
			end tell
			
			# End telling Mission Control of System Preferrences Process
		end tell
		
		# End telling System Events
	end tell
	
	# Quit System Preferences
	quit
	
	# End telling System Preferrences
end tell