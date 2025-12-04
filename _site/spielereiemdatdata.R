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
gravdamage <- emdatclean %>%
  filter(`Disaster Type` %in% c("Mass movement (wet)", "Glacial lake outburst flood")) %>%
  summarise(
    total_damage_filtered = sum(`Total Damage, Adjusted ('000 US$)`, na.rm = TRUE)
  )
# Das Ergebnis ist ein kleiner Datenrahmen (tibble) mit der berechneten Summe
print(gravdamage)
totdamage <- emdatclean %>%
  summarise(sum(`Total Damage, Adjusted ('000 US$)`, na.rm = TRUE))
print(totdamage)
df <- data.frame(totdamage, gravdamage)
df_neu <- df %>%
  rename(totaldamage = `sum..Total.Damage..Adjusted...000.US.....na.rm...TRUE.`,
  natcatdamage = `total_damage_filtered`)
View(df_neu)
# -> man könnte jetzt ploten, aber warum?

# Share damage:
sharedamagegrav <- gravdamage / totdamage * 100

# Share deaths:
gravdeaths <- emdatclean %>%
  filter(`Disaster Type` %in% c("Mass movement (wet)", "Glacial lake outburst flood")) %>%
  summarise(
    total_deaths_filtered = sum(`Total Deaths`, na.rm = TRUE)
  )
totaldeaths <- emdatclean %>%
  summarise(totaldeaths = sum(`Total Deaths`, na.rm = TRUE))

sharedeathsgrav <- gravdeaths / totaldeaths * 100
