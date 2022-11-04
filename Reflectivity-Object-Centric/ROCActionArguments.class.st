Class {
	#name : #ROCActionArguments,
	#superclass : #Object,
	#instVars : [
		'selector',
		'receiver',
		'arguments',
		'nodeValue'
	],
	#category : #'Reflectivity-Object-Centric-metalinks'
}

{ #category : #accessing }
ROCActionArguments >> arguments [

	^ arguments
]

{ #category : #accessing }
ROCActionArguments >> arguments: anObject [

	arguments := anObject
]

{ #category : #accessing }
ROCActionArguments >> nodeValue [

	^ nodeValue
]

{ #category : #accessing }
ROCActionArguments >> nodeValue: anObject [

	nodeValue := anObject
]

{ #category : #accessing }
ROCActionArguments >> receiver [

	^ receiver
]

{ #category : #accessing }
ROCActionArguments >> receiver: anObject [

	receiver := anObject
]

{ #category : #accessing }
ROCActionArguments >> selector [

	^ selector
]

{ #category : #accessing }
ROCActionArguments >> selector: aSelector [
	selector := aSelector
]
