# WordGame

<P align="center">
<img src="https://user-images.githubusercontent.com/22550304/201525614-f242a044-838b-4e30-862c-350450653587.png" width="200">
<img src="https://user-images.githubusercontent.com/22550304/201525615-73f7773c-dabb-4055-b8c7-c23e9c617f17.png" width="200">
</p>


### How much time was invested
About 8 hours, maybe a little bit less. 

### How was the time distributed (concept, model layer, view(s), game mechanics)
* about 2 hour was spent on services + models
* about 2 hour was spent writing unit tets
* about 1 hours were spent on UI layer: SwiftUI view, localized strings, etc.
* about 2 hour on ViewModel (Game logic)
* about 0.5 hour working on a solution for the animation from top to bottom

### Decisions made to solve certain aspects of the game
* I decided to use SwiftUI and Combine. Working on UI part was easier with SwiftUI and had more time to focus on the logic.
* The architecture is MVVM. In my opinion it's native for a fully SwiftUI app. 

### Decisions made because of restricted time
* `WordService` could be async. In that case we could fetch words from an API.
* I would've worked more on the UI part, adding more animations and transitions.
* Could've added more unit tests If I had more time. 

### What would be the first thing to improve or add if there had been more time
* Fetch words from an API.
* Save achievments to game center.
* Nicer UI.
