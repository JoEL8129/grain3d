{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 718.0, 44.0, 640.0, 480.0 ],
		"bgcolor" : [ 1.0, 1.0, 1.0, 0.0 ],
		"bglocked" : 0,
		"defrect" : [ 718.0, 44.0, 640.0, 480.0 ],
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
					"text" : "Integers",
					"presentation_rect" : [ 40.0, 75.170212, 127.0, 41.0 ],
					"patching_rect" : [ 39.0, 263.0, 154.0, 41.0 ],
					"presentation" : 1,
					"id" : "obj-16",
					"fontname" : "Verdana",
					"numinlets" : 1,
					"fontsize" : 28.075949,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"patching_rect" : [ 179.0, 162.0, 25.0, 25.0 ],
					"id" : "obj-14",
					"numinlets" : 1,
					"numoutlets" : 0,
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"patching_rect" : [ 128.0, 162.0, 25.0, 25.0 ],
					"id" : "obj-13",
					"numinlets" : 1,
					"numoutlets" : 0,
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"patching_rect" : [ 77.0, 162.0, 25.0, 25.0 ],
					"id" : "obj-12",
					"numinlets" : 1,
					"numoutlets" : 0,
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"patching_rect" : [ 26.0, 162.0, 25.0, 25.0 ],
					"id" : "obj-11",
					"numinlets" : 1,
					"numoutlets" : 0,
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"outlettype" : [ "" ],
					"patching_rect" : [ 316.0, 33.0, 25.0, 25.0 ],
					"id" : "obj-10",
					"numinlets" : 0,
					"numoutlets" : 1,
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"presentation_rect" : [ 158.0, 28.0, 48.0, 34.0 ],
					"outlettype" : [ "int", "bang" ],
					"patching_rect" : [ 179.0, 44.0, 48.0, 34.0 ],
					"presentation" : 1,
					"id" : "obj-5",
					"fontname" : "Verdana",
					"numinlets" : 1,
					"fontsize" : 22.301641,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"presentation_rect" : [ 107.0, 28.0, 48.0, 34.0 ],
					"outlettype" : [ "int", "bang" ],
					"patching_rect" : [ 128.0, 44.0, 48.0, 34.0 ],
					"presentation" : 1,
					"id" : "obj-4",
					"fontname" : "Verdana",
					"numinlets" : 1,
					"fontsize" : 22.301641,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"presentation_rect" : [ 56.0, 28.0, 48.0, 34.0 ],
					"outlettype" : [ "int", "bang" ],
					"patching_rect" : [ 77.0, 44.0, 48.0, 34.0 ],
					"presentation" : 1,
					"id" : "obj-3",
					"fontname" : "Verdana",
					"numinlets" : 1,
					"fontsize" : 22.301641,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"presentation_rect" : [ 5.0, 28.0, 48.0, 34.0 ],
					"outlettype" : [ "int", "bang" ],
					"patching_rect" : [ 26.0, 44.0, 48.0, 34.0 ],
					"presentation" : 1,
					"id" : "obj-2",
					"fontname" : "Verdana",
					"numinlets" : 1,
					"fontsize" : 22.301641,
					"numoutlets" : 2
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
