"
""Clase usuario""
"
Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombreUsuario',
		'contrasenia',
		'fechaHora',
		'topicosDeInteres',
		'posts',
		'follows'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Usuario class >> newNombreUsuario: unNombreUsuario contrasenia: unaContrasenia [ 
   ^self new nombreUsuario: unNombreUsuario contrasenia: unaContrasenia.
]

{ #category : #methods }
Usuario >> agregarPregunta: unaPregunta [
	posts
		add: unaPregunta
]

{ #category : #methods }
Usuario >> agregarTopicoInteres: unTopico [
	(self topicosDeInteres includes: unTopico)
		ifFalse: [ topicosDeInteres add: unTopico ]
]

{ #category : #methods }
Usuario >> cantidadPreguntas [
	^ self obtenerPreguntas size
]

{ #category : #accessing }
Usuario >> contrasenia [
^contrasenia
]

{ #category : #accessing }
Usuario >> contrasenia: anObject [
	contrasenia := anObject
]

{ #category : #methods }
Usuario >> darDislike: unPost [
	unPost darDislike: self.
]

{ #category : #methods }
Usuario >> darLike: unPost [
	unPost darLike: self
]

{ #category : #methods }
Usuario >> diferenciaLikeDislikesPreguntas [
	| preguntas |
	preguntas := self obtenerPreguntas.
	preguntas ifNotEmpty:  [ ^ preguntas sum: [ :pregunta | pregunta diferenciaLikesDislikes ] ] ifEmpty: [^0]
	
]

{ #category : #methods }
Usuario >> eliminarPregunta: unaPregunta [

self obtenerPreguntas remove: unaPregunta
]

{ #category : #accessing }
Usuario >> follows [
	^ follows
]

{ #category : #initialization }
Usuario >> initialize [
	fechaHora := DateAndTime now.
	follows := OrderedCollection new.
	posts := OrderedCollection new.
	topicosDeInteres := OrderedCollection new.
]

{ #category : #accessing }
Usuario >> nombreUsuario [
	^ nombreUsuario
]

{ #category : #accessing }
Usuario >> nombreUsuario: anObject [
	nombreUsuario := anObject
]

{ #category : #initialization }
Usuario >> nombreUsuario: unNombreUsuario contrasenia: unaContrasenia [
	nombreUsuario := unNombreUsuario.
	contrasenia := unaContrasenia.
]

{ #category : #methods }
Usuario >> obtenerPreguntas [
	^ posts select: [ :pregunta | pregunta soyPregunta ]
]

{ #category : #accessing }
Usuario >> posts [
	^ posts
]

{ #category : #methods }
Usuario >> preguntasFollowers [
	| listReturn preguntasFollowers |
	listReturn := Set new.
	preguntasFollowers := self follows
		collect: [ :f | f obtenerPreguntas ].
	preguntasFollowers do: [ :each | listReturn addAll: each ].
	^ listReturn
]

{ #category : #initialization }
Usuario >> preguntasTopicos: preguntasSistema [
	| returnList |
	returnList:= Set new.
	preguntasSistema
		do: [ :p | 
			self topicosDeInteres
				do: [ :topico | 
					(p	perteneceATopico: topico)
						ifTrue: [ returnList add: p ] ] ].
	^ returnList
]

{ #category : #methods }
Usuario >> sacarDislike: unPost [
	unPost sacarDislike: self
]

{ #category : #methods }
Usuario >> sacarLike: unPost [
	unPost sacarLike: self.
]

{ #category : #methods }
Usuario >> seguirUsuario: unUsuario [
	(self sigueAUsuario: unUsuario)
		ifFalse: [ follows add: unUsuario ]
]

{ #category : #methods }
Usuario >> sigueAUsuario: unUsuario [
	^ follows includes: unUsuario
]

{ #category : #accessing }
Usuario >> topicosDeInteres [
	^topicosDeInteres
]
