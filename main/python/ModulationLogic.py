# me - this DAT
# 
# channel - the Channel object which has changed
# sampleIndex - the index of the changed sample
# val - the numeric value of the changed sample
# prev - the previous sample value
# 
# Make sure the corresponding toggle is enabled in the CHOP Execute DAT.

def onOffToOn(channel, sampleIndex, val, prev):
	return

def whileOn(channel, sampleIndex, val, prev):
	return

def onOnToOff(channel, sampleIndex, val, prev):
	return

def whileOff(channel, sampleIndex, val, prev):
	return

def onValueChange(channel, sampleIndex, val, prev):
	value = op('merge1')[0]
	finalvalue = 0
	modop = op('null6')
	modvalues = []
	minrange = op('minrange_values')
	maxrange = op('maxrange_values')
	attvalues = op('attvalues')
	for i in range(modop.numChans):
		modvalues.insert(i,tdu.remap(modop[i],minrange[i],maxrange[i],0.0,1.0))
		modvalues[i] *= attvalues[i]
		finalvalue += value + modvalues[i]
	print(finalvalue)
	setattr(op('constant1').par,"value0",finalvalue)
	return
	