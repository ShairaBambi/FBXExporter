-- Bambi's Exporter
--26/11/2015

pluginManager.loadClass FbxExporter -- Loads exporterplugins in this case FBX's
FBXfilename = substituteString maxFileName ".max" ".fbx"
FBXFolderpath = maxfilepath
try ( destroyDialog bexporter) catch () -- closes the other exporter window if exporter is already open

rollout bExporter "BatchExporter1.0"
	(
		label Exlabel "Exporter options" align:#middle -- Creates a label
		button exportbut "Export" width:250 height:21 align:#middle -- Creates a button
		label pathlabel "Export Path" align:#middle
		edittext userpathedit "" text:FBXFolderpath -- creates an edit text box
		button browsebut "Browse..." align:#middle
		GroupBox exportinfo "Export Info" width:250 height:50 align:#middle
		checkbox fbxtriangulate "FBX Triangulate" triState:0 tooltip:"Turn this on to triangulate object"
		--label namelabel "File Name" align:#middle
		--edittext userfileedit "" text:FBXfilename
		
		on fbxtriangulate changed theState do
		(
			if theState then
			(
				FbxExporterSetParam "Triangulate" true
			)
			else
			(
				FbxExporterSetParam "Triangulate" false
			)
		)
		
		on browsebut pressed do
		(
			local string Fpath
			Fpath = getSavePath caption:"Please Select Export Folder"
			userpathedit.Text = FPath
		)
		
		on exportbut pressed do
		(
			/*
			if $.name = "*<.\ /|" do
			(
				rollout Stopthatsymbol "Warning!"
					(
					Label Wrngtxt "A file name cant contain any of the follwing:*<.\ /|"
					)
				createdialog bExporter width:300 height:300 fgcolor:white 

			) USED TO STOP DUMBS FROM USING THE WRONG CHARACTERS THAT ARE NOT ALLOWED IN WINDOWS!
				*/
			
			--actionMan.executeAction 0 "40472"
			sel = selection as array -- turns te selection into an array
			objectloop = 1 -- objectloop equal integer 1
			for objectloop=objectloop to sel.count do -- for loop it loops through the objects so 1=1 to count through do
			( 
				select sel[objectloop] -- selects the objectloop parameter
				objpos =$.position -- objpos now equals selection[$] position
				exportname =$.name -- exportname is now selection[$] name
				
				$.pos = [0,0,0] -- puts selection[$] to origin[x = 0, y = 0, z = 0]
	
				filePath = userpathedit.Text + "\\" + $.name + "batchexport" 
                exportFile filePath #noPrompt selectedOnly:true -- exports the fbx files to user defined area -- as an FBX
                format "%\n" ("Exported:" + filePath) -- Prints exported documents out for user to see in listener (print this within Info)
				
				--exportfile exportname #noprompt selectedOnly:true using:exporterplugin.classes[9]
				--Exports using class [9]FBX also doesnt prompt you for each object (future script will allow you to add a preset export) (PAST CODE)
		 
				$.pos = objpos -- returns object position to previous possition
			)
		)
			
	)

createdialog bExporter width:300 height:700 fgcolor:white 
