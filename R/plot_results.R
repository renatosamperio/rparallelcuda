# libraries:

if (FALSE) {

    library(ggplot2)
    library(gganimate)

    groups <- c('GPU', 'Intel known', 'Intel new', 'R with C++')
    values1 <- c(514.88, 1155.69, 4777.12, 5934.29)
    values2 <- c(706.60, 422.02, 1363.91, 1923.79)
    name <- "./inst/tmp/matrix-operations-gpu.gif"
}

plot_results <- \(groups, values1, values2, name) {

    # Make 2 basic states and concatenate them:
    a <- data.frame(paralllelism=groups, time=values1, frame=rep('a',length(groups)))
    b <- data.frame(paralllelism=groups, time=values2, frame=rep('b',length(groups)))
    data <- rbind(a,b)

    # Make a ggplot, but add frame=year: one image per year
    ggplot(data, aes(x=paralllelism, y=time, fill=paralllelism)) + 
        scale_x_discrete(guide = guide_axis(angle = 90)) +
        guides(fill="none") +
        geom_bar(stat='identity') +
        theme_bw() +
        # gganimate specific bits:
        transition_states(
            frame,
            transition_length = 2,
            state_length = 1
        ) +
        ease_aes('sine-in-out')

    # Save at gif:
    anim_save(name)

}