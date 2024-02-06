{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 38.0, 154.0, 223.0, 156.0 ],
		"bgcolor" : [ 1.0, 1.0, 1.0, 0.0 ],
		"bglocked" : 0,
		"defrect" : [ 391.0, 44.0, 893.0, 180.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 1,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Verdana",
		"gridonopen" : 0,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "width of bpatchers",
					"patching_rect" : [ 740.0, 46.0, 123.0, 21.0 ],
					"id" : "obj-10",
					"fontname" : "Verdana",
					"numinlets" : 1,
					"fontsize" : 12.0,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "* -215",
					"outlettype" : [ "int" ],
					"patching_rect" : [ 685.0, 46.0, 51.0, 21.0 ],
					"id" : "obj-8",
					"fontname" : "Verdana",
					"numinlets" : 2,
					"fontsize" : 12.0,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "offset $1 0",
					"outlettype" : [ "" ],
					"patching_rect" : [ 685.0, 76.0, 76.0, 19.0 ],
					"id" : "obj-5",
					"fontname" : "Verdana",
					"numinlets" : 2,
					"fontsize" : 12.0,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "thispatcher",
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 685.0, 97.0, 78.0, 21.0 ],
					"id" : "obj-1",
					"fontname" : "Verdana",
					"numinlets" : 1,
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"outlettype" : [ "" ],
					"patching_rect" : [ 685.0, 8.0, 25.0, 25.0 ],
					"id" : "obj-6",
					"numinlets" : 0,
					"numoutlets" : 1,
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "bpatcher",
					"presentation_rect" : [ 441.0, 5.0, 214.0, 143.0 ],
					"args" : [  ],
					"outlettype" : [ "int", "int", "int", "int" ],
					"patching_rect" : [ 441.0, 5.0, 214.0, 143.0 ],
					"presentation" : 1,
					"id" : "obj-4",
					"name" : "Ints_bp.maxpat",
					"numinlets" : 1,
					"numoutlets" : 4
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "bpatcher",
					"presentation_rect" : [ 222.0, 5.0, 214.0, 143.0 ],
					"args" : [  ],
					"outlettype" : [ "", "", "", "" ],
					"patching_rect" : [ 222.0, 5.0, 214.0, 143.0 ],
					"presentation" : 1,
					"id" : "obj-3",
					"name" : "Sliders_bp.maxpat",
					"numinlets" : 1,
					"numoutlets" : 4
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "bpatcher",
					"presentation_rect" : [ 3.0, 5.0, 214.0, 143.0 ],
					"args" : [  ],
					"outlettype" : [ "float", "float", "float", "float" ],
					"patching_rect" : [ 3.0, 5.0, 214.0, 143.0 ],
					"presentation" : 1,
					"id" : "obj-2",
					"name" : "Knobs_bp.maxpat",
					"numinlets" : 1,
					"numoutlets" : 4
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
