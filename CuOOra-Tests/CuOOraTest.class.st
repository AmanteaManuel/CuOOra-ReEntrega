"
A CuOOraTest is a test class for testing the behavior of CuOOra
"
Class {
	#name : #CuOOraTest,
	#superclass : #TestCase,
	#instVars : [
		'sistema',
		'usuarioLogueado'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #running }
CuOOraTest >> setUp [
	| usuario pregunta t1 t2 t3 tList u |
	u := Usuario newNombreUsuario: 'user' contrasenia: '123'.
	sistema := CuOOra new.
	tList := OrderedCollection new.

	"Agrego usuarios al sistema"
	usuario := sistema altaUsuario: 'user' contrasenia: '123'.
	usuarioLogueado := usuario.

	"-----------------------------------------------------------"
	"Agrego topicos"
	t1 := sistema altaTopico: 'SQL' descripcion: 'Prueba'.
	t2 := sistema altaTopico: 'Smalltalk' descripcion: 'Prueba'.
	t3 := sistema altaTopico: 'POO' descripcion: 'Prueba'.
	tList
		add: t1;
		add: t2;
		add: t3.
	"-----------------------------------------------------------"
	sistema
		altaPregunta: 'select?'
		descripcion: 'como se hace un select'
		topicos: tList
		usuario: u.
	sistema
		altaPregunta: 'select??'
		descripcion: 'como se hace un select'
		topicos: tList
		usuario: u.
	sistema
		altaPregunta: 'OrderedCollection?'
		descripcion: 'como creo una instancia?'
		topicos: tList
		usuario: u.
	sistema
		altaPregunta: 'OrderedCollection?'
		descripcion: 'como creo una instancia?'
		topicos: tList
		usuario: u.
	pregunta := sistema preguntas last.
	sistema
		altaPregunta: 'prueba?'
		descripcion: 'preuba?'
		topicos: tList
		usuario: usuarioLogueado.
	
	"-----------------------------------------------------------"
	sistema
		altaRespuesta: 'La respuesta es...'
		pregunta: pregunta
		usuario: usuarioLogueado
]

{ #category : #test }
CuOOraTest >> testAltaDislikeDe [
	| p dislike |
	p := Pregunta new.
	dislike := sistema altaDislike: p de: usuarioLogueado.
	sistema altaDislike: p de: usuarioLogueado.
	self assert: p reacciones size equals: 1.
	self assert: (p reacciones includes: dislike).
]

{ #category : #test }
CuOOraTest >> testAltaLikeDe [
	| p like |
	p := sistema preguntas last.
	like:= sistema altaLike: p de: usuarioLogueado.
	sistema altaLike: p de: usuarioLogueado.
	self assert: p reacciones size equals: 1.
	self assert: (p reacciones includes: like)
]

{ #category : #test }
CuOOraTest >> testAltaPreguntaDescripcionTopicosUsuario [
	| p |
	"como regla de negocio el topico ya debe estar cargado en el sistema."
	p := sistema
		altaPregunta: 'collect pharo'
		descripcion: 'no anda'
		topicos: 'OO1, pharo'
		usuario: usuarioLogueado.
	self assert: [ sistema preguntas includes: p ].
	self assert: [ usuarioLogueado posts includes: p ]
]

{ #category : #test }
CuOOraTest >> testAltaRespuestaPreguntaUsuario [
	| p r |
	p := sistema preguntas first.
	r := sistema
		altaRespuesta: 'La solucion es...'
		pregunta: p
		usuario: usuarioLogueado.
	self assert: (p respuestas includes: r)
]

{ #category : #test }
CuOOraTest >> testAltaTopicoDescripcion [
	| t topicosRepetidos |
	t := sistema altaTopico: 'Programacion' descripcion: 'prueba'.
	self assert: (sistema topicos includes: t).
	"Pruebo con un topico que ya exista."
	t := sistema altaTopico: 'POO' descripcion: 'Prueba'.
	topicosRepetidos := (sistema topicos
		select: [ :topic | topic nombre = 'POO' ]) size.
	self deny: topicosRepetidos equals: 2
]

{ #category : #test }
CuOOraTest >> testAltaTopicoInteresDe [
	| t |
	"Toma el ultimo de los topicos de la lista, y lo agrega como topico de interes
	del usuario."
	t := sistema topicos last.
	sistema altaTopicoInteres: t de: usuarioLogueado.
	sistema altaTopicoInteres: t de: usuarioLogueado.
	self assert: (usuarioLogueado topicosDeInteres includes: t).
	self assert: (usuarioLogueado topicosDeInteres size) equals: 1
]

{ #category : #test }
CuOOraTest >> testAltaUsuarioContrasenia [
	| u |
	u := sistema altaUsuario: 'usuarioNuevo' contrasenia: '123'.
	self assert: (sistema usuarios includes: u).
	u := sistema altaUsuario:'user' contrasenia: '123'.
	self deny: (sistema usuarios includes: u)
]

{ #category : #test }
CuOOraTest >> testCalcularPuntaje [
	| u2 u3 u4 p2 |
	u2 := Usuario newNombreUsuario: 'u2' contrasenia: '123'.
	u3 := Usuario newNombreUsuario: 'conUnaPregunta' contrasenia: '123'.
	u4 := Usuario
		newNombreUsuario: 'conUnaPreguntaUnaRespuesta'
		contrasenia: '123'.
	sistema
		altaPregunta: 'prueba1'
		descripcion: 'prueba1'
		topicos: OrderedCollection new
		usuario: u3.
	p2 := sistema
		altaPregunta: 'prueba2'
		descripcion: 'prueba2'
		topicos: OrderedCollection new
		usuario: u4.
	sistema altaRespuesta: 'asdasd' pregunta: p2 usuario: u4.
	sistema altaLike: p2 de: usuarioLogueado.
	sistema altaDislike: p2 de: u2.
	sistema altaDislike: p2 de: u3.

	"usuario2 no tiene preguntas ni respuestas.Puntaje: 0"
	self assert: (sistema calcularPuntaje: u2) equals: 0.

	"u3 tiene una pregunta. Puntaje: 20"
	self assert: (sistema calcularPuntaje: u3) equals: 20.

	"usuario tiene una pregunta, una respuesta, un like y dos dislikes. Puntaje: 69 "
	self assert: (sistema calcularPuntaje: u4) equals: 69.

	"u4 tiene una pregunta y una respuesta. Puntaje: 70."
	self assert: (sistema calcularPuntaje: usuarioLogueado) equals: 70
]

{ #category : #test }
CuOOraTest >> testExisteNombreUsuario [
	self assert: (sistema existeNombreUsuario:'user').
	self deny: (sistema existeNombreUsuario:'nombreDisponible').
]

{ #category : #test }
CuOOraTest >> testNombreUsuarioContrasenia [
	self
		assert: ((sistema nombreUsuario: 'user' contrasenia: '123') isNotNil);
		deny: ((sistema nombreUsuario: 'user' contrasenia: 'asd') isNotNil).
]

{ #category : #test }
CuOOraTest >> testObtenerPreguntasRelevantesUsuario [
	| topicoInteres follow randomUser user preg1 preg2 preg3 preguntasRelevantes |
	user := sistema usuarios detect: [ :u | u nombreUsuario = 'user' ].
	topicoInteres := sistema topicos detect: [ :t | t nombre = 'POO' ].
	follow := sistema altaUsuario: 'follow' contrasenia: '123'.
	randomUser := sistema altaUsuario: 'randomUser' contrasenia: '123'.
	"pregunta por follow"
	preg1 := sistema
		altaPregunta: 'TestUI'
		descripcion: 'ayuda!'
		topicos: 'TestUI'
		usuario: follow.
	"pregunta por topico"
	preg2 := sistema
		altaPregunta: 'Test'
		descripcion: 'ayuda!'
		topicos: 'POO, Programming'
		usuario: randomUser.
	"no debe estar"
	preg3 := sistema
		altaPregunta: 'TestFalse'
		descripcion: 'ayuda!'
		topicos: 'False'
		usuario: randomUser.
	sistema usuario: user seguirA: follow.
	sistema altaTopicoInteres: topicoInteres de: user.
	preguntasRelevantes := sistema
		obtenerPreguntasRelevantesUsuario: user.
	self assert: (preguntasRelevantes includes: preg1).
	self assert: (preguntasRelevantes includes: preg2).
	self deny: (preguntasRelevantes includes: preg3)
]

{ #category : #test }
CuOOraTest >> testObtenerPreguntasUsuario [
	self
		assert: (sistema obtenerPreguntasUsuario: usuarioLogueado) size
		equals: 1
]

{ #category : #test }
CuOOraTest >> testObtenerRespuestasUsuario [
	| list |
	list := sistema obtenerRespuestasUsuario:usuarioLogueado .
	self assert: list size equals: 1
]

{ #category : #test }
CuOOraTest >> testUsuarioSeguirA [
	| u1 |
	u1 := Usuario new.
	sistema usuario: usuarioLogueado seguirA: u1.
	sistema usuario: usuarioLogueado seguirA: u1.
	self assert: (usuarioLogueado follows includes: u1).
	self assert: usuarioLogueado follows size equals: 1
]

{ #category : #test }
CuOOraTest >> testValidarTopico [
	| list |
	list := sistema validarTopico: 'Consultas'.
	self assert: list isNil.
	list := sistema validarTopico: 'SQL'.
	self assert: list isNotNil.
]
