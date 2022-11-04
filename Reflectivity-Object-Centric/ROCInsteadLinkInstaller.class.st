Class {
	#name : #ROCInsteadLinkInstaller,
	#superclass : #Object,
	#instVars : [
		'linksInstalled'
	],
	#category : #'Reflectivity-Object-Centric-metalinks'
}

{ #category : #accessing }
ROCInsteadLinkInstaller >> at: aNode put: anAction [

	[ linksInstalled at: aNode ]
		on: KeyNotFound
		do: [ 
			| listOfActions |
			listOfActions := ROCLinkListOfActions new.
			listOfActions add: anAction.
			linksInstalled at: aNode put: listOfActions.
			aNode link: (self createLink: listOfActions) ]
]

{ #category : #accessing }
ROCInsteadLinkInstaller >> createLink: aListofActions [

	| link |
	link := MetaLink new.
	link control: #instead.
	link metaObject: aListofActions.
	link selector: #execute:.
	"link arguments: #( operation )."
	link arguments: #( selector receiver arguments value ).
	link optionArgsAsArray: true.
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #accessing }
ROCInsteadLinkInstaller >> linksInstalled [

	^ linksInstalled ifNil: [ linksInstalled := (Dictionary new)  ]
]

{ #category : #accessing }
ROCInsteadLinkInstaller >> linksInstalled: anObject [

	linksInstalled := anObject
]
