import requests
import re
from bs4 import BeautifulSoup

pokemonDataLinks = open("pokeLinks.txt", "r")
pokemonData = open("pokemonData.lua", "w")

for pokeLink in pokemonDataLinks:
    pokeData = requests.get(pokeLink.strip("\n"))

    if pokeData.status_code != 200:
        print(f"\nFailed to fetch the website.\n")
    else:
        soup = BeautifulSoup(pokeData.text, 'html.parser')
        
        # NAME
        pokeName = soup.find('h1').text                                                 # Gets the Pokemon's name
        
        # NUMBER
        pokeNumber = int(soup.find('strong').text) - 151                                # Gets the Pokemon's number

        # POKETYPE(S)
        pokeTypes = soup.find(class_ = "grid-col span-md-6 span-lg-4")
        soup = BeautifulSoup(f"<html>{pokeTypes}</html>", 'html.parser')
        pokeTypes = soup.find(class_ = "vitals-table")
        soup = BeautifulSoup(f"<html>{pokeTypes}</html>", 'html.parser')
        pokeTypes = soup.find_all(class_="type-icon")                                 # Gets the Pokemon's type(s)       
        pokeType1 = pokeTypes[0].text                                                 # Stores the Pokemon's first type             

        if (len(pokeTypes) == 2):                                                     # If the Pokemon is dual-typed...
            pokeType2 = pokeTypes[1].text                                               # Store the Pokemon's second type
        else:
            pokeType2 = ""                                                              # Leave the Pokemon's second type empty

        # Reset to default
        soup = BeautifulSoup(pokeData.text, 'html.parser')


        # STATS
        pokeStats = soup.find(class_ = "grid-col span-md-12 span-lg-8")                 
        soup = BeautifulSoup(f"<html>{pokeStats}</html>", 'html.parser')
        pokeStats = soup.find(class_ = "vitals-table")
        soup = BeautifulSoup(f"<html>{pokeStats}</html>", 'html.parser')
        pokeStats = soup.find_all("td")                                                # Gets all the Pokemon's stats       
        
        # Sets each stat that we care about
        pokeHealthStat = pokeStats[0].text                                              
        pokeAttackStat = pokeStats[4].text
        pokeDefenseStat = pokeStats[8].text
        pokeSpecialAttackStat = pokeStats[12].text
        pokeSpecialDefenseStat = pokeStats[16].text
        pokeSpeedStat = pokeStats[20].text

        
        print(pokeNumber)


        pokemonData.write(f'local pokemon{pokeNumber} = {{"{pokeName}", {pokeNumber}, "{pokeType1}", "{pokeType2}", {pokeHealthStat}, {pokeAttackStat}, {pokeDefenseStat}, {pokeSpecialAttackStat}, {pokeSpecialDefenseStat}, {pokeSpeedStat}}}\n')