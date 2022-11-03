Class {
	#name : #ROCLinkListOfActions,
	#superclass : #Object,
	#instVars : [
		'listOfActions'
	],
	#category : #'Reflectivity-Object-Centric-instrumentation'
}

{ #category : #accessing }
ROCLinkListOfActions >> add: anAction [

	^ self listOfActions add: anAction; yourself.
]

{ #category : #accessing }
ROCLinkListOfActions >> execute: aArguments [

	| selector receiver args value |
	selector := aArguments first.
	receiver := aArguments second.
	args := aArguments third.
	value := aArguments last.
	self listOfActions do: [ :a | [ aArguments ] ]
]

{ #category : #accessing }
ROCLinkListOfActions >> listOfActions [

	^ listOfActions ifNil: [ listOfActions := OrderedCollection new ]
]

{ #category : #accessing }
ROCLinkListOfActions >> listOfActions: anObject [

	listOfActions := anObject
]
