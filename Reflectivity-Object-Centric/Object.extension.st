Extension { #name : #Object }

{ #category : #'*Reflectivity-Object-Centric' }
Object >> afterAnyAssignmentDo: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self afterAnyAssignmentDo: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> afterAnyMessageSendDo: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self afterAnyMessageSendDo: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> afterAssignmentTo: aVariableName do: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self afterAssignmentTo: aVariableName do: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> afterMessageSendTo: aMethod do: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self afterAssignmentTo: aMethod  do: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> beforeAnyAssignmentDo: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self beforeAnyAssignmentDo: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> beforeAnyMessageSendDo: aBlock [

	self flag: 'We have to change the recursion'.
	self proxify.
	self beforeAnyMessageSendDo: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> beforeAssignmentTo: aVariableName do: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self beforeAssignmentTo: aVariableName do: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> beforeMessageSendTo: aMethod do: aBlock [

	self flag: 'We have to change the recursion'.
	self proxify.
	self beforeMessageSendTo: aMethod do: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> haltOnCall [

	^ RFProxy becomeTarget: self
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> insteadAnyAssignmentDo: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self insteadAnyAssignmentDo: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> insteadAnyMessageSendDo: aBlock [

	self flag: 'We have to change the recursion'.
	self proxify.
	self insteadAnyMessageSendDo: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> insteadAssignmentTo: aVariableName do: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self insteadAssignmentTo: aVariableName do: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> insteadMessageSendTo: aMethod do: aBlock [

	self flag: 'We have to change the recursion'.
	self proxify.
	self insteadMessageSendTo: aMethod do: aBlock
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
