import string

'''exo 1'''
var="avec python je progresse vite en programmation."
tab=var.split()
join="#".join(tab)
print(join)

'''exo 2'''
var2="python"
print(var2)
print(var2[0])
print(var2[4])

'''exo 3'''
var3="abcdefghijklmnopqrstuvwxyz"
print(var3[:6])
print(var3[12:18])
print(var3[:10])
print(var3[-10:])
print(var3[0:26:2])
print(var3[1:26:2])
print(var3[0:9:2])
print(var3)
print(var3[::-1])

'''exo 4'''
tab_car = ['p', 'y', 't', 'h', 'o', 'n', ' ', 'e', 's', 't', ' ', 'u', 'n', ' ', 's', 'u', 'p', 'e', 'r', ' ', 'l', 'a', 'n', 'g', 'a', 'g', 'e']
var4=""
for x in tab_car:
  var4=var4+x
print(var4)

'''exo 5'''
tab_car = ['p', 'y', 't', 'h', 'o', 'n', ' ', 'e', 's', 't', ' ', 'u', 'n', ' ', 's', 'u', 'p', 'e', 'r', ' ', 'l', 'a', 'n', 'g', 'a', 'g', 'e']
var5="".join(tab_car)
print(var5)

'''exo 6'''
chaine = "abcdefghijklmnopqrstuvwxyz"
tab_car = list(chaine)
print(tab_car)

'''exo 7'''
var6=string.printable
var7= [15, 21, 10, 16, 90, 25, 34, 29, 17, 0, 23, 88, 1, 28, 88, 16, 27, 3, 10, 29, 92]
secret=""
for x in var7:
  secret=secret+str(var6[x])
print(secret)
