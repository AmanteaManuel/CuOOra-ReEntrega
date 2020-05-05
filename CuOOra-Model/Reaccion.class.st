"
Una reaccion puede ser un like o dislike.
"
Class {
	#name : #Reaccion,
	#superclass : #Object,
	#instVars : [
		'fechaHora',
		'usuario'
	],
	#category : #'CuOOra-Model'
}

{ #category : #methods }
Reaccion >> initialize [ 
	fechaHora := DateAndTime now.
]

{ #category : #initialization }
Reaccion >> soyLike [
	self subclassResponsibility 
]

{ #category : #methods }
Reaccion >> tieneReaccionDe: usuarioObj [
	^ self usuario = usuarioObj
]

{ #category : #accesing }
Reaccion >> usuario [
	^usuario.
]

{ #category : #accessing }
Reaccion >> usuario: anObject [
	usuario := anObject
]
