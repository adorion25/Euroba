extends RigidBody3D
class_name Lune

@export_group("Paramètre de conversion simulation")
@export var min_distance_simulee : float
@export var max_distance_simulee : float
@export var min_distance_reelle : float
@export var max_distance_reelle : float

@export_group("Simulation gravitationnelle")
@export var masse_centre_rotation : float
@export var masse_corps : float
@export var periode_relative : float

@export_group("Point d'Europe")
@export var rayon_initial : float
@export var vitesse_initiale : float

@export_group("Paramètres d'Euler")
@export var etapes_calcul_par_ecran : int

var elasticite : float = 1e14
var distance_equilibre : float = 24.97e6
var coeff_dissipation : float = 4e16
var G : float = 6.673e-11
var r_1 : Vector3
var v_1 : Vector3
var r_2 : Vector3
var v_2 : Vector3
var a_1 : Vector3
var periode : float = 299.819e3

@export var europe_2 : RigidBody3D

var pause : bool

var echelle_temps : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	r_1 = rayon_initial * Vector3(1, 0, 0)
	v_1 = vitesse_initiale * Vector3(0, 0, 1)
	
	pause = false

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pause :
		return
	
	r_2 = europe_2.r_1
	v_2 = europe_2.v_1
	appliquer_euler(delta*echelle_temps)

	position = conv_position_reelle_a_simulee(r_1)
	
func conv_position_reelle_a_simulee(position_reelle : Vector3) -> Vector3:
	"""Effectue la conversion d'une position réelle à une position de l'espace 
	de la simulation
	
	Paramètres:
	position_reelle -- la position réelle à convertir
	
	Retour :
	la position dans le monde de la simulation à utiliser
	"""
	
	var distance_relle = position_reelle.length()
	var ratio_distance = inverse_lerp(min_distance_reelle, max_distance_reelle, 
		distance_relle)
	var facteur_distance_simulee = lerp (min_distance_simulee, max_distance_simulee,
		ratio_distance)
	
	return position_reelle.normalized() * facteur_distance_simulee

func appliquer_euler(temps_dernier_ecran : float) -> void:
	"""
	Applique la méthode d'Euler pour déterminer la position et la vitesse selon
	le temps de la simulation. Toutes les forces en jeu sur l'objet y sont calculées 
	pour simuler la position future.
	
	Paramètre:
	temps_dernier_ecran -- le temps écoulé depuis le dernier écran.
	"""
	var nb_periode = temps_dernier_ecran * periode / periode_relative
	var h = nb_periode / etapes_calcul_par_ecran
	for i in range(etapes_calcul_par_ecran):
		
		var force_gravitationnelle = -G * (masse_corps / 2 * masse_centre_rotation) / r_1.length()**3 * r_1
		var force_ressort = elasticite * ((r_2 - r_1).length() - distance_equilibre) * (r_2 - r_1).normalized()
		var force_frottement = coeff_dissipation * (v_2 - v_1)
		
		a_1 = (force_gravitationnelle + force_ressort + force_frottement) / (masse_corps / 2)
		v_1 += h * a_1
		r_1 += h * v_1
		
		
func mettre_en_pause(mode_pause: bool) -> void:
	"""Change le mode de la simulation (pause/"play")
	
	Parametre :
	mode_pause -- booléen contenant True si la simulation est en pause.
	"""
	pause = mode_pause
