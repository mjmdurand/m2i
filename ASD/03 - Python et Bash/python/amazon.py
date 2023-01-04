from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

driver = webdriver.Firefox()
driver.get("http://amazon.fr")
elem = driver.find_element(By.ID, "twotabsearchtextbox")
elem.clear()
elem.send_keys("lunettes")
elem.send_keys(Keys.RETURN)
articlelist = WebDriverWait(driver, 10).until(EC.presence_of_all_elements_located((By.XPATH, '//span[contains(@class, "a-size-base-plus a-color-base a-text-normal")]')))
pricelist = WebDriverWait(driver, 10).until(EC.presence_of_all_elements_located((By.XPATH, '//span[contains(@class, "a-price-whole")]')))
loop=3
for i in pricelist:
    print (pricelist[loop].text, "€", articlelist[loop].text)
    #print(i.text)
    loop+=1
#driver.close()