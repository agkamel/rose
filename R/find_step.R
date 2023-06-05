find_step <- function(df, step_type = "all", collapse = TRUE) {

  if (ncol(df) != 2) stop("Must have two cols")
  names(df) <- c("element", "dependency")

  # Step one
  step_i <- 1

  filter_step <- df %>%
    dplyr::filter(is.na(dependency))

  filter_step <- filter_step %>%
    dplyr::mutate(step = rep(step_i, times = nrow(filter_step)))

  final_df <- filter_step
  last_elements <- filter_step$element


  while (nrow(dplyr::anti_join(df, final_df, by = c("element", "dependency"))) != 0) {
    step_i <- step_i + 1

    filter_step <-
      df %>%
      dplyr::anti_join(final_df, by = c("element", "dependency")) %>%
      dplyr::filter(dependency %in% last_elements)

    filter_step <- filter_step %>%
      dplyr::mutate(step = rep(step_i, times = nrow(filter_step)))

    final_df <- dplyr::bind_rows(final_df, filter_step)
    last_elements <- filter_step$element
  }


  if (step_type == "all") {
    sum_df <- final_df %>%
      dplyr::select(element, step)
  } else if (step_type == "max") {
    sum_df <- final_df %>%
      dplyr::group_by(element) %>%
      dplyr::summarise(step = max(step))
  } else if (step_type == "min") {
    sum_df <- final_df %>%
      dplyr::group_by(element) %>%
      dplyr::summarise(step = min(step))
  }


  if (collapse == TRUE) {
    return(sum_df %>%
             dplyr::select(step) %>%
             dplyr::pull())
  } else {
    return(sum_df)
  }
}
