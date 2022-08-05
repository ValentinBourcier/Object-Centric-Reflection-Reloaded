Extension { #name : #Object }

{ #category : #'*Reflectivity-Object-Centric' }
Object >> afterAssignmentTo: aVariableName do: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self afterAssignmentTo: aVariableName do: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> beforeAssignmentTo: aVariableName do: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self beforeAssignmentTo: aVariableName do: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> haltOnCall [

	^ RFProxy becomeTarget: self
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> insteadAssignmentTo: aVariableName do: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self afterAssignmentTo: aVariableName do: aBlock
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
