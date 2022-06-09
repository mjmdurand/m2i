#definission des variables
$data = @(
        [pscustomobject]@{Nom='Ordinateur'; HT=800; TVA=4; Etat='neuf'}
        [pscustomobject]@{Nom='Television'; HT=250; TVA=2; Etat='neuf'}
        [pscustomobject]@{Nom='Clavier'; HT=15; TVA=1; Etat='occasion'}
        [pscustomobject]@{Nom='Imprimante'; HT=40; TVA=2; Etat='neuf'}
        [pscustomobject]@{Nom='Ecran'; HT=150; TVA=3; Etat='neuf'}
        [pscustomobject]@{Nom='Souris'; HT=10; TVA=1; Etat='occasion'}
        [pscustomobject]@{Nom='Inconnu'; HT=10; TVA=25; Etat='inconnu'}

        [decimal]$tva1= 1.1
        [decimal]$tva2=1.2
        [decimal]$tva3= 1.3
        [decimal]$tva4= 1.4
        [decimal]$tvadefault= 1.5

        write-host $tva4
)


#affichage des infos
foreach ($element in $data){
    switch($element.TVA){
        1 {$ttc = $element.HT * $tva1
        break}
        2 {$ttc = $element.HT * $tva2
        break}
        3 {$ttc = $element.HT * $tva3
        break}
        4 {$ttc = $element.HT * $tva4
        break}
        default {$ttc = $element.HT * $tvadefault}
    }
    
$element.Nom + ' coûte ' + $ttc + '€ (état ' + $element.Etat + ')'
}

#comptage des lettres du nom
foreach ($element in $data){
    
'"'+ $element.Nom + '" comporte ' + $element.Nom.Length + ' caractères'
}


