Extension { #name : #Object }

{ #category : #'*Reflectivity-Object-Centric' }
Object >> haltOnCall [

	^ RFProxy becomeTarget: self
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> proxify [

	^ RFProxy becomeTarget: self
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> proxifyWithMetaObject: mo [

	^ RFProxy becomeTarget: self withMetaObject: mo
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> realObject [ 
	^self
]
