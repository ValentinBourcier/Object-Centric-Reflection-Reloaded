Class {
	#name : #ROCLinkListOfActions,
	#superclass : #Object,
	#instVars : [
		'listOfActions'
	],
	#category : #'Reflectivity-Object-Centric-metalinks'
}

{ #category : #accessing }
ROCLinkListOfActions >> add: anAction [

	^ self listOfActions add: anAction; yourself.
]

{ #category : #accessing }
ROCLinkListOfActions >> execute: aArguments [

	| arguments |
	
	arguments := ROCActionArguments new 
		selector: aArguments first;
		receiver: aArguments second;
		arguments: aArguments third;
		value: aArguments last;
		yourself.
	
	self listOfActions do: [ :a | a execute: arguments ]
]

{ #category : #accessing }
ROCLinkListOfActions >> listOfActions [

	^ listOfActions ifNil: [ listOfActions := OrderedCollection new ]
]

{ #category : #accessing }
ROCLinkListOfActions >> listOfActions: anObject [

	listOfActions := anObject
]
