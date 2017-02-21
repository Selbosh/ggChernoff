# Draw Chernoff faces in ggplot2

This silly package, `ggChernoff`, introduces a `geom_chernoff` geom for [`ggplot2`](http://ggplot2.org).
This works a bit like [`geom_point`](http://docs.ggplot2.org/current/geom_point.html),
but draws little smiley faces (emoticons) instead of dots.

The Chernoff geom has some unique aesthetics, including `smile`,
which makes your faces smile or frown according to the relative magnitude of your continuous variable.
By default, the mean value will generate a straight face **:|** while higher values will make smiles and lower values will draw frowns. You can customise this using `scale_smile`.
If `smile` is unmapped to a variable, all faces will be happy by default.

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

Basic legends are now supported. We can customise breaks and titles in the usual `ggplot2` way, via `scale_smile_continuous`.

```r
g <- ggplot(data.frame(x = rnorm(10), y = rexp(10), z = runif(10))) +
  aes(x, y, smile = z) +
  geom_chernoff(fill = 'steelblue1')
g
g + scale_smile_continuous('Smiles', breaks = c(0, .5, 1), midpoint = .5)
```

You can also use this command to adjust the range of possible happiness/sadness in your plot. In the following example, everybody is somewhere between sad and straight-faced.

```r
g + scale_smile_continuous('Smiles', range = c(-1, 0))
```

## References
Hermann Chernoff (1973).
The use of faces to represent points in *k*-dimensional space graphically.
*Journal of the American Statistical Association, 68*(342), 361–368.

Leland Wilkinson (2006).
*The Grammar of Graphics* (2nd edition).
Springer.
