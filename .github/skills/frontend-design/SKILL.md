---
name: frontend-design
description: Direction visuelle intentionnelle pour une nouvelle interface ou une refonte visible. À charger seulement pour le travail UI.
license: Complete terms in LICENSE.txt
---

# Frontend design

## Quand l'utiliser

Nouvelle page, refonte visuelle ou critique UI. Ne pas le charger pour une
modification de logique, API, donnée ou infrastructure.

## Méthode

1. Identifier le public, l'objectif et le contenu réel de l'écran. Si un détail
   esthétique manque, annoncer une hypothèse raisonnable puis avancer.
2. Écrire un plan très court : un parti pris visuel, tokens sémantiques de
   couleur et de typographie, hiérarchie et comportement mobile.
3. Retirer les automatismes sans justification par le produit : cartes
   identiques, gradients décoratifs, typographie « SaaS », animation partout,
   faux labels ou jargon marketing.
4. Concentrer l'originalité dans un élément utile; garder le reste lisible,
   calme et cohérent.

## Contraintes sylvain-builder

- Lire `.sylvain/shared-components.json` avant toute composition. Réutiliser
  `MenuBar` (ou `ThemeSelector` + `PreferencesPanel`/`PreferencesIcon`) et les
  surfaces IA `AiChatPanel` ou `AiPromptCard` + `AiResponseBlock`.
- Employer le thème et les primitives MUI du projet; aucune bibliothèque UI
  concurrente. Promouvoir dans `shared-components` un composant générique utile
  à deux applications, avec test et export public.
- Vérifier contenu réel, mobile, clavier, contraste et mouvement réduit. Les
  mots de l'interface sont directs, cohérents et décrivent l'action effectuée.

La demande du produit prévaut. Pour la source, la licence et la révision
vendorisée, voir `UPSTREAM.md`.
