Class {
	#name : #ROCMessageSendInterceptor,
	#superclass : #ROCAbstractInterceptor,
	#instVars : [
		'receiver'
	],
	#category : #'Reflectivity-Object-Centric-interceptors'
}

{ #category : #execution }
ROCMessageSendInterceptor >> execute: aOperation [

	"receive all sends filter by self if the receiver is the object who insrument if yes propagate and then call my method to do reflective part"

	aOperation receiver == self receiver ifTrue: [ 
		metaObject
			receive: aOperation selector
			withArgs: aOperation arguments ].
	^ metaObject linkInsteadMessageSend: aOperation

	"linkInsteadMessageSend:withValue:"
]

{ #category : #override }
ROCMessageSendInterceptor >> execute: aName withValue: aValue [
]

{ #category : #accessing }
ROCMessageSendInterceptor >> receiver [

	^ receiver
]

{ #category : #accessing }
ROCMessageSendInterceptor >> receiver: anObject [

	receiver := anObject
]
