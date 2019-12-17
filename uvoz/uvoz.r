# 2. faza: Uvoz podatkov

sl <- locales("sl", decimal_mark=",", grouping_mark=".")
source("lib/libraries.r", encoding="UTF-8")


# Funkcija, ki uvozi občine iz Wikipedije
uvozi.obcine <- function() {
  link <- "http://sl.wikipedia.org/wiki/Seznam_ob%C4%8Din_v_Sloveniji"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
                        "ustanovitev", "pokrajina", "regija", "odcepitev")
  tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
  tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
  tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
  for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
    if (is.character(tabela[[col]])) {
      tabela[[col]] <- parse_number(tabela[[col]], na="-", locale=sl)
    }
  }
  for (col in c("obcina", "pokrajina", "regija")) {
    tabela[[col]] <- factor(tabela[[col]])
  }
  return(tabela)
}

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
uvozi.druzine <- function(obcine) {
  data <- read_csv2("podatki/druzine.csv", col_names=c("obcina", 1:4),
                    locale=locale(encoding="Windows-1250"))
  data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
    strapplyc("([^ ]+)") %>% sapply(paste, collapse=" ") %>% unlist()
  data$obcina[data$obcina == "Sveti Jurij"] <- "Sveti Jurij ob Ščavnici"
  data <- data %>% gather(`1`:`4`, key="velikost.druzine", value="stevilo.druzin")
  data$velikost.druzine <- parse_number(data$velikost.druzine)
  data$obcina <- parse_factor(data$obcina, levels=obcine)
  return(data)
}

# Zapišimo podatke v razpredelnico obcine
obcine <- uvozi.obcine()

# Zapišimo podatke v razpredelnico druzine.
druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.




library(tidyr)
library(readxl)
library(data.table)
library(dplyr)
library(readr)
library(ggplot2)
library(abind)
library(reshape2)


#uvoz kazalniki spol starost

uvozi.kazalniki_spol <- function(kazalnik) {
  stolpci <- c("x", "Primeri", "Koledarski dnevi", "Odstotek BS", 
               "Izgubljeni koledarski dnevi na zaposlenega", "Število primerov na 
               100 zaposlenih", "Povprečno trajanje ene odsotnosti")
  podatki <- read.csv2("podatki/kazalniki_spol_starost.csv",
                       col_names=stolpci,
                       locale=locale(encoding="Windows-1250"),
                       skip=3, n_max=11) %>% .[, -(1:2)] %>%
    melt(id.vars= "leta",  variable.name="kazalnik", value.name="stevilo") %>%
    mutate(stevilo=parse_number(stevilo, na="N"))
  
}
kazalniki_spol <- uvozi.kazalniki_spol()


# Funkcija, ki uvozi podatke iz csv dokumenta
#podatki.kazalniki <- read_csv("podatki/kazalniki_spol_starost.csv",
#                              col_names=TRUE,
#                              skip=3,
#                              na="-",
#                              n_max = 11,
#                              locale=locale(encoding="Windows-1250", decimal_mark="."))

# Prvemu stolpcu nastavimo novo ime
#colnames(podatki.kazalniki)[1] <- "Kazalniki"

# Tabelo preoblikujem s funkcijo melt
#podatki.kazalniki <- melt(podatki.kazalniki, id.vars="Kazalniki", measure.vars=names(podatki.kazalniki)[-1],
#                          
#                          variable.name="Leto",value.name="Vrednost", na.rm=TRUE)





prva <- read_csv("podatki/kazalniki_spol_starost.csv", col_names=c("Slovenija", 2000:2018),
                 skip=3, na="-", locale=locale(encoding="Windows-1250"))

kazalniki.spol.starost <- gather(prva, key=leto, value=primeri, na.rm=TRUE )






