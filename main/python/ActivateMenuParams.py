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
	
    if channel.index != 1:
        inop = op('merge1')
        outop = op('attvalues')
        outchan = 'value'+str(int(inop[1]))
        setattr(outop.par,outchan,inop[4])
        setattr(op('minrange_values').par,outchan,inop[2])
        setattr(op('maxrange_values').par,outchan,inop[3])
    else:
        rangeui = op('../container1/container1/float2')
        attui = op('../container1/container1/Slider1')
		
        newmenuval = int(op('merge1')[1])
        #print(op('minrange_values')[newmenuval])
        setattr(rangeui.par,'Value0',op('minrange_values')[newmenuval])
        setattr(rangeui.par,'Value1',op('maxrange_values')[newmenuval])
        setattr(attui.par,'Value0',op('attvalues')[newmenuval])
		
		
    
    return