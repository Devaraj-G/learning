# NOTE: inside renv use renv::install() and not install.package()

#' Add titles
#'
#' @param x First number
#' @param y Second number
#'
#' @returns The sum of x and y
#' @export
#'
#' @examples add_numbers(2,4)
add_numbers <- function(x,y){
  x + y
  return(2*x + y)
}
