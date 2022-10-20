Class {
	#name : #ROCBox,
	#superclass : #ROCCase,
	#instVars : [
		'height',
		'width',
		'depth',
		'boxWeight'
	],
	#category : #'Reflectivity-Object-Centric-Tests-utils'
}

{ #category : #accessing }
ROCBox >> boxWeight [

	^ boxWeight
]

{ #category : #accessing }
ROCBox >> boxWeight: anObject [

	boxWeight := anObject
]

{ #category : #accessing }
ROCBox >> calculateBoxWeight [

	boxWeight := width * height * depth * 0.001
]

{ #category : #accessing }
ROCBox >> depth [

	^ depth
]

{ #category : #accessing }
ROCBox >> depth: anObject [

	depth := anObject
]

{ #category : #accessing }
ROCBox >> height [

	^ height
]

{ #category : #accessing }
ROCBox >> height: anObject [

	height := anObject
]

{ #category : #'api - accessing' }
ROCBox >> weight [ 

	super weight + boxWeight
]

{ #category : #accessing }
ROCBox >> width [

	^ width
]

{ #category : #accessing }
ROCBox >> width: anObject [

	width := anObject
]
