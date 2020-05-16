#####################################################
##
## Author: Jan Pijpers 
##
## Date: 01/04/2014
##
## Module description: Generates a mel auto completion file for sublime.
##
##
#####################################################

import maya.mel as mel
from pymel.core.language import Env
import json
import os
import getpass
userName = getpass.getuser()
###########################################################
## Usage:
## Copy this file into this folder C:\Users\<UserName>\Documents\maya\<Maya Version>\scripts 
## Open maya and run the following python code in the script editor. 
##
## import SublimeMelAutocompletion as sm
## reload(sm)
## sm.generateAutoCompletion()
##
## Justin Israel's Maya Sublime plugin for sublime text can be found here: https://github.com/justinfx/MayaSublime
## More info can be found here  http://www.janpijpers.com/mel-autocompletion-for-sublime-and-mayasublime/
###########################################################

def generateAutoCompletion( mayaOnly = False, apiOnly = False, filePath = "C:\Users\%s\AppData\Roaming\Sublime Text 3\Packages\MayaSublime\MEL.sublime-completions" %userName ):
    '''
        Description:
           Generates an autocompletion file for use with sublime text. 
        Args:
           mayaOnly : bool get only the maya commands that are available or get all commands from files that are in
           the maya scripts paths
           apiOnly : only takes maya's own commands that you can find in the documentation. (not recommended as it lacks quite a few commands)
           filePath : filepath in case you want to export it somewhere else besides the default path. 
        Returns:
           None
        Raises:
           None
    '''

    ## Get the folder path for the defined filepath
    folderPath = os.path.dirname( filePath )
    ## Check if the folder path exists 
    if not os.path.exists( folderPath):
        print "Path does not exists: %s. Please make sure the folder exists and MayaSublime is installed" %( folderPath ), ## Added comma so it prints in the status line of maya
        return
    
    ## Create dict that will hold all our json completion data
    jsonDict = dict() 
    ## Define the scope. (I think this could be changed so that sublime can colorize the functions)
    jsonDict["scope"] = 'source.mel -string -comment -constant '
    jsonDict["completions"] = list()

    ## A list that will get filled with all the proccessed commands 
    ## This way we make sure we do not list the command twice. 
    proccessedCommands = list()

    #####################################################
    ## Start itterating over all the standard "known" maya commands 
    print "Step 1: Processing Maya Default Commands"
    for command in mel.eval('help -list "*"'):
        
        commandDict = dict() 
        ## The trigger for the auto completion
        commandDict["trigger"] = command
        ## The contents of what gets written when selecting the completion
        commandDict["contents"] = command
        ## Adding comments as this might be supported in the future in sublime. 
        commandDict["comment"] = mel.eval("help %s"%command)
        
        ## If we have not had this command allready
        if not command in proccessedCommands:
            ## Add it to our jsonDict 
            jsonDict["completions"] .append( commandDict ) 
            ## Add it to the proccessed commands. 
            proccessedCommands.append(command)

    #####################################################
    ## Parse all mel 
    if not apiOnly:
        print "Step 2: Processing Maya Script files"
        for path in getScriptSourcePaths(mayaOnly = mayaOnly):
            print "Processing files in folder and subfolders: %s"%path 
            ## We do it recursively over all paths below all the patsh that we get
            for root, folders, files in os.walk( path ):
            
                ## itterate over all files 
                for melFile in files:
                    
                    ## Get all procedures listed in the file (checking for mel files happen here) 
                    commands = getMelProcsFromFile( root+"/" + melFile )
                    ## If we found any procedures 
                    if commands:
                        ## Itterate over the procedure
                        for command in commands: 
                            if command in proccessedCommands:
                                continue
                            commandDict = dict() 
                            ## Add the procedure to the trigger
                            commandDict["trigger"] = command
                            ## Add it to the contents 
                            commandDict["contents"] = command
                            ## Could also find a way to look up the docstring at some point 
                            commandDict["comment"] = "Command Source: %s" %os.path.abspath(root+"/" + melFile)
                            
                            
                            ## Add it to the jsonDict
                            jsonDict["completions"] .append( commandDict ) 
                            ## Add it to the proccessed commands so we dont add it again 
                            proccessedCommands.append( command)
    else:
        print "Step 2 Skipped because of apiOnly flag"
                
    try:
        ## Open the filePath for writing 
        print "Step3 Writing file to %s" %filePath
        compFile = file( filePath, "w")
        ## Write the json data in pretty print format
        compFile.write( json.dumps(jsonDict, sort_keys=True, indent=4, separators=(',', ': ')))
        ## Close the file again. 
        compFile.close()
    except Exception, e:
        raise e, "Something went wrong writing to the file"
    
    print "Done", 


