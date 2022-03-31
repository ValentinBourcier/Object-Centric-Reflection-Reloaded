Class {
	#name : #Bib,
	#superclass : #Bob,
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #'as yet unclassified' }
Bib >> instVarAccessInSuperCall [
	x := 1 + super instVarAccessInSuperCall.
	^x
]

{ #category : #'as yet unclassified' }
Bib >> mWithSuper [
	^super mWithSuper + 2
]

{ #category : #'as yet unclassified' }
Bib >> redefineNoSuper [

	^ super redefineNoSuper + 1
]

{ #category : #'as yet unclassified' }
Bib >> superUpToMiddleHierarchy [
	"I do not call super"
	^ 1
]
