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
	

	return

def onRowChange(dat, rows):
	return

def onColChange(dat, cols):
	return

def onCellChange(dat, cells, prev):
	particle_comp = op('../../../Particles1')
	param_names = op('select3')
	for index, item in enumerate(cells):
		setattr(particle_comp.par,param_names[0,item.col].val,item.val)
	return

def onSizeChange(dat):
	return
	