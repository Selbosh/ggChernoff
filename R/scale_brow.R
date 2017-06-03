#' Scales for angry eyebrows
#'
#' \code{scale_brow} lets you customise how eyebrows are generated from your data.
#' It also lets you tweak the appearance of legends and so on.
#' By default, \code{brow} is set to \code{NA}, which means no eyebrows will appear.
#'
#' Use \code{range} to vary how angrily your maximum/minimum values are represented.
#' Minima smaller than -1 and maxima greater than +1 are possible but might look odd!
#' You can use \code{midpoint} to set a specific 'zero' value in your data or to have eyebrow angles represented as relative to average.
#'
#' The function \code{scale_brow} is an alias of \code{scale_brow_continuous}.
#' At some point we might also want to design a \code{scale_brow_discrete}, \code{scale_brow_manual} and so on.
#'
#' Legends are a work in progress. In particular, \code{size} mappings might produce odd results.
#'
#' @param ... Other arguments passed onto \code{\link[ggplot2]{continuous_scale}} to control name, limits, breaks, labels and so forth.
#' @param range Output range of eyebrow angles. +1 corresponds to very angry and -1 corresponds to a worried look.
#' @param midpoint A value or function of your data that will return level eyebrows, i.e. \code{¦:-)}
#'
#' @seealso \code{\link{geom_chernoff}}, \code{\link{scale_smile}}
#'
#' @importFrom scales rescale_mid
#'
#' @examples
#' library(ggplot2)
#' p <- ggplot(iris) +
#'     aes(Sepal.Width, Sepal.Length, fill = Species, brow = Sepal.Length) +
#'     geom_chernoff()
#' p
#' p + scale_brow_continuous(midpoint = min)
#' p + scale_brow_continuous(range = c(-.5, 2))
#'
#' @rdname scale_brow
#'
#' @export
scale_brow_continuous <- function(..., range = c(-1, 1), midpoint = mean) {
  if (is.numeric(midpoint)) {
    neutral <- function(...) return(midpoint)
  } else {
    neutral <- match.fun(midpoint)
  }
  continuous_scale('brow', 'brow_c',
                   function(x) scales::rescale_mid(x, to = range, mid = neutral(x, na.rm = TRUE)),
                   ..., na.value = NA)
}

#' @rdname scale_brow
#' @export
scale_brow <- scale_brow_continuous
