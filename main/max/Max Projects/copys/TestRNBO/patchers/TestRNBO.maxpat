{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 5,
			"revision" : 2,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "rnbo",
		"rect" : [ 59.0, 106.0, 640.0, 480.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Lato",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"title" : "untitled",
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "" ],
					"patching_rect" : [ 234.0, 171.0, 82.0, 23.0 ],
					"rnbo_classname" : "buffer~",
					"rnbo_extra_attributes" : 					{
						"type" : "",
						"fill" : "",
						"samplerate" : 0.0,
						"file" : ""
					}
,
					"rnbo_serial" : 1,
					"rnbo_uniqueid" : "buffer~_obj-1",
					"rnboinfo" : 					{
						"needsInstanceInfo" : 1,
						"argnames" : 						{
							"info" : 							{
								"attrOrProp" : 1,
								"digest" : "Bang to report buffer information.",
								"isalias" : 0,
								"aliases" : [  ],
								"settable" : 0,
								"attachable" : 0,
								"isparam" : 0,
								"deprecated" : 0,
								"inlet" : 1,
								"type" : "bang"
							}
,
							"sizeout" : 							{
								"attrOrProp" : 1,
								"digest" : "Size in Samples",
								"defaultarg" : 2,
								"isalias" : 0,
								"aliases" : [  ],
								"settable" : 0,
								"attachable" : 0,
								"isparam" : 0,
								"deprecated" : 0,
								"outlet" : 1,
								"type" : "number",
								"defaultValue" : "0"
							}
,
							"chanout" : 							{
								"attrOrProp" : 1,
								"digest" : "Number of Channels",
								"isalias" : 0,
								"aliases" : [  ],
								"attachable" : 0,
								"isparam" : 0,
								"deprecated" : 0,
								"outlet" : 1,
								"type" : "number",
								"defaultValue" : "0"
							}
,
							"srout" : 							{
								"attrOrProp" : 1,
								"digest" : "Sample rate",
								"isalias" : 0,
								"aliases" : [  ],
								"attachable" : 0,
								"isparam" : 0,
								"deprecated" : 0,
								"outlet" : 1,
								"type" : "number",
								"defaultValue" : "0"
							}
,
							"size" : 							{
								"attrOrProp" : 1,
								"digest" : "Size in Samples. Take care when setting, allocation might block audio processing.",
								"defaultarg" : 2,
								"isalias" : 0,
								"aliases" : [ "samples" ],
								"settable" : 1,
								"attachable" : 1,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "number",
								"defaultValue" : "0"
							}
,
							"samples" : 							{
								"attrOrProp" : 1,
								"digest" : "Size in Samples. Take care when setting, allocation might block audio processing.",
								"defaultarg" : 2,
								"isalias" : 1,
								"aliasOf" : "size",
								"aliases" : [  ],
								"settable" : 1,
								"attachable" : 1,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "number",
								"defaultValue" : "0"
							}
,
							"sizems" : 							{
								"attrOrProp" : 1,
								"digest" : "Size in Milliseconds. Take care when setting, allocation might block audio processing.",
								"isalias" : 0,
								"aliases" : [ "ms" ],
								"settable" : 1,
								"attachable" : 1,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "number",
								"defaultValue" : "0"
							}
,
							"ms" : 							{
								"attrOrProp" : 1,
								"digest" : "Size in Milliseconds. Take care when setting, allocation might block audio processing.",
								"isalias" : 1,
								"aliasOf" : "sizems",
								"aliases" : [  ],
								"settable" : 1,
								"attachable" : 1,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "number",
								"defaultValue" : "0"
							}
,
							"clear" : 							{
								"attrOrProp" : 1,
								"digest" : "Clear the contents of the buffer",
								"isalias" : 0,
								"aliases" : [  ],
								"attachable" : 1,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "bang"
							}
,
							"normalize" : 							{
								"attrOrProp" : 1,
								"digest" : "Find Maximum and normalize to the value given.",
								"isalias" : 0,
								"aliases" : [  ],
								"settable" : 1,
								"attachable" : 1,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "number",
								"defaultValue" : "0.995"
							}
,
							"channels" : 							{
								"attrOrProp" : 1,
								"digest" : "Change channel count. Take care when setting, allocation might block audio processing.",
								"defaultarg" : 3,
								"isalias" : 0,
								"aliases" : [  ],
								"settable" : 1,
								"attachable" : 1,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "number",
								"defaultValue" : "1"
							}
,
							"name" : 							{
								"attrOrProp" : 2,
								"digest" : "Name of the data buffer",
								"defaultarg" : 1,
								"isalias" : 0,
								"aliases" : [  ],
								"settable" : 1,
								"attachable" : 0,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "symbol",
								"mandatory" : 1
							}
,
							"file" : 							{
								"attrOrProp" : 2,
								"digest" : "File name/path or URL to load into buffer.",
								"isalias" : 0,
								"aliases" : [  ],
								"settable" : 1,
								"attachable" : 0,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "symbol"
							}
,
							"url" : 							{
								"attrOrProp" : 2,
								"digest" : "The name of an audio file to load",
								"isalias" : 1,
								"aliasOf" : "file",
								"aliases" : [  ],
								"settable" : 1,
								"attachable" : 0,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "symbol"
							}
,
							"type" : 							{
								"attrOrProp" : 2,
								"digest" : "Type of Data (Float32, Float64)",
								"isalias" : 0,
								"aliases" : [  ],
								"settable" : 1,
								"attachable" : 0,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "symbol"
							}
,
							"samplerate" : 							{
								"attrOrProp" : 2,
								"digest" : "Sample rate",
								"defaultarg" : 4,
								"isalias" : 0,
								"aliases" : [  ],
								"settable" : 1,
								"attachable" : 0,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "number",
								"defaultValue" : "0"
							}
,
							"fill" : 							{
								"attrOrProp" : 2,
								"digest" : "Fill expression, this could be a value, or a simple function like sin(x), where x will run from 0 to 1 to fill the buffer.",
								"isalias" : 0,
								"aliases" : [  ],
								"settable" : 1,
								"attachable" : 0,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "symbol"
							}
,
							"external" : 							{
								"attrOrProp" : 2,
								"digest" : "Await data from the outside world.",
								"isalias" : 0,
								"aliases" : [  ],
								"settable" : 1,
								"attachable" : 0,
								"isparam" : 0,
								"deprecated" : 0,
								"type" : "bool",
								"doNotShowInMaxInspector" : 1
							}

						}
,
						"inputs" : [ 							{
								"name" : "info",
								"type" : "bang",
								"digest" : "Bang to report buffer information.",
								"hot" : 1,
								"docked" : 0
							}
 ],
						"outputs" : [ 							{
								"name" : "sizeout",
								"type" : "number",
								"digest" : "Size in Samples",
								"defaultarg" : 2,
								"docked" : 0
							}
, 							{
								"name" : "chanout",
								"type" : "number",
								"digest" : "Number of Channels",
								"docked" : 0
							}
, 							{
								"name" : "srout",
								"type" : "number",
								"digest" : "Sample rate",
								"docked" : 0
							}
 ],
						"helpname" : "buffer~",
						"aliasOf" : "data",
						"classname" : "buffer~",
						"operator" : 0,
						"versionId" : 2090845839,
						"changesPatcherIO" : 0
					}
,
					"text" : "buffer~ smpl1"
				}

			}
 ],
		"lines" : [  ],
		"default_bgcolor" : [ 0.031372549019608, 0.125490196078431, 0.211764705882353, 1.0 ],
		"color" : [ 0.929412, 0.929412, 0.352941, 1.0 ],
		"elementcolor" : [ 0.357540726661682, 0.515565991401672, 0.861786782741547, 1.0 ],
		"accentcolor" : [ 0.343034118413925, 0.506230533123016, 0.86220508813858, 1.0 ],
		"stripecolor" : [ 0.258338063955307, 0.352425158023834, 0.511919498443604, 1.0 ],
		"bgfillcolor_type" : "color",
		"bgfillcolor_color" : [ 0.031372549019608, 0.125490196078431, 0.211764705882353, 1.0 ],
		"bgfillcolor_color1" : [ 0.031372549019608, 0.125490196078431, 0.211764705882353, 1.0 ],
		"bgfillcolor_color2" : [ 0.263682, 0.004541, 0.038797, 1.0 ],
		"bgfillcolor_angle" : 270.0,
		"bgfillcolor_proportion" : 0.39,
		"bgfillcolor_autogradient" : 0.0
	}

}
