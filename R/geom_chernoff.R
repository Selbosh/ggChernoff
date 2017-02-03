#' Chernoff faces in ggplot2
#'
#' The Chernoff geom is used to create data visualisations in the shape of human-like faces.
#' By mapping to the relevant aesthetics, faces can appear to vary in happiness, anger, size, colour and so on.
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
#' \item \code{smile}
#' \item \code{nose}
#' }
#' For details, see \code{\link{chernoffGrob}}.
#'
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, smile = Petal.Length, fill = Species)) +
#'   geom_chernoff()
#'
#' ggplot(data.frame(x = 1:4,
#'                   y = c(3:1, 2.5),
#'                   z = factor(1:4),
#'                   w = rnorm(4),
#'                   n = c(rep(FALSE, 3), TRUE)
#'                   )) +
#'     aes(x, y, fill = z, size = x, nose = n, smile = w) +
#'     geom_chernoff()
#'
#' @references
#' Chernoff, H. (1973).
#' The use of faces to represent points in \emph{k}-dimensional space graphically.
#' \emph{Journal of the American Statistical Association, 68}(342), 361–368.
#'
#' @seealso \code{\link{chernoffGrob}}
#'
#' @import ggplot2
#' @export geom_chernoff
geom_chernoff <- function(mapping = NULL, data = NULL, stat = "identity",
                          position = "identity", na.rm = FALSE, show.legend = NA,
                          inherit.aes = TRUE, ...) {
  layer(geom = GeomChernoff, mapping = mapping,  data = data, stat = stat,
        position = position, show.legend = show.legend, inherit.aes = inherit.aes,
        params = list(na.rm = na.rm, ...)
        )
}

GeomChernoff <- ggproto("GeomChernoff", ggplot2::Geom,
  required_aes = c("x", "y"),
  default_aes = aes(colour = "black", fill = NA, size = 1, alpha = 1, smile = 1, nose = FALSE),
  draw_key = ggplot2::draw_key_rect,
  draw_panel = function(data, panel_scales, coord) {
      coords <- coord$transform(data, panel_scales)
      if (diff(range(coords$smile)) == 0) {
        smile2 <- rep(1, length(coords$smile))
      } else {
        smile2 <- coords$smile - mean(coords$smile)
        smile2 <- smile2 / max(abs(smile2))
      }
      gl <- gTree()
      for (i in seq_along(coords$x)) {
        # Filthy hack: draw one whole face at a time
        # so overlapping faces are rendered correctly.
        gl <- with(coords,
              addGrob(gl, chernoffGrob(x[i],
                                       y[i],
                                       sqrt(size[i]) / 35,
                                       colour[i],
                                       fill[i],
                                       alpha[i],
                                       smile2[i],
                                       nose[i]))
              )
      }
      return(gl)
  }
)
