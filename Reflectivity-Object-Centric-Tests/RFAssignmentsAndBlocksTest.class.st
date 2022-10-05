Class {
	#name : #RFAssignmentsAndBlocksTest,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFAssignmentsAndBlocksTest >> testAssignmentDictionaryCreation [

	| b proxy metaobject |
	b := TestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b assignment1.
	b beforeAssignmentTo: #var1 do: [ 'This is A' crTrace ].
	self assert:
		(metaobject assignmentsStoring valuesStored includesKey: #var1).
	b afterAssignmentTo: #var2 do: [ 'This is B' crTrace ].
	b beforeAssignmentTo: #c do: [ 'This is C' crTrace ].
	b insteadAssignmentTo: #d do: [ 'This is D' crTrace ].

	self assert:
		(metaobject assignmentsStoring valuesStored includesKey: #var1).
	self assert:
		(metaobject assignmentsStoring valuesStored includesKey: #var2).
	self assert:
		(metaobject assignmentsStoring valuesStored includesKey: #c).
	self assert:
		(metaobject assignmentsStoring valuesStored includesKey: #d).
	self
		assert:
			((metaobject assignmentsStoring valuesStored at: #var1) before at:
				 1) asText
		equals: [ 'This is A' crTrace ] asText.
	self
		assert:
		(metaobject assignmentsStoring valuesStored at: #d) instead asText
		equals: [ 'This is D' crTrace ] asText
]

{ #category : #tests }
RFAssignmentsAndBlocksTest >> testAssignmentDictionaryCreationOverride [

	| b proxy metaobject |
	b := TestClass  new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b assignment1.
	b beforeAssignmentTo: #var1 do: [ 'This is Before' crTrace ].
	b afterAssignmentTo:  #var1 do: [ 'This is After' crTrace ].
	b beforeAssignmentTo: #var1 do: [ 'This is NEXTBEFORE' crTrace ].
	b afterAssignmentTo:  #var1 do: [ 'This is NEXTAFTER' crTrace ].
	self assert: (metaobject assignmentsStoring valuesStored includesKey: #var1).
	self assert: ((metaobject assignmentsStoring valuesStored at: #var1) before at:1) asText equals: [ 'This is Before' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring valuesStored at: #var1) before at:2) asText equals: [ 'This is NEXTBEFORE' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring valuesStored at: #var1) after at:2) asText equals: [ 'This is NEXTAFTER' crTrace ] asText.
]

{ #category : #tests }
RFAssignmentsAndBlocksTest >> testAssignmentDictionaryCreationWithMoreThanOneCall [

	| b proxy metaobject |
	b := TestClass  new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b assignment1.
	b beforeAssignmentTo: #var1 do: [ 'This is Before' crTrace ].
	b afterAssignmentTo:  #var1 do: [ 'This is After' crTrace ].
	b insteadAssignmentTo: #var1 do: [ 'This is Instead' crTrace ].
	b afterAssignmentTo:  #var2 do: [ 'This is BAFTER' crTrace ].
	b beforeAssignmentTo: #c do: [ 'This is CBEFORE' crTrace ].
	
	self assert: (metaobject assignmentsStoring valuesStored includesKey: #var1).
	self assert: ((metaobject assignmentsStoring valuesStored at: #var1) before at:1) asText equals: [ 'This is Before' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring valuesStored at: #var1) instead) asText equals: [ 'This is Instead' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring valuesStored at: #var1) after at:1) asText equals: [ 'This is After' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring valuesStored at: #var2) after at: 1) asText equals: [ 'This is BAFTER' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring valuesStored at: #c) before at: 1) asText equals: [ 'This is CBEFORE' crTrace ] asText.
	self assert: (metaobject assignmentsStoring valuesStored at: #c) instead isNil .
]
