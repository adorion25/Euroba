extends Control 
class_name Interface

@export_group("Simulation")
@export var lune : Lune

@export_group("Textes")
@export var rayon_1 : Label
@export var vitesse_1 : Label
@export var rayon_2 : Label
@export var vitesse_2 : Label

@export var distance : Label
@export var point : Label

@export var vitesse_simulation : Label


func _process(delta:float) -> void:
	rayon_1.text = format_scientifique(lune.r_1.length())
	vitesse_1.text = format_scientifique(lune.v_1.length())
	rayon_2.text = format_scientifique(lune.r_2.length())
	vitesse_2.text = format_scientifique(lune.v_2.length())
	distance.text = format_scientifique(abs(lune.r_1.length() - lune.r_2.length()))
	
	if lune.r_1.length() < lune.r_2.length():
		point.text = "Point rouge"
	else:
		point.text = "Point bleu"

func changer_mode_pause(mode_pause : bool) -> void:
	"""Change l'état de pause à chacun des astres
	
	Paramètre :
	etat_pause -- est-ce que la simulation est en pause ou non """
	lune.mettre_en_pause(mode_pause)


func format_scientifique(valeur : float) -> String:
	"""Converti en format scientifique les nombres décimaux avec 3 décimales
	
	Parametre:
	valeur -- la valeur à afficher de façon scientifique
	
	Retour:
	une chaîne de caractères représentant ce nombre
	"""
	var nombre_decimales = int(log(valeur) / log(10))
	var nombre_presente = valeur / 10**nombre_decimales
	return "%.3f" % nombre_presente + "e" + "%s" % nombre_decimales


func _on_h_slider_value_changed(valeur: float) -> void:
	"""Modifie la l'échelle de temps de la simulation lorsque le slider est utilisé
	
	Parametre:
	valeur -- la valeur du multiplicateur de temps
	
	Retour:
	une chaîne de caractères représentant ce nombre
	"""
	lune.echelle_temps = valeur
	vitesse_simulation.text = "x" + "%.1f" % valeur
