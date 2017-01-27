#' Chernoff faces in ggplot2
#'
#' The Chernoff geom is used to create Chernoff-like visualisations in the shape of human faces.
#' By mapping to the relevant aesthetics, faces can appear to vary in happiness, anger, size and so on.
#'
#' @param mapping Set of aesthetic mappings created by \code{\link[ggplot2]{aes}} or
#'   \code{\link[ggplot2]{aes_}}. If specified and \code{inherit.aes = TRUE} (the
#'   default), is combined with the default mapping at the top level of the
#'   plot. You only need to supply \code{mapping} if there isn't a mapping
#'   defined for the plot.
#' @inheritParams ggplot2::geom_point
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
#' \item \code{nose}: logical. Draw a nose or not? Default is \code{FALSE}. Currently cannot be customised further.
#' }
#'
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, fill = Species)) +
#'   geom_chernoff()
#'
#' ggplot(data.frame(x = 1:4,
#'                   y = c(3:1, 2.5),
#'                   z = factor(1:4),
#'                   n = c(rep(FALSE, 3), TRUE)
#'                   )) +
#'     aes(x, y, fill = z, size = x, nose = n) +
#'     geom_chernoff()
#'
#' @references
#' Chernoff, H. (1973).
#' The use of faces to represent points in \emph{k}-dimensional space graphically.
#' \emph{Journal of the American Statistical Association, 68}(342), 361–368.
#'
#' @importFrom ggplot2 ggproto
#' @importFrom grid circleGrob rectGrob grobTree
#' @export geom_chernoff
geom_chernoff <- function(mapping = NULL, data = NULL, stat = "identity",
                          position = "identity", na.rm = FALSE, show.legend = NA,
                          inherit.aes = TRUE, ...) {
  ggplot2::layer(
                 geom = GeomChernoff, mapping = mapping,  data = data, stat = stat,
                 position = position, show.legend = show.legend, inherit.aes = inherit.aes,
                 params = list(na.rm = na.rm, ...)
                )
}

GeomChernoff <- ggplot2::ggproto("GeomChernoff", ggplot2::Geom,
  required_aes = c("x", "y"),
  default_aes = ggplot2::aes(colour = "black", fill = NA, size = 1, alpha = 1, nose = FALSE),
  draw_key = ggplot2::draw_key_rect,
  draw_panel = function(data, panel_scales, coord) {
      coords <- coord$transform(data, panel_scales)
      face <- grid::circleGrob(coords$x,
                               coords$y,
                               r = sqrt(coords$size) / 30,
                               gp = grid::gpar(col = coords$colour,
                                               fill = coords$fill)
                               )
      lefteye <- grid::circleGrob(coords$x - sqrt(coords$size) / 75,
                                  coords$y + sqrt(coords$size) / 150,
                                  r = sqrt(coords$size) / 300,
                                  gp = grid::gpar(col = coords$colour,
                                                  fill = coords$colour)
                                  )
      righteye <- grid::circleGrob(coords$x + sqrt(coords$size) / 75,
                                   coords$y + sqrt(coords$size) / 150,
                                   r = sqrt(coords$size) / 300,
                                   gp = grid::gpar(col = coords$colour,
                                                   fill = coords$colour)
                                   )
      nose <- grid::rectGrob(coords$x, coords$y,
                             width = sqrt(coords$size) * unit(0.002, 'npc'),
                             height = sqrt(coords$size) * unit(0.01, 'npc'),
                             gp = grid::gpar(col = NA,
                                             fill = ifelse(coords$nose, coords$colour, NA))
                             )
      grid::grobTree(face, nose, lefteye, righteye)
  }
)
