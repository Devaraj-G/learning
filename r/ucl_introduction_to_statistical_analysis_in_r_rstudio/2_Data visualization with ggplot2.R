# library(ggplot2)
# library(ratdat)

?complete_old
View(complete_old)
str(complete_old)

# ggplot(data = <DATA.FRAME>, mapping = aes(<MAPPINGS.TO.COORDINATES>) + geom_function()


ggplot(data = complete_old)
ggplot(data = complete_old, mapping= aes(x = weight, y = hindfoot_length))
ggplot(data = complete_old) +
  aes(x = weight, y = hindfoot_length)
ggplot(data = complete_old, mapping= aes(x = weight, y = hindfoot_length)) + 
  geom_point()
ggplot(data = complete_old, mapping= aes(x = weight, y = hindfoot_length)) + 
  geom_point(alpha = 0.2)
ggplot(data = complete_old, mapping= aes(x = weight, y = hindfoot_length)) + 
  geom_point(alpha = 0.2, color = 'blue')

# let's add another variable: in mapping (color/shape/size)
ggplot(data = complete_old, mapping= aes(x = weight, y = hindfoot_length, color = month)) + 
  geom_point(alpha = 0.2) # colors are continuous
ggplot(data = complete_old, mapping= aes(x = weight, y = hindfoot_length, color = factor(month))) + 
  geom_point(alpha = 0.2) # colors are discrete
ggplot(data = complete_old, mapping= aes(x = weight, y = hindfoot_length, shape = month)) + 
  geom_point(alpha = 0.2) # error as month is continuous while shape is discrete
ggplot(data = complete_old, mapping= aes(x = weight, y = hindfoot_length, shape = factor(month))) + 
  geom_point(alpha = 0.2) # works well
ggplot(data = complete_old, mapping= aes(x = weight, y = hindfoot_length, size = factor(month))) + 
  geom_point(alpha = 0.2) # discrete size, works but warned
ggplot(data = complete_old, mapping= aes(x = weight, y = hindfoot_length, size = month)) + 
  geom_point(alpha = 0.2) # continuous is better
ggplot(data = complete_old, mapping= aes(x = weight, y = hindfoot_length, color = month)) + 
  geom_point(alpha = 0.2, color = 'blue') # sequential overwriting
ggplot(data = complete_old, mapping= aes(x = weight, y = hindfoot_length, color = species)) + 
  geom_point() # sequential overwriting



ggplot(data = complete_old, mapping = aes(x = species, y = hindfoot_length)) + 
  geom_boxplot()

myplot = ggplot(data = complete_old, 
       mapping = aes(x = plot_type, 
                     y = hindfoot_length,
                     color = plot_type)) +
  geom_jitter(alpha = 0.2) +
  geom_violin(fill = "white")


myplot +
  theme_bw() +
  theme(axis.title = element_text(size = 14), 
        legend.position = "none", 
        panel.grid.major.x = element_blank()) +
  labs(title = "Rodent size by plot type",
       x = "Plot type",
       y = "Hindfoot length (mm)",
       color = "Plot type") +
  facet_wrap(~sex, ncol = 1)
