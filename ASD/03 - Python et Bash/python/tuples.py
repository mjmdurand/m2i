TableauStatistique=(
["18 Jan 2021",    43.50,    92.45,    "IMB"],
["19 Jan 2021",    42.50,    51.19,    "Thales"],
["20 Jan 2021",    42.10,    34.87,    "Atos"],
["21 Jan 2021",    37.58,    37.58,    "Wordline"],
["21 Jan 2021",    37.58,    1.58,    "Wordline"],
)

for x in TableauStatistique:
    x[0]="test"
    print(x)