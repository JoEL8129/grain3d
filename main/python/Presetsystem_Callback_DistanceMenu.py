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
	ui_obj = op('dropDownMenu')
	ui_obj2 = op('dropDownMenu1')
	param_names = op('select1')
	
	setattr(ui_obj.par,"Value0",param_names[int(dat[0,0].val),0].val)
	setattr(ui_obj2.par,"Value0",param_names[int(dat[0,1].val),0].val)
	return

def onRowChange(dat, rows):
	return

def onColChange(dat, cols):
	return

def onCellChange(dat, cells, prev):
	return


def onSizeChange(dat):
	return
	