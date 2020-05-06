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
	| usuario pregunta t1 t2 t3 tList respuesta u |
	u:= Usuario newNombreUsuario: 'user' contrasenia:'123'.
	sistema := CuOOra new.
	tList := OrderedCollection new.
	"Agrego usuarios al sistema"
	usuario := Usuario newNombreUsuario: 'user' contrasenia: '123'.
	sistema usuarios add: usuario.
	usuarioLogueado := usuario.
	
	"-----------------------------------------------------------"
	"Agrego topicos"
	t1 := Topico newTopico: 'SQL' descripcion: 'prueba'.
	sistema topicos add: t1.
	t2 := Topico newTopico: 'Smalltalk' descripcion: 'prueba'.
	sistema topicos add: t2.
	t3 := Topico newTopico: 'POO' descripcion: 'prueba'.
	sistema topicos add: t3.
	tList add: t1.
	tList add: t2.
	"-----------------------------------------------------------"
	pregunta := Pregunta
		newPregunta: 'select?'
		descripcion: 'como se hace un select'
		topicos: tList
		usuario:u.
	sistema preguntas add: pregunta.
	usuarioLogueado posts add: pregunta.
	pregunta := Pregunta
		newPregunta: 'OrderedCollection?'
		descripcion: 'como creo una instancia?'
		topicos: tList
		usuario:u.
	sistema preguntas add: pregunta.
	"-----------------------------------------------------------"
	respuesta := Respuesta
		newRespuesta: 'La respuesta es...'
		usuario: usuarioLogueado.
	pregunta respuestas add: respuesta.
	usuarioLogueado posts add: respuesta
]

{ #category : #test }
CuOOraTest >> testAltaDislikeDe [
	| p |
	p := Pregunta new.
	sistema altaDislike: p de: usuarioLogueado.
	self assert: p reacciones size equals: 1
]

{ #category : #test }
CuOOraTest >> testAltaLikeDe [
	| p |
	p := sistema preguntas last.
	sistema altaLike: p de: usuarioLogueado.
	self assert: p cantLikes equals: 1
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
	self assert: (usuarioLogueado topicosDeInteres includes: t)
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
CuOOraTest >> testBajaPregunta [
	| p |
	p := sistema preguntas last.
	sistema bajaPregunta: p.
	self deny: p activo
]

{ #category : #test }
CuOOraTest >> testCalcularPuntajeUsuario [
	| p |
	p := sistema calcularPuntajeUsuario: usuarioLogueado.
	self assert: p equals: 20 * 1 + (50 * 1)
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
		assert: (sistema obtenerRespuestasUsuario: usuarioLogueado) size equals:1
]

{ #category : #test }
CuOOraTest >> testObtenerRespuestasUsuario [
	self
		assert: (sistema obtenerRespuestasUsuario: usuarioLogueado) size equals: 1
]

{ #category : #test }
CuOOraTest >> testUsuarioSeguirA [
	|u1|
	u1 := Usuario new.
	sistema usuario: usuarioLogueado seguirA: u1.
	self assert:(usuarioLogueado follows includes: u1). 
]

{ #category : #test }
CuOOraTest >> testValidarTopico [
	| list |
	list := sistema validarTopico: 'Consultas'.
	self assert: list isNil.
	list := sistema validarTopico: 'SQL'.
	self assert: list isNotNil.
]