def getMelProcsFromFile( filePath ):
    '''
    Description:
        Tries to get the mel procedures from a file. 
        By some simple string parsing trics. Might be some edge cases where it doesnt 
        detect the correct procedure
    Args:
        filePath : it needs a filepath. 
        If the extension is not .mel or the path does not exist it will return an empty list
    Returns:
        [] : an empty list if file does not exist, is not a mel file, or error occured during reading of the file
        [procNameA,procNameB,etc]
    Raises:
        None
    '''

    ###########################################################
    ## Path checks 
    if not os.path.exists( filePath ):
        print 
        print "Path: %s does not exist." %s
        print
        return []

    if not os.path.splitext( filePath )[-1] == ".mel":
        return []

    ###########################################################
    ## Start with reading the file
    try: 
        procList = list()
        ## Open file for reading
        melFile = file(filePath, 'r')
        ## Bool to check if we need to grab the next line
        getNextLine = False

        ## For every line in the mel file
        for line in melFile.xreadlines():
            ## if its an empty line continue to the next line
            if not line.split():
                getNextLine = False
                continue
            ## If our line is a mel comment ignore it
            if line.split()[0] == "//":
                getNextLine = False
                continue


            procName = ''

            ###########################################################
            ## Sometimes users can write a mel proc like this:
            ##   global proc string[]
            ##   myMelProcedure()
            ## So if we detected the previous proc string[] with nothing after it
            ## we know we need to grab the next line. 
            ## Do we need to grab this line ?
            if getNextLine:
                procName = line
                getNextLine = False
              
            ## If the word proc with spaces around it is found in the line
            elif "global proc " in line.lower():
                ## Split the line 
                splitLine = line.split()
                ## get the index in the list were we found proc 
                index = splitLine.index( "proc" )+1
                ## If that was the end of the line 
                ## Go to the next line and get whatever is in that line 
                if len( splitLine) == index : 
                    getNextLine = True
                    continue

                ## If our word after proc is a a return variable definition look for the next word
                if splitLine[ index ] in ["string","string[]", "int", "int[]", "float", "float[]","vector"]:
                    index += 1 

                ## If that was the end of the line 
                ## Go to the next line and get whatever is in that line 
                if len( splitLine) == index : 
                    getNextLine = True
                    continue

                ## if soneone put a space between the return variable definition [] catch that
                ## and add 1 to the index to check the next word 
                if splitLine[index] in ["[]"]:
                    index += 1

                ## If that was the end of the line 
                ## Go to the next line and get whatever is in that line 
                if len( splitLine) == index : 
                    getNextLine = True
                    continue
                ## Proc name is the index and anything after wards (so it adds all the arguments which will be helpfull when writing)
                procName = ' '.join( splitLine[ index: ] )
                
            else:
                continue
            ## append the procedure name to the proc list
            procList.append( procName ) 
        ## close the mel file
        melFile.close()
        ## Return the list. 
        return procList
    except e:

        print 
        print "WARNING SOMETHING WENT WRONG WITH READING THIS FILE!!"
        print "FilePath: ",filePath
        print "Error: ", e
        print "Line in file: ",line
        print 
        return []
        


def getScriptSourcePaths( mayaOnly = False):

    ## If you only want maya's commands 
    if mayaOnly:
        ## Get the base path i.e. C:/Program Files/Autodesk/Maya2014 
        ## for the installed version of maya.
        mayaBasePath = '/'.join( os.path.abspath(Env.envVars['PATH'].split(';')[0] ).split(os.sep)[:-2] )
        mayaPaths = list()
        for path in Env.envVars['MAYA_SCRIPT_PATH'].split(';'):
            ## Filter based on the programfiles directory 
            if mayaBasePath in path:
                mayaPaths.append(path)
        return mayaPaths
    else:
        ## Get all defined script paths so it will also generate your scripts 
        paths = [path for path in Env.envVars['MAYA_SCRIPT_PATH'].split(';')]

    return paths 