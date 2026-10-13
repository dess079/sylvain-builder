---
name: ui-ux-pro-max
description: Recherche UX locale pour une décision UI importante, une interaction complexe ou une revue visuelle ciblée.
---

# UI/UX Pro Max

## Quand l'utiliser

Pour une direction visuelle importante, un comportement complexe (focus,
feedback, formulaire, navigation, responsive) ou une revue UX. Ne pas le
charger pour backend, données, infrastructure ou une modification non visuelle.

## Recherche minimale

Exécuter depuis la racine du dépôt, avec une intention dominante et 2 à 5 mots :

```bash
python3 .github/skills/ui-ux-pro-max/scripts/search.py "focus modal clavier" --domain ux
```

- Nouvelle page ou direction de produit : `--design-system`.
- Problème ciblé : `--domain ux|style|color|typography|chart|icons|react`.
- Détail de framework : `--stack react` après la recherche UX, jamais à sa
  place.
- Si la première recherche est mauvaise, la reformuler une fois avec un domaine
  explicite. Ne pas inventer de résultat absent.

Lire `references/quick-reference.md` ou `references/pro-rules.md` seulement
lorsque le résultat l'indique. `--persist` est optionnel : lire le design system
existant et ne jamais employer `--force` sans autorisation explicite.

## Contraintes sylvain-builder

- Lire `.sylvain/shared-components.json` avant de composer une UI. Réutiliser
  les toolbars, préférences et surfaces IA publiques; promouvoir le générique
  partagé plutôt que le dupliquer.
- Traduire les recommandations en thème, tokens et composants MUI du projet.
  Les exemples Tailwind ou autres stacks de la base décrivent un résultat UX et
  ne doivent jamais être copiés.
- Le brief, l'accessibilité, la sécurité et les composants partagés priment sur
  les résultats. Vérifier au minimum mobile, clavier, contraste et mouvement
  réduit avant livraison.

Les données et scripts restent locaux et ne sont lus qu'à la requête. Source,
licence et révision : `UPSTREAM.md`.
