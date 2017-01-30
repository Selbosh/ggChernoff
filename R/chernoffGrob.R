#' Draw a smiley face
#'
#' Uses \code{\link[grid]{Grid}} graphics to draw a face.
#'
#' @param x horizontal position
#' @param y vertical position
#' @param size area of the face
#' @param colour colour of outlines and features
#' @param fill fill colour
#' @param alpha transparency, where 0 is transparent and 1 is opaque
#' @param smile amount of smiling/frowning. Currently ignored
#' @param nose logical. Adds a nose to the face
#'
#' @return A \code{\link[grid]{grobTree}} object.
#'
#' @seealso \code{\link{geom_chernoff}}
#'
#' @import grid
#' @export
#'
#' @examples
#' face <- chernoffGrob(.5, .5, colour = 'navy', fill = 'coral')
#' grid::grid.newpage()
#' grid::grid.draw(face)
chernoffGrob <- function(x = .5, y = .5,
                         size = .5,
                         colour = 'black',
                         fill = NA,
                         alpha = 1,
                         smile = 1,
                         nose = FALSE) {
    faceGrob <- circleGrob(x, y,
                           r = size,
                           gp = gpar(col = colour, fill = fill)
    )
    eyesGrob <- circleGrob(x + rep(c(-1, +1) * size / 2.5,
                                   each = length(x)),
                           y + size / 10,
                           r = size / 10,
                           gp = gpar(col = colour, fill = colour)
    )
    noseGrob <- rectGrob(x, y,
                         width = unit(size / 10, 'npc'),
                         height = unit(size / 5, 'npc'),
                         gp = gpar(col = NA, fill = ifelse(nose, colour, NA))
    )
    mouthGrob <- bezierGrob(rep(x, each = 4) + c(-1, -.5, .5, 1) * rep(size, each = 4) / 3,
                            rep(y, each = 4) + c(-1, -2, -2, -1) * rep(size, each = 4) / 3,
                            arrow = arrow(length = unit(0.005, 'npc'), type = 'closed'),
                            gp = gpar(col = colour, fill = colour),
                            id.lengths = rep(4, length(x))
    )
    grobTree(faceGrob, noseGrob, eyesGrob, mouthGrob)
}
