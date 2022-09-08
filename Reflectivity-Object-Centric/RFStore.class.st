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
	#name : #RFStore,
	#superclass : #Object,
	#instVars : [
		'valuesStored',
		'allValuesAfter',
		'allValuesInstead',
		'allValuesBefore'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #adding }
RFStore >> addAllValuesAfter: aBlock [

	self allValuesAfter add: aBlock.
]

{ #category : #adding }
RFStore >> addAllValuesBefore: aBlock [

	self allValuesBefore add: aBlock.
]

{ #category : #adding }
RFStore >> addAllValuesStored: aVariable [

	| aTimeObject |
	aTimeObject := valuesStored at: aVariable.
	self allValuesBefore do: [ :each | aTimeObject addBefore: each ].
	self allValuesAfter do: [ :each | aTimeObject addAfter: each ].
	self allValuesInstead ifNotNil: [ 
		aTimeObject instead: allValuesInstead ]
]

{ #category : #accessing }
RFStore >> allValuesAfter [

	^ allValuesAfter  ifNil: [ allValuesAfter := LinkedList   new ]
]

{ #category : #accessing }
RFStore >> allValuesBefore [

	^ allValuesBefore  ifNil: [ allValuesBefore := LinkedList  new ] 
]

{ #category : #accessing }
RFStore >> allValuesInstead [

	^ allValuesInstead
]

{ #category : #accessing }
RFStore >> allValuesInstead: anObject [

	allValuesInstead := anObject
]

{ #category : #accessing }
RFStore >> valuesStored [

	^ valuesStored ifNil: [ valuesStored := (Dictionary new)  ]
]

{ #category : #accessing }
RFStore >> valuesStored: anObject [

	valuesStored := anObject
]
