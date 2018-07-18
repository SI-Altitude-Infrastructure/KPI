
# Indicateurs SI AI

## Version actuelle

<p>
V1
</p>

## Changelog

- V1 Requête Dynamique d'affichage des commandes par TypeCommande/FAI/Statut/Date

## Méthodes

### FAI_GetAllCMD

#### Description

<p>
Cette méthode retourne les commandes ICC 1.6 en fonction des paramètres saisis.
Voir la définition ci-dessous pour les détails.
</p>

#### Définition

Type de valeur|Nom|Type de donnée|Obligatoire|Description|Valeurs
:---:|:---:|:---:|:---:|---|:---:
Paramètre|typeCMD|Liste|NON|Le type de commande concerné.|CREATION, UPGRADE, RESIL, ANNUL.
Paramètre|FAI|String|NON|Le FAI concerné.|WIBOX, VIALIS...
Paramètre|Statut|String|NON|Le statut de la commande dans ICC.|Accepté, Rejeté...
Paramètre|dateMin|String|NON|Date de début de la recherche au format AAAA-MM-JJ.|2018-01-01...
Paramètre|dateMax|String|NON|Date de fin de la recherche au format AAAA-MM-JJ.|2018-01-01...
Retour|totalCMD|Integer|OUI|Le nombre de commandes en retour.|3548...
Retour|CMD|Liste|NON|Les commandes en retour.|(Détails des commande)
