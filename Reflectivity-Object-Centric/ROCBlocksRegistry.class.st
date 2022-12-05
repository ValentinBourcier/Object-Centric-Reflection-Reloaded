"
This class is the dictionary of values to store (variables or methods) as key and a ROCBlocsExecutioinOrder as a value that indicates what blocks do in each execution order (before, instead and after):

	{
		a: anInstance of ROCBlocsExecutioinOrder ;
		b: anInstance of ROCBlocsExecutioinOrder ; 
	}
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
	aTimeObject := self blocksStored at: aVariable.
	self allBlocksBefore do: [ :each | aTimeObject addBefore: each ].
	self allBlocksAfter do: [ :each | aTimeObject addAfter: each ].
	self allBlocksInstead ifNotNil: [ 
		aTimeObject instead: allBlocksInstead ]
]
