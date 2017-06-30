#' Draw a screaming face
#'
#' Generates a face in the style of Edvard Munch's 1893 painting \emph{The Scream}.
#' Adjusting parameters of the function can make the expression more or less dramatic.
#'
#' @param x horizontal position
#' @param y vertical position.
#' @param size area of the face
#' @param colour colour of outlines and features
#' @param alpha transparency, where 0 is transparent and 1 is opaque
#' @param scream the higher this value, the more dramatic the expression
#'
#' @return A \code{\link[grid]{grobTree}} object.
#'
#' @references
#' Murrell, Paul (2012). It's Not What You Draw, It's What You Don't Draw. \emph{R Journal} 4/2. \url{https://journal.r-project.org/archive/2012-2/RJournal_2012-2_Murrell2.pdf}
#'
#' Munch, Edvard (1893). \emph{Skrik (Der Schrei der Natur)}.
#'
#' @examples
#' grid::grid.newpage()
#' grid::grid.draw(screamGrob(.7, .7, size = 50))
#' grid::grid.draw(screamGrob(size = 50, fill = 'goldenrod1'))
#'
#' @seealso \code{\link{chernoffGrob}}
#' @import grid
#' @importFrom gridExtra ellipseGrob
#' @export
screamGrob <- function(x = .5, y = .5,
                       size = 4,
                       colour = 'black',
                       fill = NA,
                       alpha = 1,
                       scream = 1) {
  .pt <- 72.27 / 25.4
  vp <- viewport(x = x, y = y,
                 width = unit(sqrt(size * .pt), 'mm'),
                 height = unit(sqrt(size * .pt), 'mm'),
                 default.units = 'npc')
  facex <- c(.1, .1, .9, .9, # Cranium
             .9, .9, .7, .7, # Right cheek
             .7, .7, .3, .3, # Chin
             .3, .3, .1, .1) # Left cheek
  facey <- c(.7,  1,  1, .7, # Cranium
             .7, .5, .6, .3, # Right cheek
             .3, .1, .1, .3, # Chin
             .3, .6, .5, .7) # Left cheek
  faceShape <- bezierGrob(facex, facey,
                          id.lengths = rep(4, 4),
                          default.units = 'npc',
                          vp = vp)
  facePoints <- do.call(rbind, bezierPoints(faceShape))
  faceGrob <- polygonGrob(convertUnit(unit(unlist(facePoints[, 1]), 'inches'), 'npc'),
                          convertUnit(unit(unlist(facePoints[, 2]), 'inches'), 'npc'),
                          gp = gpar(colour = colour, fill = fill),
                          vp = vp)
  eyesGrob <- circleGrob(c(.3, .7),
                         c(.7, .7) * 2,
                         r = .1,
                         default.units = 'npc',
                         gp = gpar(colour = colour, fill = colour),
                         vp = vp)
  mouthGrob <- gridExtra::ellipseGrob(.5,
                                      .35 * 2,
                                      angle = 0,
                                      size = .1,
                                      position.units = 'npc',
                                      size.units = 'npc',
                                      ar = .6,
                                      gp = gpar(colour = colour, fill = colour),
                                      vp = vp)
  grobTree(faceGrob, eyesGrob, mouthGrob)
}
