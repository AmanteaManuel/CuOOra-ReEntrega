"
Clase que modela el sistema
"
Class {
	#name : #CuOOra,
	#superclass : #Object,
	#instVars : [
		'usuarios',
		'topicos',
		'preguntas'
	],
	#classInstVars : [
		'soleInstance'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
CuOOra class >> clearSoleInstance [
	
	soleInstance := nil
]

{ #category : #'instance creation' }
CuOOra class >> soleInstance [
	^ soleInstance ifNil: [ soleInstance := self new ]
]

{ #category : #methods }
CuOOra >> altaDislike: post de: anUser [
	^ post darDislike: anUser
]

{ #category : #methods }
CuOOra >> altaLike: post de: anUser [
	^ post darLike: anUser
]

{ #category : #methods }
CuOOra >> altaPregunta: tituloStr descripcion: descripcionStr topicos: topicosStr usuario: anUser [
	| p topicosList |
	topicosList := (self generarListaTopicos: topicosStr).
	p := Pregunta
		newPregunta: tituloStr
		descripcion: descripcionStr
		topicos: topicosList
		usuario: anUser.
	anUser agregarPregunta: p.
	preguntas add: p.
	^ p
]

{ #category : #methods }
CuOOra >> altaRespuesta: descripcionStr pregunta: preguntaObj usuario: anUser [
	| r |
	r := Respuesta newRespuesta: descripcionStr usuario: anUser.
	preguntaObj agregarRespuesta: r.
	^ r
	"DEBERIAMOS DE AGREGARO LOS OBJETOS CAMBIADOS A LA LISTA OTRA VEZ????"
]

{ #category : #methods }
CuOOra >> altaTopico: nombreStr descripcion: descripcionStr [
	| topico |
	topico := self validarTopico: nombreStr.
	topico
		ifNil: [ 
			topico := Topico newTopico: nombreStr descripcion: descripcionStr.
			topicos add: topico ].
		^ topico.
		
]

{ #category : #methods }
CuOOra >> altaTopicoInteres: topicoObj de: anUser [
	anUser agregarTopicoInteres: topicoObj.
	^ topicoObj
]

{ #category : #methods }
CuOOra >> altaUsuario: nombreStr contrasenia: contraseniaStr [
	|u|
	(self existeNombreUsuario: nombreStr)
		ifTrue: [ ^ self ].
		u:= (Usuario newNombreUsuario: nombreStr contrasenia: contraseniaStr).
		usuarios add: u.
		^u.
]

{ #category : #methods }
CuOOra >> calcularPuntajeUsuario:unUsuario [
	^ (unUsuario calcularPuntaje).
]

{ #category : #methods }
CuOOra >> existeNombreUsuario: nombreStr [
	^ usuarios anySatisfy: [ :user | user nombreUsuario = nombreStr ]
]

{ #category : #methods }
CuOOra >> generarListaTopicos: topicoslist [
	| list topicosStrList  |		
	list := OrderedCollection new.
	topicosStrList := topicoslist splitOn: ','.
	topicosStrList
		do: [ :t | list add: (self altaTopico: t descripcion: t) ].
		^list.
]

{ #category : #initialization }
CuOOra >> initialize [
	usuarios := OrderedCollection new.
	topicos := OrderedCollection new.
	preguntas := OrderedCollection new.
	self setearVariables
]

{ #category : #methods }
CuOOra >> nombreUsuario: unNombre contrasenia: contrasenia [
	^ usuarios detect: [ :u | u nombreUsuario= unNombre & (u contrasenia = contrasenia) ]
	ifNone: [ nil ]
]

{ #category : #methods }
CuOOra >> obtenerPreguntasRelevantesUsuario: anUser [
	| preguntasFollow preguntasTopicos |
	preguntasFollow := Set new.
	preguntasTopicos := Set new.
	preguntasFollow := anUser preguntasFollowers.
	preguntasTopicos := anUser preguntasTopicos:preguntas.
	preguntasFollow addAll: preguntasTopicos.
	^ preguntasFollow
]

{ #category : #methods }
CuOOra >> obtenerPreguntasUsuario: unUsuario [
	^ (unUsuario obtenerPreguntas)
]

{ #category : #methods }
CuOOra >> obtenerRespuestasUsuario: unUsuario [
	^ (unUsuario obtenerRespuestas)
]

{ #category : #accessing }
CuOOra >> preguntas [
	^ preguntas
]

{ #category : #accessing }
CuOOra >> preguntas: anObject [
	preguntas := anObject
]

{ #category : #initialization }
CuOOra >> setearVariables [
	| u1 u2 u3 t1 t2 t3 p1 p2 r1 r2 tList |
	"Agregar usuarios"
	u1 := self
		altaUsuario: 'pedro@cuoora.com'
		contrasenia: 'pedro@cuoora.com'.
	u2 := self
		altaUsuario: 'diego@cuoora.com'
		contrasenia: 'diego@cuoora.com'.
	u3 := self
		altaUsuario: 'juan@cuoora.com'
		contrasenia: 'juan@cuoora.com'.

	"Relaciones entre usuarios"
	self usuario: u3 seguirA: u2.
	self usuario: u1 seguirA: u3.

	"Topicos"
	t1 := self altaTopico: 'OO1' descripcion: 'Orientacion a objetos 1'.
	t2 := self altaTopico: 'Test de unidad' descripcion: 'tests'.
	t3 := self
		altaTopico: 'Smalltalk'
		descripcion: 'Lenguaje de programacion'.

	"Preguntas"
	tList := OrderedCollection new.
	tList add: t1.
	tList add: t2.
	p1 := self
		altaPregunta: '¿Para qué sirve el metodo setUp?'
		descripcion: ''
		topicos: 'OO1,Test de unidad'
		usuario: u1.
	tList := OrderedCollection new.
	tList add: t1.
	tList add: t3.
	p2 := self
		altaPregunta: '¿Qué significa #messageNotUnderstood?'
		descripcion: ''
		topicos: 'OO1,Smalltalk'
		usuario: u2.

	"Respuesta"
	r1 := self
		altaRespuesta:
			'Sirve para instanciar los objetos que son evaluados por el test en un unico metodo y que se ejecute siempre antes de cada test.'
		pregunta: p1
		usuario: u3.
	r2 := self
		altaRespuesta:
			'Significa que el objeto que recibio el mensaje no encontro ningun metodo para ejecutar en respuesta.'
		pregunta: p2 usuario: u1.
]

{ #category : #accessing }
CuOOra >> topicos [
	^ topicos
]

{ #category : #accessing }
CuOOra >> topicos: anObject [
	topicos := anObject
]

{ #category : #methods }
CuOOra >> ultimasCincoPreguntasDe:usuario [
	| p |
	p := self obtenerPreguntasUsuario:usuario.
	^ self ultimosCinco: p.
]

{ #category : #methods }
CuOOra >> ultimasCincoRelevantes:usuario [
	| p |
	p := self obtenerPreguntasRelevantesUsuario:usuario.
	^ self ultimosCinco: p.
]

{ #category : #methods }
CuOOra >> ultimosCinco:posteo [
	|list|
	list:= posteo asSortedCollection: [ :p1 :p2 | p1 fechaYHora > p2 fechaYHora  ].
	list size > 5
		ifTrue: [ ^ list last: 5 ]
		ifFalse: [ ^ list ]
		
	
]

{ #category : #methods }
CuOOra >> usuario: unUsuarioLogueado seguirA: otroUsuario [
	^ (unUsuarioLogueado seguirUsuario: otroUsuario).
]

{ #category : #accessing }
CuOOra >> usuarios [
	^ usuarios
]

{ #category : #accessing }
CuOOra >> usuarios: anObject [
	usuarios := anObject
]

{ #category : #methods }
CuOOra >> validarTopico: nombreStr [
	^ topicos
		detect: [ :topico | topico existeNombre: nombreStr ]
		ifNone: [ nil ]
]
