# me - this DAT
# 
# channel - the Channel object which has changed
# sampleIndex - the index of the changed sample
# val - the numeric value of the changed sample
# prev - the previous sample value
# 
# Make sure the corresponding toggle is enabled in the CHOP Execute DAT.

def onOffToOn(channel, sampleIndex, val, prev):
	op('math5').bypass = 0
	op('base1').allowCooking = 1
	for i in range(int(op('info1')[0])):
		op('item'+str(i+1)+'/out1').bypass = 0
	op('base1').op('replicator1').par.recreateall.pulse()
	op('base1').op('replicator2').par.recreateall.pulse()
	op('replicator2').par.recreateall.pulse()
	op('replicator1').par.recreateall.pulse()
	



	#for i in range(int(op('info1')[0])):
		##op('item'+str(i+1)+'/out1').bypass = 0
		##op('item'+str(i+1)+'/DBAP_4ch1/out1').bypass = 0
		
	
	#op('math5').bypass = 1
	#op('base1').allowCooking = 0
	#for i in range(int(op('info1')[0])):
		##op('item'+str(i+1)+'/out1').bypass = 1
		##op('item'+str(i+1)+'/DBAP_4ch1/out1').bypass = 1
		
	return

def whileOn(channel, sampleIndex, val, prev):
	return

def onOnToOff(channel, sampleIndex, val, prev):
	op('math5').bypass = 1
	op('base1').allowCooking = 0
	for i in range(int(op('info1')[0])):
		op('item'+str(i+1)+'/out1').bypass = 1
	return

def whileOff(channel, sampleIndex, val, prev):
	return

def onValueChange(channel, sampleIndex, val, prev):
	return
	