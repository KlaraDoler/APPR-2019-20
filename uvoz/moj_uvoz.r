sl <- locale("sl", decimal_mark=",", grouping_mark=".")
source("lib/libraries.r", encoding="UTF-8")

Kazalniki_odsotnosti <- read_csv2("podatki/kazalniki.csv", skip = 1, col_names = c("Kazalniki", "Leto", "Število primerov"),
                     locale=locale(encoding="Windows-1250"))

Razlogi <- read_csv2("podatki/kazalniki_razlogi.csv", skip = 3, col_names = c("Razlogi", "Kazalniki", "Leto", "Število primerov"),
                     locale=locale(encoding="Windows-1250"))

Regija <- read_csv2("podatki/kazalniki_regije.csv", skip = 3, col_names = c("Regija", "Kazalniki", "Leto", "Število primerov"),
                     locale=locale(encoding="Windows-1250"))

Gospodarska_dejavnost <- read_csv2("podatki/gospod.dejavnost.csv", skip = 3, col_names = c("Gospodarska dejavnost", "Kazalniki", "Leto", "Število primerov"),
                     locale=locale(encoding="Windows-1250"))


