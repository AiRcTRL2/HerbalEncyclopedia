# HerbalEncyclopedia

## Herbal Encyclopedia is a personal app project in mid-stage development. It is an application for those of us who love herbs, herbal science and understanding their effects on our bodies. It seeks to provide knowledge and methodology in a pragmatic, clean and pleasant manner.

### Roadmap of development prior to release:
 - Brainstorm & Implement a colour, brand & theme to apply across the app
 - Improve UI design in certain aspects (i.e. Spruce up that search bar, consider moving to SwiftUI)
 - Flesh out JSON & Data Model structure for the Recipes section of the app (currently very early stages of development)
 - Add CoreData support for local persistence (fan favourites, current spotlight plant)
 - Add Firebase for analytics and potentially a backend to power a mobile forum/community for its users
 - (Non-developmental) Start writing more JSON! We only have 1 plant/herb for test data. The goal for release is 100, with incremental updates over the following months to bring that to 500. 
 - Consider the architecture of the lookup dictionaries and whether we should really store a copy of these in memory.
 - Further map out migration from the older MVC code to utilising the MVVM design with Combine & Factories/Containers
 
 A long break was taken in the project due to my role with my previous employer. As such, much of the code was written when I was a true novice. Recent changes to the code are some preliminary attempts to at code improvement (i.e. efficiency, logical architecture & readability). There are some ways to go yet and I'm sure there are still embarassing portions of code nested in the project or ill-informed structures, but rest assured, these will be addressed.
