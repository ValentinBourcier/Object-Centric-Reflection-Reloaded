Class {
	#name : #RFAssignmentsAndBlocks,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFAssignmentsAndBlocks >> testAssignmentDictionaryCreation [

	| b proxy metaobject |
	b := AssignmentsTestClass  new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b assignment1.
	b beforeAssignmentTo: #a do: [ 'This is A' crTrace ].
	self assert: (metaobject assignmentsStoring assignments includesKey: #a).
	b afterAssignmentTo:  #b do: [ 'This is B' crTrace ].
	b beforeAssignmentTo: #c do: [ 'This is C' crTrace ].
	b insteadAssignmentTo: #d do: [ 'This is D' crTrace ].
	
	self assert: (metaobject assignmentsStoring assignments includesKey: #a).
	self assert: (metaobject assignmentsStoring assignments includesKey: #b).
	self assert: (metaobject assignmentsStoring assignments includesKey: #c).
	self assert: (metaobject assignmentsStoring assignments includesKey: #d).
	self assert: ((metaobject assignmentsStoring assignments at: #a) before at: 1) asText equals: [ 'This is A' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring assignments at: #d) instead ) asText equals: [ 'This is D' crTrace ] asText.
]

{ #category : #tests }
RFAssignmentsAndBlocks >> testAssignmentDictionaryCreationOverride [

	| b proxy metaobject |
	b := AssignmentsTestClass  new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b assignment1.
	b beforeAssignmentTo: #a do: [ 'This is Before' crTrace ].
	b afterAssignmentTo:  #a do: [ 'This is After' crTrace ].
	b beforeAssignmentTo: #a do: [ 'This is NEXTBEFORE' crTrace ].
	b afterAssignmentTo:  #a do: [ 'This is NEXTAFTER' crTrace ].
	self assert: (metaobject assignmentsStoring assignments includesKey: #a).
	self assert: ((metaobject assignmentsStoring assignments at: #a) before at:1) asText equals: [ 'This is Before' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring assignments at: #a) before at:2) asText equals: [ 'This is NEXTBEFORE' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring assignments at: #a) after at:2) asText equals: [ 'This is NEXTAFTER' crTrace ] asText.
]

{ #category : #tests }
RFAssignmentsAndBlocks >> testAssignmentDictionaryCreationWithMoreThanOneCall [

	| b proxy metaobject |
	b := AssignmentsTestClass  new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b assignment1.
	b beforeAssignmentTo: #a do: [ 'This is Before' crTrace ].
	b afterAssignmentTo:  #a do: [ 'This is After' crTrace ].
	b insteadAssignmentTo: #a do: [ 'This is Instead' crTrace ].
	b afterAssignmentTo:  #b do: [ 'This is BAFTER' crTrace ].
	b beforeAssignmentTo: #c do: [ 'This is CBEFORE' crTrace ].
	
	self assert: (metaobject assignmentsStoring assignments includesKey: #a).
	self assert: ((metaobject assignmentsStoring assignments at: #a) before at:1) asText equals: [ 'This is Before' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring assignments at: #a) instead) asText equals: [ 'This is Instead' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring assignments at: #a) after at:1) asText equals: [ 'This is After' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring assignments at: #b) after at: 1) asText equals: [ 'This is BAFTER' crTrace ] asText.
	self assert: ((metaobject assignmentsStoring assignments at: #c) before at: 1) asText equals: [ 'This is CBEFORE' crTrace ] asText.
	self assert: (metaobject assignmentsStoring assignments at: #c) instead isNil .
]
