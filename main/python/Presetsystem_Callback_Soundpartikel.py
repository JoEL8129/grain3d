# me - this DAT.
# 
# dat - the changed DAT
# rows - a list of row indices
# cols - a list of column indices
# cells - the list of cells that have changed content
# prev - the list of previous string contents of the changed cells
# 
# Make sure the corresponding toggle is enabled in the DAT Execute DAT.
# 
# If rows or columns are deleted, sizeChange will be called instead of row/col/cellChange.


def onTableChange(dat):
	knob = op('container1/container2/knobFixed')
	menu  = op('container1/container1/dropDownMenu')
	menuitems = op('select1')
	mods = op('compute_modulation/constant1')
	rangeui = op('container1/container1/container2/float2')
	range2ui = op('container1/container1/container2/float3')
	attui = op('container1/container1/container1/Slider1')
	#paramindex = int(parent().digits)
	menuindex = (int(mods[0])*5+1)
	menuindexvalue = int(dat[0,menuindex].val)
	knobindex = (int(mods[0])*5)

	setattr(attui.par,"Value0",dat[0,menuindexvalue].val)

	setattr(rangeui.par,"Value0",dat[0,menuindexvalue+int(mods[0])].val)
	setattr(rangeui.par,"Value1",dat[0,menuindexvalue+int(mods[0])*2].val)

	setattr(range2ui.par,"Value0",dat[0,menuindexvalue+int(mods[0])*3].val)
	setattr(range2ui.par,"Value1",dat[0,menuindexvalue+int(mods[0])*4].val)

	setattr(knob.par,"Value0",dat[0,knobindex].val)
	setattr(menu.par,"Value0",menuitems[menuindexvalue,0].val)



	

	return

def onRowChange(dat, rows):
	return

def onColChange(dat, cols):
	return

def onCellChange(dat, cells, prev):
	return

def onSizeChange(dat):
	return
	