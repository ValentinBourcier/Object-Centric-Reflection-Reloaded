Class {
	#name : #ROCCase,
	#superclass : #Object,
	#instVars : [
		'caseWeight',
		'caseMaterial'
	],
	#category : #'Reflectivity-Object-Centric-Tests-utils'
}

{ #category : #accessing }
ROCCase >> calculateCaseWeight [

	caseWeight := caseMaterial * 5.
]

{ #category : #accessing }
ROCCase >> caseMaterial [

	^ caseMaterial
]

{ #category : #accessing }
ROCCase >> caseMaterial: anObject [

	caseMaterial := anObject
]

{ #category : #accessing }
ROCCase >> caseWeight: anObject [

	caseWeight := anObject
]

{ #category : #accessing }
ROCCase >> weight [

	^ caseWeight.
]
