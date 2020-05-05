Class {
	#name : #SessionWithUser,
	#superclass : #WASession,
	#instVars : [
		'usuario',
		'model'
	],
	#category : #'CuOOra-ui'
}

{ #category : #accessing }
SessionWithUser >> model [
	^ model
]

{ #category : #accessing }
SessionWithUser >> model: anObject [
	model := anObject
]

{ #category : #accessing }
SessionWithUser >> usuario [
	^ usuario
]

{ #category : #accessing }
SessionWithUser >> usuario: anObject [
	usuario := anObject
]
