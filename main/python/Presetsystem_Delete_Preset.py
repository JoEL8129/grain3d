# me - this DAT
# 
# channel - the Channel object which has changed
# sampleIndex - the index of the changed sample
# val - the numeric value of the changed sample
# prev - the previous sample value
# 
# Make sure the corresponding toggle is enabled in the CHOP Execute DAT.
import os

def delete_file(file_path):
    try:
        os.remove(file_path)
        print(f"File '{file_path}' deleted successfully.")
    except FileNotFoundError:
        print(f"File '{file_path}' not found.")
    except Exception as e:
        print(f"Error deleting file '{file_path}': {e}")


def onOffToOn(channel, sampleIndex, val, prev):
	
	file_name = op('select2')[0,0].val
	file_path = op('folder1').par.rootfolder+file_name
	save_presets = ['_default.dat','_default2.dat']
	allow_delete = 1
	for index, item in enumerate(save_presets):
		if file_name==item:
			allow_delete = 0
			
	if allow_delete==1:
		delete_file(file_path)
		#print(file_name)
	return

def whileOn(channel, sampleIndex, val, prev):
	return

def onOnToOff(channel, sampleIndex, val, prev):
	return

def whileOff(channel, sampleIndex, val, prev):
	return

def onValueChange(channel, sampleIndex, val, prev):
	return
	