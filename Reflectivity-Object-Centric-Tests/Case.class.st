Class {
	#name : #Case,
	#superclass : #Object,
	#instVars : [
		'caseWeight',
		'caseMaterial'
	],
	#category : #'Reflectivity-Object-Centric-Tests-utils'
}

{ #category : #accessing }
Case >> calculateCaseWeight [

	caseWeight := caseMaterial * 5.
]

{ #category : #accessing }
Case >> caseMaterial [

	^ caseMaterial
]

{ #category : #accessing }
Case >> caseMaterial: anObject [

	caseMaterial := anObject
]

{ #category : #accessing }
Case >> caseWeight: anObject [

	caseWeight := anObject
]

{ #category : #accessing }
Case >> weight [

	^ caseWeight.
]
