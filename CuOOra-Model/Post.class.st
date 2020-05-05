"
Clase padre de pregunta y respuesta, modela una post, una publicacion o una respuesta en el sistema
"
Class {
	#name : #Post,
	#superclass : #Object,
	#instVars : [
		'descripcion',
		'fecha',
		'hora',
		'activo',
		'reacciones',
		'usuario'
	],
	#category : #'CuOOra-Model'
}

{ #category : #accesing }
Post >> activo [
	^ activo.
]

{ #category : #accesing }
Post >> activo: bool [ 
	activo :=bool. 
]

{ #category : #methods }
Post >> cantDislikes [
	^ (reacciones select: [ :reacion | reacion soyLike not ]) size
]

{ #category : #methods }
Post >> cantLikes [
	^ (reacciones select: [ :reacion | reacion soyLike ]) size
]

{ #category : #methods }
Post >> darDislike: usuarioObj [
	(self tieneDislikeDe: usuarioObj)
		ifTrue: [ ^ self ]
		ifFalse: [ (self tieneLikeDe: usuarioObj)
				ifTrue: [ self sacarReaccion: usuarioObj ].
			^ reacciones add: (Dislike newDislike: usuarioObj) ]
]

{ #category : #methods }
Post >> darLike: usuarioObj [
	"Si el post tiene like, retorna self. 
Si el post tiene dislike o no tiene nada, agrega el like"

	(self tieneLikeDe: usuarioObj)
		ifTrue: [ ^ self ]
		ifFalse: [ (self tieneDislikeDe: usuarioObj)
				ifTrue: [ self sacarReaccion: usuarioObj ].
			^ reacciones add: (Like newLike: usuarioObj) ]
]

{ #category : #accesing }
Post >> descripcion [
	^ descripcion.
]

{ #category : #accesing }
Post >> descripcion: unString [
	descripcion:= unString.
]

{ #category : #methods }
Post >> diferenciaLikesDislikes [
	^ self cantLikes - self cantDislikes.
]

{ #category : #accesing }
Post >> fecha [
	^fecha.
]

{ #category : #accesing }
Post >> fecha: date [ 
	fecha := date.
]

{ #category : #accesing }
Post >> fechaYHora [

^ (DateAndTime year: (fecha year) day:(fecha day) hour:(hora hour) minute: (hora minute) second: (hora second)).
	
]

{ #category : #accesing }
Post >> hora [
	^ hora.
]

{ #category : #accesing }
Post >> hora: time [ 
	hora:= time.
]

{ #category : #methods }
Post >> ponerInactivo [
	self activo: false.
]

{ #category : #accesing }
Post >> reacciones [
	^reacciones.
]

{ #category : #accesing }
Post >> reacciones: list [.
	reacciones:= list.
]

{ #category : #methods }
Post >> sacarReaccion: usuarioObj [
	"Saca la reaccion, tiene como precondicion que  la reaccion existe
	y que se sabe cual es su tipo. 
	"

	| reacc |
	reacc := reacciones detect: [ :r | r tieneReaccionDe: usuarioObj ].
	reacciones remove: reacc
]

{ #category : #methods }
Post >> soyPregunta [
 ^ self subclassResponsibility.
]

{ #category : #methods }
Post >> tieneDislikeDe: usuarioObj [
	| dislikes |
	dislikes := reacciones reject: [ :r | r soyLike ].
	^ dislikes anySatisfy: [ :l | l tieneReaccionDe: usuarioObj ]
]

{ #category : #methods }
Post >> tieneLikeDe: usuarioObj [
	| likes |
	likes := reacciones select: [ :r | r soyLike ].
	^ likes anySatisfy: [ :l | l tieneReaccionDe: usuarioObj ]
]

{ #category : #accessing }
Post >> usuario [
	^ usuario
]

{ #category : #accessing }
Post >> usuario: anObject [
	usuario := anObject
]
