#!/usr/bin/env python3
# Import des modules de selenium
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

 

# Declaration du driver a utiliser (Firefox, Chrome, Edge, Safari)
driver = webdriver.Firefox()
# Recuperation de la page
driver.get("https://amazon.fr")
elem = driver.find_element(By.ID, "twotabsearchtextbox")
# Supprime la recherche deja entree
elem.clear()
# Saisie dans le champs de recherche
elem.send_keys("lunettes")
# Envoi de la commande "entree" pour valider la recherche
elem.send_keys(Keys.RETURN)
pricelist = WebDriverWait(driver, 10).until(EC.presence_of_all_elements_located((By.XPATH, '//div[contains(@class, "s-result-item s-asin")]')))
for i in pricelist:
    print(i.text)
#price=driver.find_element(By.XPATH, "//span[@class='a-price-whole']")
#print(price.text)
#driver.close()