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
	paramindex = parent(2).digits
	#print(paramindex)
	num_mods = op('constant1')[0]
	ops = ['attvalues', 'minrange_values', 'maxrange_values', 'min_out', 'max_out']
	for index, item in enumerate(ops):
		for i in range(int(num_mods)):
			cellval = dat[0,i+index*int(num_mods)].val
			parname = 'value'+str(i)
			setattr(op(item).par,parname,cellval)
	return

def onRowChange(dat, rows):
	return

def onColChange(dat, cols):
	return

def onCellChange(dat, cells, prev):
	return

def onSizeChange(dat):
	return
	