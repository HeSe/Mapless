actions
setModelsFrom: someJSONStrings on: aKey of: aJsonObject
	"Set models (only if someJsonStrings feels like those)"

	| modelClass newSubModel |

	 aJsonObject 
		at: aKey 
		put: (someJSONStrings collect: [:json| 
				modelClass := Smalltalk 
								at: (json at: 'modelClass') asSymbol
								ifAbsent:[self error: 'Cannot find that class'].
				newSubModel := modelClass fromJSON: json.
				newSubModel setSubModels.
				newSubModel])