"
THIS CLASS HAS ONLY TESTING PURPOUSE

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	newValue:		<Object>
	oldValue:		<Object>
	variable:		<Object>


    Implementation Points
"
Class {
	#name : #RFAssignmentMetaObjectInterceptor,
	#superclass : #Object,
	#instVars : [
		'variable',
		'oldValue',
		'newValue'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #accessing }
RFAssignmentMetaObjectInterceptor >> newValue [

	^ newValue
]

{ #category : #accessing }
RFAssignmentMetaObjectInterceptor >> newValue: anObject [

	newValue := anObject
]

{ #category : #accessing }
RFAssignmentMetaObjectInterceptor >> oldValue [

	^ oldValue
]

{ #category : #accessing }
RFAssignmentMetaObjectInterceptor >> oldValue: anObject [

	oldValue := anObject
]

{ #category : #accessing }
RFAssignmentMetaObjectInterceptor >> variable [

	^ variable
]

{ #category : #accessing }
RFAssignmentMetaObjectInterceptor >> variable: anObject [

	variable := anObject
]