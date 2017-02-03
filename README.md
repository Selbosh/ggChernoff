# Draw Chernoff faces in ggplot2

This silly package, `ggChernoff`, introduces a `geom_chernoff` geom for [`ggplot2`](http://ggplot2.org).
This works a bit like [`geom_point`](http://docs.ggplot2.org/current/geom_point.html),
but draws little smiley faces (emoticons) instead of dots.

The Chernoff geom has some unique aesthetics, including `smile`,
which makes your faces smile or frown according to the relative magnitude of your continuous variable.
The mean value will generate a straight face **:|** while higher values will make smiles and lower values will draw frowns.
If `smile` is unassigned, all faces will be happy.

## Getting started

Install the package using
```r
devtools::install_github('Selbosh/ggChernoff')
```
and then load it using
```r
library(ggChernoff)
```

## Examples

Firstly, let's create a scatter plot of smiley faces out of Fisher's iris data set, each one coloured according to species.
```r
library(ggplot2)
ggplot(iris) +
  aes(Petal.Width, Petal.Length, fill = Species) +
  geom_chernoff()
```

Here is an example using Immer's barley data. We are happy about larger yields!
```r
ggplot(lattice::barley) +
  aes(year, variety, smile = yield) +
  geom_chernoff(size = 6, fill = 'goldenrod1') +
  scale_x_discrete(limits = c('1931', '1932')) +
  facet_wrap(~ site)
```

## References
Hermann Chernoff (1973).
The use of faces to represent points in *k*-dimensional space graphically.
*Journal of the American Statistical Association, 68*(342), 361–368.

Leland Wilkinson (2006).
*The Grammar of Graphics* (2nd edition).
Springer.
