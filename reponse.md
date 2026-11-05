TP1

P1 : 14 secondes ; les logs se trouvent dans l’onglet Actions, en dépliant chaque étape du run.

P3 : Le test qui vérifie la longueur du titre a échoué, à la ligne de l’assert indiquée dans les logs (à recopier depuis ton run). Le run rouge, le message AssertionError et les logs par étape l’ont rendu facile à trouver.

P4 : Pour ne jamais mettre sur main du code qui casse les tests : main doit toujours rester fonctionnel.

TP2

P1 : Séparer les jobs permet de les exécuter en parallèle, de voir tout de suite si le problème vient du style ou des tests, et de les rendre obligatoires séparément. (Ta réponse sur flake8/black est bonne.)

P2 : Le cache évite de retélécharger les dépendances à chaque run, donc la CI est plus rapide.

P3 : Pour que tout passe par une pull request avec CI et relecture, et éviter qu’un code cassé arrive directement sur main.

P4 : Git ne sait pas lequel garder quand les deux branches modifient la même ligne. C’est la CI qui a vérifié le code après la résolution.

P5 :
    • GitHub masque le secret pour qu’il n’apparaisse pas dans les logs, visibles par tous. 
    • Si on le commite, il reste visible dans l’historique Git : il faut le révoquer et en créer un nouveau. 
    • Secret pour une valeur sensible, variable pour une valeur non sensible. 

TP3

P1 : Une image est un modèle figé, un conteneur en est une instance qui tourne. Le .dockerignore exclut des fichiers du build (.git, .venv) pour une image plus légère et plus propre. On copie requirements.txt avant le code pour que pip install reste en cache tant que les dépendances ne changent pas.

P2 : La configuration est versionnée et reproductible : un simple docker compose up remplace une longue commande.

P3 : build attend test pour ne pas publier d’image dont le code est cassé. On évite latest car ce tag change tout le temps : on ne sait pas quelle version tourne et on ne peut pas revenir en arrière.

P4 : Elle est reproductible, identifiable et on peut revenir à la version précédente, alors que « le code de ma machine » dépend de mon environnement.

P5 : Un test de fumée est une vérification rapide qu’après déploiement l’application démarre et répond. L’approbation humaine protège la production : quelqu’un confirme que staging est bon avant de livrer.

P6 : Si l’application est compromise, l’attaquant aurait les droits root : on applique le principe du moindre privilège.

TP4

P1 : Un pod est un conteneur en cours d’exécution. Un deployment est la consigne « je veux N pods de cette image » et Kubernetes les maintient. Un namespace est un dossier de rangement logique dans le cluster.

P2 : On sépare les dépôts pour que la configuration ne relance pas la CI du code (et inversement), et pour contrôler qui peut modifier quoi.

P3 : selfHeal fait qu’Argo CD annule toute modification manuelle du cluster pour revenir à l’état de Git. Le retour arrière est simple car un git revert crée un commit d’annulation et Argo CD resynchronise.
Observation TP4-6 : à écrire d’après ce que tu as vu, par exemple : « J’ai vu 4 ou 5 pods quelques secondes, puis Argo CD est revenu à 3 grâce à selfHeal. »

P4 : Le tag déclenche la CI, qui publie l’image puis modifie tasks-config. Argo CD détecte le changement et remplace les pods. Le pipeline pousse, Argo CD tire ; contrairement au CI/CD classique, la CI ne touche jamais le cluster.
