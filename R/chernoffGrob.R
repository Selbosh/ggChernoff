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
#' @param smile amount of smiling/frowning
#' @param brow eyebrow angle, to represent anger or concern
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
#' face <- chernoffGrob(.5, .5, size = 1e3, smile = -1, brow = 1, colour = 'navy', fill = 'lightblue')
#' grid::grid.newpage()
#' grid::grid.draw(face)
chernoffGrob <- function(x = .5, y = .5,
                          size = 1,
                          colour = 'black',
                          fill = NA,
                          alpha = 1,
                          smile = 1,
                          brow = NA,
                          nose = FALSE) {
  .pt <- 72.27 / 25.4
  faceGrob <- circleGrob(x, y, r = unit(sqrt(.5 * size * .pt), 'mm'))
  vp1 <- viewport(x = x, y = y,
                  width = grobWidth(faceGrob), height = grobHeight(faceGrob))
  eyesGrob <- circleGrob(rep(c(.3, +.7), each = length(x)),
                         .6,
                         r = 1/20,
                         gp = gpar(fill = colour),
                         vp = vp1)
  if (!is.na(brow)) {
    browGrob <- polylineGrob(x = c(.2, .4, .6, .8),
                             y = .75 + brow * c(+.05, -.05, -.05, +.05), # .7--.8
                             id = rep(1:2, each = 2),
                             gp = gpar(col = colour),
                             vp = vp1)
  } else browGrob <- nullGrob()
  noseGrob <- circleGrob(r = 1/15,
                         gp = gpar(col = ifelse(nose, colour, NA), fill = NA),
                         vp = vp1)
  mouthGrob <- bezierGrob(rep(.5, each = 4) + c(-.2, -.1, .1, .2),
                          rep(.3, each = 4) + smile * c(.1, -.05, -.05, .1),
                          gp = gpar(fill = colour),
                          id.lengths = rep(4, length(x)),
                          vp = vp1)
  grobTree(faceGrob, noseGrob, eyesGrob, browGrob, mouthGrob,
           gp = gpar(alpha = alpha, col = colour, fill = fill)
           )
}
