Class {
	#name : #ROCBlocksRegistryHandler,
	#superclass : #Object,
	#instVars : [
		'variableReadRegistry',
		'variableWriteRegistry',
		'messageSendRegistry'
	],
	#category : #'Reflectivity-Object-Centric-metaobjects'
}

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> afterAnyAssignmentDo: aBlock [

	self afterAnyDo: aBlock withRegistry: self variableWriteRegistry
]

{ #category : #registration }
ROCBlocksRegistryHandler >> afterAnyDo: aBlock withRegistry: aRegistry [

	aRegistry blocksStored valuesDo: [ :eachValue | 
		eachValue addAfter: aBlock ].
	aRegistry addAllBlocksAfter: aBlock.
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> afterAnyMessageSendDo: aBlock [

	self afterAnyDo: aBlock withRegistry: self messageSendRegistry
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> afterAnyVariableReadDo: aBlock [

	self afterAnyDo: aBlock withRegistry: self variableReadRegistry
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> afterAssignmentTo: aVariable do: aBlock [

	self
		afterSpecificRegistry: self variableWriteRegistry
		To: aVariable
		do: aBlock
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> afterMessageSendTo: aMethod do: aBlock [

	self
		afterSpecificRegistry: self messageSendRegistry
		To: aMethod
		do: aBlock
]

{ #category : #registration }
ROCBlocksRegistryHandler >> afterSpecificRegistry: aRegistry To: aVariable do: aBlock [

	| variableToStore |
	(aRegistry blocksStored includesKey: aVariable) ifTrue: [ 
		| aTimeObject |
		aTimeObject := aRegistry blocksStored at: aVariable.
		aTimeObject addAfter: aBlock.
		^ aTimeObject ].
	aRegistry blocksStored at: aVariable put: ROCBlocksExecutionOrder new.
	variableToStore := aRegistry blocksStored at: aVariable.
	aRegistry allBlocksBefore do: [ :each | 
		variableToStore addBefore: each ].
	aRegistry allBlocksAfter do: [ :each | 
		variableToStore addAfter: each ].
	[ aRegistry allBlocksInstead ] ifNotNil: [ 
		variableToStore instead: aRegistry allBlocksInstead ].
	variableToStore addAfter: aBlock
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> afterVariableRead: aVariable do: aBlock [

	self
		afterSpecificRegistry: self variableReadRegistry
		To: aVariable
		do: aBlock
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> beforeAnyAssignmentDo: aBlock [

	self beforeAnyDo: aBlock withRegistry: self variableWriteRegistry
]

{ #category : #registration }
ROCBlocksRegistryHandler >> beforeAnyDo: aBlock withRegistry: aRegistry [

	aRegistry blocksStored valuesDo: [ :eachValue | 
		eachValue addBefore:  aBlock ].
	aRegistry addAllBlocksBefore:  aBlock.
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> beforeAnyMessageSendDo: aBlock [

	self beforeAnyDo: aBlock withRegistry: self messageSendRegistry
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> beforeAnyVariableReadDo: aBlock [

	self beforeAnyDo: aBlock withRegistry: self variableReadRegistry 
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> beforeAssignmentTo: aVariable do: aBlock [

	self
		beforeSpecificRegistry: self variableWriteRegistry
		to: aVariable
		do: aBlock
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> beforeMessageSendTo: aMethod do: aBlock [

	self
		beforeSpecificRegistry: self messageSendRegistry 
		to: aMethod 
		do: aBlock
]

{ #category : #registration }
ROCBlocksRegistryHandler >> beforeSpecificRegistry: aRegistry to: aVariable do: aBlock [

	| variableToStore |
	(aRegistry blocksStored includesKey: aVariable) ifTrue: [ 
		^ (aRegistry blocksStored at: aVariable) addBefore: aBlock ].
	aRegistry blocksStored at: aVariable put: ROCBlocksExecutionOrder new.
	variableToStore := aRegistry blocksStored at: aVariable.
	aRegistry allBlocksBefore do: [ :each | 
		variableToStore addBefore: each ].
	aRegistry allBlocksAfter do: [ :each | 
		variableToStore addAfter: each ].
	[ aRegistry allBlocksInstead ] ifNotNil: [ 
		variableToStore instead: aRegistry allBlocksInstead ].
	variableToStore addBefore: aBlock
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> beforeVariableRead: aVariable do: aBlock [

	self
		beforeSpecificRegistry: self variableReadRegistry
		to: aVariable
		do: aBlock
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> insteadAnyAssignmentDo: aBlock [

	self insteadAnyDo: aBlock withRegistry: self variableWriteRegistry
]

{ #category : #registration }
ROCBlocksRegistryHandler >> insteadAnyDo: aBlock withRegistry: aRegistry [

	aRegistry blocksStored valuesDo: [ :eachValue | 
		eachValue instead:  aBlock ].
	aRegistry allBlocksInstead:  aBlock.
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> insteadAnyMessageSendDo: aBlock [

	self insteadAnyDo: aBlock withRegistry: self messageSendRegistry 
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> insteadAnyVariableReadDo: aBlock [

	self insteadAnyDo: aBlock withRegistry: self variableReadRegistry 
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> insteadAssignmentTo: aVariable do: aBlock [

	self
		insteadSpecificRegistry: self variableWriteRegistry
		To: aVariable
		do: aBlock
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> insteadMessageSendTo: aMethod do: aBlock [

	self
		insteadSpecificRegistry: self messageSendRegistry 
		To: aMethod 
		do: aBlock
]

{ #category : #registration }
ROCBlocksRegistryHandler >> insteadSpecificRegistry: aRegistry To: aVariable do: aBlock [

	| variableToStore |
	(aRegistry blocksStored includesKey: aVariable) ifTrue: [ 
		^ (aRegistry blocksStored at: aVariable) instead: aBlock ].
	aRegistry blocksStored at: aVariable put: ROCBlocksExecutionOrder new.
	variableToStore := aRegistry blocksStored at: aVariable.
	aRegistry allBlocksBefore do: [ :each | 
		variableToStore addBefore: each ].
	aRegistry allBlocksAfter do: [ :each | 
		variableToStore addAfter: each ].
	variableToStore instead: aBlock
]

{ #category : #'registrations handling' }
ROCBlocksRegistryHandler >> insteadVariableRead: aVariable do: aBlock [

	self
		insteadSpecificRegistry: self variableReadRegistry
		To: aVariable
		do: aBlock
]

{ #category : #accessing }
ROCBlocksRegistryHandler >> messageSendRegistry [

	^ messageSendRegistry ifNil: [ 
		  messageSendRegistry := ROCBlocksRegistry new ]
]

{ #category : #accessing }
ROCBlocksRegistryHandler >> messageSendRegistry: anObject [

	messageSendRegistry := anObject
]

{ #category : #accessing }
ROCBlocksRegistryHandler >> variableReadRegistry [

	^ variableReadRegistry ifNil: [ 
		  variableReadRegistry := ROCBlocksRegistry new ]
]

{ #category : #accessing }
ROCBlocksRegistryHandler >> variableReadRegistry: anObject [

	variableReadRegistry := anObject
]

{ #category : #accessing }
ROCBlocksRegistryHandler >> variableWriteRegistry [

	^ variableWriteRegistry ifNil: [ 
		  variableWriteRegistry := ROCBlocksRegistry new ]
]

{ #category : #accessing }
ROCBlocksRegistryHandler >> variableWriteRegistry: anObject [

	variableWriteRegistry := anObject
]
