shinyr-stats-project
====================

This is a shiny R application that models the relationship between diamond cut vs price of a diamond. The dataset contains attributes on almost 54,000 diamonds which was sourced from the [Rdatasets repository](http://vincentarelbundock.github.io/Rdatasets/).

## To run the code

Type the following into an R prompt:

```
# Import shiny library
library(shiny)

# Set current working directory to the path to the root of the repository
setwd("<PATH>")

# Run Application
runApp(getwd())
```
