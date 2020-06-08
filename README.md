# LUA-Etat_Batterie
Ce script pour Domoticz, permet d'être informé par mail lorsque la batterie d'un capteur est à un niveau trop faible.

# Explications
Ce sript peut-être placé, soit dans le dossier "domoticz/scripts/lua", soit dans un événement en sélectionnant "LUA", puis déclencheur "Time".

Les variables :
- BatteryThreshold = niveau mini à partir duquel nous souhaitons recevoir un mail.
- WeeklySummary = "true" ou "false", suivant que l'on souhaite ou pas avoir un récapitulatif de l'état des batteries une fois par semaine.
- SummaryDay = si "WeeklySummary = true", quel jour sera envoyé le récapitulatif (1 = dimanche)
- EmailTo = Adresse mail du destinataire du mail.
- ReportHour = Heure de déclenchement de la vérification.
- ReportMinute = Minute de déclenchement de la vérification.
- Domoticz = Protocole et Adresse de Domoticz (par défaut, "http://localhost")
- DomoticzPort = Port de connexion à Domoticz (par défaut, "8080")
- Sujet = ''          // Ne pas modifier, Initialisation de la variable
- Message = ''        // Ne pas modifier, Initialisation de la variable
- EnvoiMail = false   // Ne pas modifier, Initialisation de la variable

Si vous souhaitez scanner que les Capteurs qui sont actif, vous pouvez décommenter dans le script les deux lignes en fin de IF :
- if device.BatteryLevel < 100 then -- and device.Used == 1 then

Ce qui donne pour la ligne compléte :
if device.BatteryLevel < 100 and device.Used == 1 then

Faire de même pour :

if device.BatteryLevel < BatteryThreshold then -- and device.Used == 1 then

qui devient :

if device.BatteryLevel < BatteryThreshold and device.Used == 1 then

# Tuto vidéo
Vidéo explicative sur YouTube : 
