# printf testing
Hier teste ich die funktionen von 'printf' in der Datei prinf.sh wird geprüft ob Parameter angegeben werden und gibt
ihn dann aus.

In der Datei touch-loop.sh werden vorher angegeben Dateien als Parameter gespeichert und dann erstellt.







# ------------------------------------------------------------------------------
# 1. Grundlagen – sicherer Text + Zeilenumbruch
# ------------------------------------------------------------------------------

printf '%s\n' "Normaler Text"
printf '%s\n' "$variable"                # immer sicher (auch bei - oder Leerzeichen)
printf '%s\n' "$(kommando)"              # statt echo "$(kommando)"

# Ohne Zeilenumbruch am Ende
printf '%s' "Text ohne newline"

# Mehrere Argumente
printf 'Name: %s  Alter: %d  Größe: %.1f\n' "Anna" 28 1.68

# ------------------------------------------------------------------------------
# 2. Ausrichtung, Auffüllen, Breite
# ------------------------------------------------------------------------------

printf '%-20s %8d € %12.2f\n' "Produkt A"  42   19.99     # linksbündig
printf '%20s %08d\n'           "Rechts"    7               # rechtsbündig + nullgefüllt
printf '|%-15s|%+8d|%10.3f|\n' "Text"      -42  3.14159     # Vorzeichen +, feste Breite

# ------------------------------------------------------------------------------
# 3. Farben & Formatierungen (ANSI Escape)
# ------------------------------------------------------------------------------

# Farb-Variablen (einmal oben im Skript definieren)
reset='\e[0m'
red='\e[31m'    green='\e[32m'   yellow='\e[33m'  blue='\e[34m'
bred='\e[1;31m' bgreen='\e[1;32m' byellow='\e[1;33m'

# Beispiele
printf "${bred}ERROR:${reset} Datei %s nicht gefunden\n" "$file"
printf "${green}OK${reset}   %d von %d Einträgen verarbeitet\n" "$done" "$total"
printf "${byellow}WARNUNG:${reset} Freier Speicher nur noch %.1f%%\n" "$frei"

# TrueColor (24-bit RGB) – funktioniert in fast allen modernen Terminals
printf '\e[38;2;255;100;80mACHTUNG!\e[0m  %s\n' "kritischer Wert"

# ------------------------------------------------------------------------------
# 4. Fortschritt & einzeilige Updates
# ------------------------------------------------------------------------------

printf '\r[%3d%%] %s ...'  "$prozent" "$meldung"    # \r = Zeilenanfang
# später dann:
printf '\r[100%%] Fertig!               \n'

# Mit Ladebalken (einfach)
bar=$(printf '%*s' $((prozent/2)) '' | tr ' ' '#')
printf '\r[%-${width}s] %3d%%' "$bar" "$prozent"

# ------------------------------------------------------------------------------
# 5. Sonderzeichen & Interpretation
# ------------------------------------------------------------------------------

printf '%b\n' "Zeile1\nZeile2\tTab \aPiepen \e[31mRot\e[0m"   # %b → \n \t \e \a wirken

# ------------------------------------------------------------------------------
# 6. Typische Muster / Copy-Paste-Vorlagen
# ------------------------------------------------------------------------------

# Fehlerausgabe auf stderr
printf 'Fehler: %s\n' "Ungültiges Argument" >&2

# Erfolgsmeldung + Zeit
printf '[%s] %bOK:%b Backup von %s abgeschlossen\n' \
       "$(date '+%H:%M:%S')" "${green}" "${reset}" "$verzeichnis"

# Tabelle / Liste
printf '%-25s %8s %12s\n' "Datei" "Größe" "Datum"
printf '%-25s %8s %12s\n' "----" "-----" "-----"
printf '%-25s %8d %12s\n' "$name" "$size" "$datum"

# Bestätigungsfrage
printf "${yellow}Fortfahren? [j/N] ${reset}"
# (read danach im Skript)
