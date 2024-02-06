{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 6,
			"minor" : 0,
			"revision" : 7
		}
,
		"rect" : [ 55.0, 48.0, 357.0, 276.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Verdana",
		"gridonopen" : 0,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 0,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"boxes" : [ 			{
				"box" : 				{
					"clicktextcolor" : [ 0.366811, 0.366811, 0.366811, 1.0 ],
					"fontname" : "Verdana",
					"fontsize" : 12.0,
					"htabcolor" : [ 0.00834, 0.611564, 0.015384, 1.0 ],
					"htextcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"id" : "obj-2",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 25.0, 26.0, 240.0, 24.0 ],
					"tabs" : [ "Knobs", "Sliders", "Ints" ]
				}

			}
, 			{
				"box" : 				{
					"border" : 1,
					"id" : "obj-1",
					"maxclass" : "bpatcher",
					"name" : "TheScroller_bp.maxpat",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 25.0, 63.0, 223.0, 156.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-2", 0 ]
				}

			}
 ],
		"dependency_cache" : [ 			{
				"name" : "TheScroller_bp.maxpat",
				"bootpath" : "/Volumes/Cargo/Users/cbm/Max6Patches/Tests/BP_Scroller",
				"patcherrelativepath" : "",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "Knobs_bp.maxpat",
				"bootpath" : "/Volumes/Cargo/Users/cbm/Max6Patches/Tests/BP_Scroller",
				"patcherrelativepath" : "",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "Sliders_bp.maxpat",
				"bootpath" : "/Volumes/Cargo/Users/cbm/Max6Patches/Tests/BP_Scroller",
				"patcherrelativepath" : "",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "Ints_bp.maxpat",
				"bootpath" : "/Volumes/Cargo/Users/cbm/Max6Patches/Tests/BP_Scroller",
				"patcherrelativepath" : "",
				"type" : "JSON",
				"implicit" : 1
			}
 ]
	}

}
