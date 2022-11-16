#' Scales for eye separation
#'
#' \code{scale_eyes} lets you customise how eye separation is determined from your data.
#' It also lets you tweak the appearance of legends and so on.
#'
#' Use \code{range} to vary how happily/sadly your maximum/minimum values are represented.
#' Minima smaller than -1 and maxima greater than +1 are possible but might look odd!
#' You can use \code{midpoint} to set a specific 'zero' value in your data or to have eye width represented as relative to average.
#'
#' The function \code{scale_eyes} is an alias of \code{scale_eyes_continuous}.
#'
#' Legends are a work in progress. In particular, \code{size} mappings might produce odd results.
#'
#' @param ... Other arguments passed onto \code{\link[ggplot2]{continuous_scale}} to control name, limits, breaks, labels and so forth.
#' @param range Output range of eye distances. 0 corresponds to a cyclops and +1 to a 'normal' distance.
#' @param midpoint A value or function of your data that will return a 'normal' separation
#'
#' @seealso \code{\link{geom_chernoff}}, \code{\link{scale_brow}}, \code{\link{scale_smile}}
#'
#' @importFrom scales rescale_mid
#'
#' @examples
#' library(ggplot2)
#' p <- ggplot(iris) +
#'     aes(Sepal.Width, Sepal.Length, fill = Species, eyes = Sepal.Length) +
#'     geom_chernoff()
#' p
#' p + scale_eyes_continuous(midpoint = min)
#' p + scale_eyes_continuous(range = c(0, 2))
#'
#' @rdname scale_eyes
#' 
#' @return
#' A \code{\link[ggplot2:continuous_scale]{Scale}} layer object for use with \code{ggplot2}.
#'
#' @export
scale_eyes_continuous <- function(..., range = c(.1, 2), midpoint = mean) {
  if (is.numeric(midpoint)) {
    neutral <- function(...) return(midpoint)
  } else {
    neutral <- match.fun(midpoint)
  }
  continuous_scale('eyes', 'eyes_c',
                   function(x) scales::rescale_mid(x, to = range, mid = neutral(x, na.rm = TRUE)),
                   ..., na.value = 1)
}

#' @rdname scale_eyes
#' @export
scale_eyes <- scale_eyes_continuous
