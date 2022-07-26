Class {
	#name : #Bub,
	#superclass : #Bib,
	#instVars : [
		'var1'
	],
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #assignments }
Bub >> assignmentTest [
	var1 := 4 squared.
]

{ #category : #'as yet unclassified' }
Bub >> mWithSuper [
	^super mWithSuper + 1
]

{ #category : #'as yet unclassified' }
Bub >> redefineNoSuper [
	^1
]

{ #category : #'as yet unclassified' }
Bub >> superUpToMiddleHierarchy [
	"I call super"
	^ super superUpToMiddleHierarchy + 1
]

{ #category : #accessing }
Bub >> var1 [

	^ var1
]

{ #category : #accessing }
Bub >> var1: anObject [

	var1 := anObject
]
