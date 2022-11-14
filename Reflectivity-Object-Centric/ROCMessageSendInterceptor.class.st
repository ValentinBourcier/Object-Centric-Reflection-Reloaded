"
I am the Interceptor for messageSend, I have as arguments the reification arguments , for message send nodes
"
Class {
	#name : #ROCMessageSendInterceptor,
	#superclass : #ROCAbstractInterceptor,
	#category : #'Reflectivity-Object-Centric-interceptors'
}

{ #category : #execution }
ROCMessageSendInterceptor >> execute: anArrayOfArguments [

	"receive all sends filter by self if the receiver is the object who insrument if yes propagate and then call my method to do reflective part"

	| selector receiver args |
	selector := anArrayOfArguments first.
	receiver := anArrayOfArguments second.
	args := anArrayOfArguments third.

	receiver == self receiver ifTrue: [ 
		metaObject instrumenter instrumentSelector: selector withArgs: args ].
	^ metaObject executeReflectiveOperationsForMessageSend: anArrayOfArguments
]

{ #category : #override }
ROCMessageSendInterceptor >> execute: aName withValue: aValue [
]

{ #category : #execution }
ROCMessageSendInterceptor >> executeOperation2: anOperation [

	^ metaObject executeReflectiveOperationsForMessageSendOperation:  anOperation
]

{ #category : #execution }
ROCMessageSendInterceptor >> executeOperation: anOperation [

	anOperation receiver == self receiver ifTrue: [ 
		metaObject instrumenter
			instrumentSelector: anOperation selector
			withArgs: anOperation arguments ].

	^ metaObject executeReflectiveOperationsForMessageSendOperation: anOperation
]
