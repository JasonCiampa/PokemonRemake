# https://scrapeops.io/python-web-scraping-playbook/python-beautifulsoup-find/

import requests
import re
from bs4 import BeautifulSoup

response = requests.get("https://pokemondb.net/pokedex/game/heartgold-soulsilver")
                        
if response.status_code != 200:
    print(f"\nFailed to fetch the website.\n")
else:
    soup = BeautifulSoup(response.text, 'html.parser')
    pokemonTags = soup.select('.infocard')
    pokemonLinks = open("pokemonDataLinks.txt", "w")

    
    for tag in pokemonTags:
        try:
            pokemonLinks.write(str(tag) +'\n')
        except:
            pass
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    # pokemonTags = soup.find('div', class_='infocard-list infocard-list-pkmn-lg')
    # pokemonTags = soup.find_all('a')

    
    # pokemonDataLinks = open("pokemonDataLinks.txt", "w")
    
    # # for pokemonLink in pokemonTags.contents:
    # #     pokemonName = str(pokemonLink)[70 : pokemonLink.find('"><img alt=')]
    # #     pokemonDataLinks.write('pokemondb.net/pokedex/' + pokemonName + '\n')
    
    
    # for tag in pokemonTags:
    #     if ('<a href="/pokedex/') in str(tag):
    #         pokemonDataLinks.write(str(tag) + '\n')
    # print(pokemonTags)
# Tag holding every Pokemon: <div class="infocard-list infocard-list-pkmn-lg">  (all pokemon)   </div>

