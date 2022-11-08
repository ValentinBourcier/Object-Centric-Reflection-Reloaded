"
This class is the dictionary of the values to store (variables or methods) as key and a RFControlStoreObject as a value that indicates what blocks do in each Case:

	{
		a: anInstance of RFControlStoreObject ;
		b: anInstance of RFControlStoreObject ; 
	}

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	allValuesAfter:		<Object>
	allValuesBefore:		<Object>
	allValuesInstead:		<Object>
	valuesStored:		<Object>


    Implementation Points
"
Class {
	#name : #ROCBlocksRegistry,
	#superclass : #Object,
	#instVars : [
		'allBlocksAfter',
		'allBlocksBefore',
		'allBlocksInstead',
		'blocksStored'
	],
	#category : #'Reflectivity-Object-Centric-metaobjects'
}

{ #category : #adding }
ROCBlocksRegistry >> addAllBlocksAfter: aBlock [

	self allBlocksAfter add: aBlock.
]

{ #category : #adding }
ROCBlocksRegistry >> addAllBlocksBefore: aBlock [

	self allBlocksBefore add: aBlock.
]

{ #category : #accessing }
ROCBlocksRegistry >> allBlocksAfter [

	^ allBlocksAfter  ifNil: [ allBlocksAfter := LinkedList   new ]
]

{ #category : #accessing }
ROCBlocksRegistry >> allBlocksBefore [

	^ allBlocksBefore  ifNil: [ allBlocksBefore := LinkedList  new ] 
]

{ #category : #accessing }
ROCBlocksRegistry >> allBlocksInstead [

	^ allBlocksInstead
]

{ #category : #accessing }
ROCBlocksRegistry >> allBlocksInstead: anObject [

	allBlocksInstead := anObject
]

{ #category : #accessing }
ROCBlocksRegistry >> blocksStored [

	^ blocksStored ifNil: [ blocksStored := (Dictionary new)  ]
]

{ #category : #accessing }
ROCBlocksRegistry >> blocksStored: anObject [

	blocksStored := anObject
]

{ #category : #propagating }
ROCBlocksRegistry >> propagateAllBlocksStored: aVariable [

	| aTimeObject |
	aTimeObject := blocksStored at: aVariable.
	self allBlocksBefore do: [ :each | aTimeObject addBefore: each ].
	self allBlocksAfter do: [ :each | aTimeObject addAfter: each ].
	self allBlocksInstead ifNotNil: [ 
		aTimeObject instead: allBlocksInstead ]
]
