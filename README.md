# Draw Chernoff faces in ggplot2

This silly package, `ggChernoff`, introduces a `geom_chernoff` geom for [`ggplot2`](http://ggplot2.org).
This works a bit like [`geom_point`](http://docs.ggplot2.org/current/geom_point.html),
but draws little smiley faces (emoticons) instead of dots.

The Chernoff geom has some unique aesthetics, including `smile`,
which makes your faces smile or frown according to the relative magnitude of your continuous variable.
Otherwise, the minimum value will correspond to a sad face :( and the maximum value to a happy face :).
The mid-point (not necessarily the mean or median) will generate a straight face :|.
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
barley <- tidyr::gather(MASS::immer, Year, Yield, Y1:Y2)
ggplot(barley) + aes(Year, Var, smile = Yield) +
  geom_chernoff(size = 6, fill = 'goldenrod1') +
  scale_fill_brewer(type = 'div', palette = 1) +
  facet_wrap(~Loc)
```

## References
Hermann Chernoff (1973).
The use of faces to represent points in *k*-dimensional space graphically.
*Journal of the American Statistical Association, 68*(342), 361–368.

Leland Wilkinson (2006).
*The Grammar of Graphics* (2nd edition).
Springer.
