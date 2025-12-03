library(ggplot2)
library(tidyverse)

emdat <- read_csv("emdatswissdata.csv")
View(emdat)

sum(emdat$`Total Affected`,
    na.rm = TRUE)

# Wir bilden ab: Anteil der Schäden (finanziell, betroffen seit 2000 durch)

spalten_zum_loeschen <- c(1, 2, 8, 10, 11, 12, 13, 15, 16, 17, 18, 27, 28, 
                          26, 25)
emdatclean <- emdat[, -spalten_zum_loeschen]

# Schaden insgesamt und Anteil an Gravitativen Naturgefahren:

library(dplyr) # Stellen Sie sicher, dass dplyr geladen ist

gravdamage <- emdatclean %>%
  # 1. Filtern: Wähle nur die Zeilen aus, die den Katastrophentypen entsprechen
  filter(`Disaster Type` %in% c("Mass movement (wet)", "Glacial lake outburst flood")) %>%
  # 2. Aggregieren: Berechne die Summe der gefilterten Spalte
  summarise(
    total_damage_filtered = sum(`Total Damage, Adjusted ('000 US$)`, na.rm = TRUE)
  )

# Das Ergebnis ist ein kleiner Datenrahmen (tibble) mit der berechneten Summe
print(gravdamage)

totdamage <- emdatclean %>%
  summarise(sum(`Total Damage, Adjusted ('000 US$)`, na.rm = TRUE))
print(totdamage)

df <- c(totdamage, gravdamage)
View(df)

ggplot(df, aes(x = , y = ))+
  geom_bar(stat = identity)
