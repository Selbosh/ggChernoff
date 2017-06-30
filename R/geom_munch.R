#' Screaming faces in ggplot2
#'
#' @section Aesthetics:
#' \code{geom_chernoff} understands the following aesthetics (required aesthetics are in bold):
#' \itemize{
#' \item \strong{\code{x}}
#' \item \strong{\code{y}}
#' \item \code{colour}
#' \item \code{fill}
#' \item \code{size}
#' }
#' The following aesthetics are unique to \code{geom_chernoff}:
#' \itemize{
#' \item \code{scream}
#' }
#' For details, see \code{\link{screamGrob}}.
#'
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, scream = Petal.Length, fill = Species)) +
#'   geom_munch()
#'
#' @import ggplot2
#' @export geom_munch
geom_munch <- function(mapping = NULL, data = NULL, stat = "identity",
                       position = "identity", na.rm = FALSE, show.legend = NA,
                       inherit.aes = TRUE, ...) {
  layer(geom = GeomMunch, mapping = mapping, data = data, stat = stat,
        position = position, show.legend = show.legend, inherit.aes = inherit.aes,
        params = list(na.rm = na.rm, ...)
        )
}

GeomMunch <- ggproto("GeomMunch", ggplot2::Geom,
  required_aes = c("x", "y"),
  default_aes = aes(colour = "black", fill = NA, size = 4, alpha = 1, scream = 1),
  draw_key = ggplot2::draw_key_rect,
  draw_panel = function(data, panel_scales, coord) {
    coords <- coord$transform(data, panel_scales)
    gt <- grobTree()
    for (i in seq_along(coords$x)) {
      gt <- addGrob(gt, screamGrob(coords$x[i],
                                   coords$y[i],
                                   coords$size[i],
                                   coords$colour[i],
                                   coords$fill[i],
                                   coords$alpha[i],
                                   coords$scream[i])
      )
    }
    return(gt)
  },
  draw_key = function(data, params, size) {
    screamGrob(x = .5, y = .5,
               data$size,
               data$colour,
               data$fill,
               data$alpha,
               data$scream)
  }
)
