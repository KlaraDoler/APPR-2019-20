sl <- locale("sl", decimal_mark=",", grouping_mark=".")
source("lib/libraries.r", encoding="UTF-8")

tabela1 <- read_csv2("podatki/kazalniki.csv", skip = 1, col_names = c("Kazalniki", "Leto", "Število primerov"),
                     locale=locale(encoding="Windows-1250"))

tabela2 <- read_csv2("podatki/kazalniki_razlogi.csv", skip = 3, col_names = c("Razlogi", "Kazalniki", "Leto", "Število primerov"),
                     locale=locale(encoding="Windows-1250"))

tabela3 <- read_csv2("podatki/kazalniki_regije.csv", skip = 3, col_names = c("Regija", "Kazalniki", "Leto", "Število primerov"),
                     locale=locale(encoding="Windows-1250"))

tabela4 <- read_csv2("podatki/gospod.dejavnost.csv", skip = 3, col_names = c("Gospodarska dejavnost", "Kazalniki", "Leto", "Število primerov"),
                     locale=locale(encoding="Windows-1250"))


