# EvolveImage
A package that evolves black and white images using JuliaLang.


## Requirements:

- [Julia REPL v0.6.X](https://julialang.org/downloads/) or an Html5 supporting browser (thanks to http://juliabox.com. Create an account, clone this repo and run the code on any device)
- Any flat black and white image.
- Ability to understand my messy code...

## Customizing your algorithm

The main function, `epoch`, takes as input a series of variables that can change the functioning of the algorithm:


`target` takes the target image. Either using `TestImages.jl` or any image from your computer using `FileIO`

`N` The number of children per generation

`percentage_best` How many percent of children to "save"

`sigma` The noise in the mutation. (I recommend values between 0.01 and 0.08)

`prob_m` The probability of mutation.

`nr_epochs` The number of epochs (or generations) to run

`crossover` "true" uses sexuate reproduction, "false" uses asexual reproduction

`hillclimbing` "true" works better at avoiding *local maxima* but runs slower

`sigma_hc` is the variance in the hillclimbing (I recommend values between 0.01 and 0.08)


### How to visualize
At the end of any epoch you can use the functionality of (Images.Jl)[https://github.com/JuliaImages/Images.jl] to plot.
>using Images

>colorview(Gray, pop[1,:,:])

# Have fun!
![noise](/images/noise.png)
