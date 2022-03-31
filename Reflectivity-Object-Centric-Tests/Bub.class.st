Class {
	#name : #Bub,
	#superclass : #Bib,
	#category : #'Reflectivity-Object-Centric-Tests'
}

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
