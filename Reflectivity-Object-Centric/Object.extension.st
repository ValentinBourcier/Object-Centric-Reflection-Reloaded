Extension { #name : #Object }

{ #category : #'*Reflectivity-Object-Centric' }
Object >> enableMop [

	^ ROCProxy becomeTarget: self
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> haltOnCall [

	^ ROCProxy becomeTarget: self
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> realObject [ 
	^self
]
