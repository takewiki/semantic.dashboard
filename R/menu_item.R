#' Create Semantic UI icon tag (alias for \code{uiicon} for compatibility with \code{shinydashboard})
#'
#' This creates an icon tag using Semantic UI styles.
#'
#' @param type A name of an icon. Look at http://semantic-ui.com/elements/icon.html for all possibilities.
#' @param ... Other arguments to be added as attributes of the tag (e.g. style, class etc.)
#'
#' @export
icon <- shiny.semantic::uiicon

#' Valid tab name should not containt dot character '.'.
#' @param name Tab name to validate.
validate_tab_name <- function(name) {
  if (grepl(".", name, fixed = TRUE)) {
    stop("tabName must not have a '.' in it.")
  }
}

#' Create a menu item.
#' @description Create a menu item corresponding to a tab.
#' @param text Text to show for the menu item.
#' @param ...	 This may consist of menuSubItems.
#' @param icon Icon of the menu item. (Optional)
#' @param tabName Id of the tab. Not compatible with href.
#' @param href A link address. Not compatible with tabName.
#' @param newtab If href is supplied, should the link open in a new browser tab?
#' @return A menu item that can be passed \code{\link[semantic.dashboard]{sidebarMenu}}
#' @export
#' @examples
#' menuItem(tabName = "plot_tab", text = "My plot", icon = icon("home"))
menu_item <- function(text, ..., icon = NULL, tabName = NULL, href = NULL, newtab = TRUE) {
  sub_items <- list(...)
  if (!is.null(href) + (!is.null(tabName) + (length(sub_items) > 0) != 1)) {
    stop("Must have either href, tabName, or sub-items (contained in ...).")
  }
  data_tab <- NULL
  target <- NULL
  isTabItem <- FALSE

  if (!is.null(tabName)) {
    validate_tab_name(tabName)
    isTabItem <- TRUE
    data_tab <- paste0("shiny-tab-", tabName)
    href <- paste0("#", data_tab)
  }
  else if (is.null(href)) {
    href <- "#"
  }
  else if (newtab) {
      target <- "_blank"
  }

  if (length(sub_items) == 0) {
    shiny::tags$a(class = "item", href = href, icon, text,
                  `data-tab` = data_tab,
                  `data-toggle` = if (isTabItem) "tab",
                  `data-value` = if (!is.null(tabName)) tabName,
                  target = target)
  } else {
    shiny::tags$div(class = "item",
      shiny::tags$div(class = "header", text),
      shiny::tags$div(class = "menu", sub_items)
    )
  }
}

#' @describeIn menu_item Create a menu item (alias for \code{manu_item} for compatibility with \code{shinydashboard})
#' @export
menuItem <- menu_item

#' @describeIn menu_item Create a menu item (alias for \code{manu_item} for compatibility with \code{shinydashboard})
#' @export
menuSubItem <- menu_item

#' Create a sidebar menu.
#' @description Create a sidebar menu with menu items.
#' @param ... Menu items.
#' @return A sidebar menu that can be passed \code{\link[semantic.dashboard]{dashboardSidebar}}
#' @export
#' @examples
#' sidebarMenu(
#'   menuItem(tabName = "plot_tab", text = "My plot", icon = icon("home")),
#'   menuItem(tabName = "table_tab", text = "My table", icon = icon("smile"))
#'   )
sidebar_menu <- function(...) {
  list(...)
}

#' @describeIn sidebar_menu Create a sidebar menu (alias for \code{sidebar_menu} for compatibility with \code{shinydashboard})
#' @export
sidebarMenu <- sidebar_menu
