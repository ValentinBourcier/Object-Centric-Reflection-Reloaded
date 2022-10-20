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
Object >> afterAnyVariableReadDo: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self afterAnyVariableReadDo: aBlock
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
	self afterMessageSendTo:  aMethod  do: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> afterVariableRead: aVariableName do: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self afterVariableRead: aVariableName do: aBlock
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
Object >> beforeAnyVariableReadDo: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self beforeAnyVariableReadDo: aBlock
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
Object >> beforeVariableRead: aVariable do: aBlock [

	self flag: 'We have to change the recursion'.
	self proxify.
	self beforeVariableRead: aVariable do: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> haltOnCall [

	^ ROCProxy becomeTarget: self
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
Object >> insteadAnyVariableReadDo: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self insteadAnyVariableReadDo: aBlock
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
Object >> insteadVariableRead: aVariableName do: aBlock [
	self flag: 'We have to change the recursion'.
	self proxify.
	self insteadVariableRead: aVariableName do: aBlock
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> proxify [

	^ ROCProxy becomeTarget: self
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> proxifyWithMetaObject: mo [

	^ ROCProxy becomeTarget: self withMetaObject: mo
]

{ #category : #'*Reflectivity-Object-Centric' }
Object >> realObject [ 
	^self
]
