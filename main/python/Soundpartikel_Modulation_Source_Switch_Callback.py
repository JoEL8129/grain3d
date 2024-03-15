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
        inop = op('ui_vals_in')
        outop = op('attvalues')
        outchan = 'value'+str(int(inop[1]))
        setattr(outop.par,outchan,inop[4])
        setattr(op('minrange_values').par,outchan,inop[2])
        setattr(op('maxrange_values').par,outchan,inop[3])
        setattr(op('min_out').par,outchan,inop[5])
        setattr(op('max_out').par,outchan,inop[6])
    else:
        #rangeui = op('/project1/container2/container1/container3/container1/container1/float2')
        rangeui = parent(2).op('container1/container1/container2/float2')
        range2ui = parent(2).op('container1/container1/container2/float3')
        #attui = op('/project1/container2/container1/container3/container1/container1/Slider1')
        attui = parent(2).op('container1/container1/container1/Slider1')
        newmenuval = int(op('ui_vals_in')[1])
        #print(op('minrange_values')[newmenuval])
        setattr(rangeui.par,'Value0',op('minrange_values')[newmenuval])
        setattr(rangeui.par,'Value1',op('maxrange_values')[newmenuval])
        setattr(attui.par,'Value0',op('attvalues')[newmenuval])
        setattr(range2ui.par,'Value0',op('min_out')[newmenuval])
        setattr(range2ui.par,'Value1',op('max_out')[newmenuval])
		
		
    
    return