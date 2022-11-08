"
This class store the control of the values stored that are blocks to execute, has a linkedlist for controls after, before and a value for instead:


after: #([],[],[])
before: #([],[],[])
instead: []


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
	after:		<Object>
	before:		<Object>
	instead:		<Object>


    Implementation Points
"
Class {
	#name : #ROCBlocksExecutionOrder,
	#superclass : #Object,
	#instVars : [
		'before',
		'after',
		'instead'
	],
	#category : #'Reflectivity-Object-Centric-metaobjects'
}

{ #category : #adding }
ROCBlocksExecutionOrder >> addAfter: aBlock [

	self after add: aBlock.
]

{ #category : #adding }
ROCBlocksExecutionOrder >> addBefore: aBlock [

	self before  add: aBlock
]

{ #category : #accessing }
ROCBlocksExecutionOrder >> after [

	^ after ifNil: [ after := (LinkedList new)  ]
]

{ #category : #accessing }
ROCBlocksExecutionOrder >> before [

	^ before ifNil: [ before := (LinkedList new)  ]
]

{ #category : #accessing }
ROCBlocksExecutionOrder >> instead [

	^ instead
]

{ #category : #accessing }
ROCBlocksExecutionOrder >> instead: anObject [

	instead := anObject
]
